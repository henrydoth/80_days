# 📦 03_sentiment_analysis.R – Phân tích cảm xúc với lexicon 'bing'

# 🎯 Nạp gói cần thiết
pacman::p_load(tidytext, dplyr, ggplot2, glue, flextable, here, readr)

# 📂 Đọc dữ liệu văn bản đã làm sạch
text_lines <- read_csv(here("data", "around_the_world_clean.csv"), show_col_types = FALSE)

# 🔤 Tách từ và loại bỏ stop words
tidy_words <- text_lines %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words, by = "word") %>%
  count(word, sort = TRUE)

# 💬 Gán cảm xúc với lexicon 'bing'
sentiment_words <- tidy_words %>%
  inner_join(get_sentiments("bing"), by = "word") %>%
  count(sentiment, sort = TRUE)

# 📋 Tạo bảng flextable
ft_vn <- function(df) {
  df %>%
    flextable() %>%
    set_table_properties(layout = "autofit") %>%
    fontsize(size = 13) %>%
    font(fontname = "Times New Roman", part = "all")
}
bang_cam_xuc <- sentiment_words %>% ft_vn()

# 📊 Biểu đồ ggplot
bieu_do_cam_xuc <- sentiment_words %>%
  ggplot(aes(x = sentiment, y = n, fill = sentiment)) +
  geom_col(width = 0.5, show.legend = FALSE) +
  geom_text(aes(label = n), vjust = -0.3, size = 5, family = "Times New Roman") +
  scale_fill_manual(values = c("positive" = "#2ECC71", "negative" = "#E74C3C")) +
  labs(
    title = "Phân tích cảm xúc trong văn bản",
    x = "Loại cảm xúc", y = "Tần suất"
  ) +
  theme_minimal(base_family = "Times New Roman")

# 🧠 Nhận xét bảng
nhan_xet_bang_cx <- sentiment_words %>%
  summarise(
    tong = sum(n),
    pos = n[sentiment == "positive"],
    neg = n[sentiment == "negative"]
  ) %>%
  glue_data(
    "Tổng cộng có {tong} từ mang sắc thái cảm xúc: ",
    "{pos} từ tích cực và {neg} từ tiêu cực, phản ánh rõ nét cảm xúc chủ đạo trong tác phẩm."
  )

# 📌 Nhận xét biểu đồ
nhan_xet_bieu_do_cx <- sentiment_words %>%
  summarise(
    pos = n[sentiment == "positive"],
    neg = n[sentiment == "negative"],
    tong = sum(n),
    ty_le_pos = round(100 * pos / tong, 1),
    ty_le_neg = round(100 * neg / tong, 1)
  ) %>%
  glue_data(
    "Biểu đồ cho thấy cảm xúc tích cực chiếm {ty_le_pos}%, ",
    "cao hơn so với tiêu cực ({ty_le_neg}%), cho thấy giọng văn thiên về lạc quan, mạo hiểm và hào hứng."
  )

# ✍️ Bàn luận chi tiết
ban_luan_cx <- sentiment_words %>%
  summarise(
    pos = n[sentiment == "positive"],
    neg = n[sentiment == "negative"],
    tong = sum(n),
    ty_le_pos = round(100 * pos / tong, 1),
    ty_le_neg = round(100 * neg / tong, 1)
  ) %>%
  glue_data(
    "Từ kết quả phân tích, có thể thấy rằng *Around the World in 80 Days* của Jules Verne sử dụng tới {ty_le_pos}% từ tích cực, ",
    "phản ánh phong cách kể chuyện lạc quan, tràn đầy hy vọng về hành trình khám phá thế giới. ",
    "Số lượng từ tiêu cực chỉ chiếm {ty_le_neg}%, cho thấy yếu tố xung đột hoặc căng thẳng được sử dụng vừa đủ để tạo hấp dẫn, ",
    "nhưng không làm lu mờ tinh thần tích cực chủ đạo. Đây là đặc trưng nổi bật của văn học phiêu lưu thế kỷ XIX."
  )
