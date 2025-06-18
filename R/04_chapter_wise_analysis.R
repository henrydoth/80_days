# 📄 chapter_wise_analysis.R – Phân tích từ phổ biến theo từng chương Jules Verne

# 🎯 Yêu cầu gói
pacman::p_load(dplyr, tidytext, ggplot2, flextable, stringr, glue)

# 🧾 Dữ liệu đầu vào: chaptered_text đã được tạo từ 01_load_clean_text.R
# Giả định: biến chaptered_text có 2 cột: chapter, text

# 🧠 Tách từ và loại bỏ stopwords
chapter_words <- chaptered_text %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

# 📊 Đếm từ phổ biến theo từng chương (Top 10)
top_words_by_chapter <- chapter_words %>%
  count(chapter, word, sort = TRUE) %>%
  group_by(chapter) %>%
  slice_max(n, n = 10) %>%
  ungroup()

# 📋 Bảng flextable
ft_top_words <- top_words_by_chapter %>%
  rename("Chương" = chapter, "Từ phổ biến" = word, "Tần suất" = n) %>%
  flextable() %>%
  autofit() %>%
  fontsize(size = 11, part = "all") %>%
  font(fontname = "Times New Roman", part = "all") %>%
  set_table_properties(layout = "autofit", width = 0.9)

# 📈 Biểu đồ ggplot2
plot_top_words <- ggplot(top_words_by_chapter, aes(x = reorder_within(word, n, chapter), y = n, fill = chapter)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~chapter, scales = "free_y") +
  scale_x_reordered() +
  labs(x = "Từ", y = "Tần suất", title = "Top 10 từ phổ biến theo từng chương") +
  coord_flip() +
  theme_minimal(base_family = "Times New Roman", base_size = 11)

# 🗣️ Nhận xét tự động ví dụ cho chương đầu tiên
summary_inline <- top_words_by_chapter %>%
  filter(chapter == first(chapter)) %>%
  slice_max(n, n = 1) %>%
  mutate(glue_text = glue("Trong {chapter}, từ phổ biến nhất là '{word}' với {n} lần xuất hiện.")) %>%
  pull(glue_text)
