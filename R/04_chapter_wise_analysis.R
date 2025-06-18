# 📄 chapter_wise_analysis.R – Phân tích từ phổ biến theo từng chương

# 🎯 Gói cần thiết
pacman::p_load(dplyr, tidytext, ggplot2, flextable, stringr, glue)

# 🧾 Giả định: chaptered_text với cột chapter (chuỗi "Chapter 1",...) và text

# 🧠 Tách từ và loại bỏ stopwords
chapter_words <- chaptered_text %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

# 💠 Trích xuất số thứ tự chương, lưu vào chapter_num (numeric)
chapter_words <- chapter_words %>%
  mutate(chapter_num = as.integer(str_extract(chapter, "\\d+")))

# 📊 Tính Top 3 từ theo mỗi chương rồi sắp xếp theo chapter_num
top_words_by_chapter <- chapter_words %>%
  count(chapter, chapter_num, word, sort = TRUE) %>%
  group_by(chapter, chapter_num) %>%
  slice_max(n, n = 3) %>%
  ungroup() %>%
  arrange(chapter_num, desc(n))

# 📋 Bảng flextable với merge cột chương
ft_top_words <- top_words_by_chapter %>%
  rename(
    `Chương`       = chapter,
    `Từ phổ biến` = word,
    `Tần suất`     = n
  ) %>%
  flextable() %>%
  merge_v(j = "Chương") %>%
  autofit() %>%
  fontsize(size = 11, part = "all") %>%
  font(fontname = "Times New Roman", part = "all") %>%
  set_table_properties(layout = "autofit", width = 0.9)

# 📈 Biểu đồ ggplot theo thứ tự chapter_num
plot_top_words <- top_words_by_chapter %>%
  mutate(word = reorder_within(word, n, chapter_num)) %>%
  ggplot(aes(x = word, y = n, fill = factor(chapter_num))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ chapter, scales = "free_y") +
  scale_x_reordered() +
  coord_flip() +
  labs(
    x = "Từ",
    y = "Tần suất",
    title = "Top 3 từ phổ biến theo từng chương (sắp xếp theo thứ tự chương)"
  ) +
  theme_minimal(base_family = "Times New Roman", base_size = 11)

# 🗣 Nhận xét tự động chương đầu tiên
summary_inline <- top_words_by_chapter %>%
  filter(chapter_num == min(chapter_num)) %>%
  slice_max(n, n = 1) %>%
  mutate(glue_text = glue("Trong {chapter}, từ phổ biến nhất là '{word}' với {n} lần.")) %>%
  pull(glue_text)

# 🎯 Xuất Word ví dụ qua officer (nếu cần)
# library(officer)
# doc <- read_docx() %>%
#   body_add_par("Top 3 từ/chương", style = "heading 1") %>%
#   body_add_flextable(ft_top_words) %>%
#   body_add_par(summary_inline)
# print(doc, target = "chapter_top3.docx")
