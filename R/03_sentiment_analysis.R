# 📦 Phân tích cảm xúc với lexicon 'bing'
check_and_load()  # Nạp packages

sentiment_words <- tidy_words %>%
  inner_join(get_sentiments("bing"), by = "word") %>%
  count(sentiment, sort = TRUE)

# 📋 Bảng cảm xúc
bang_cam_xuc <- ft_vn(sentiment_words)

# 📊 Biểu đồ cảm xúc
bieu_do_cam_xuc <- sentiment_words %>%
  ggplot(aes(x = sentiment, y = n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = n), vjust = -0.3, size = 5) +
  scale_fill_manual(values = c("positive" = "#2ECC71", "negative" = "#E74C3C")) +
  labs(
    title = "Phân tích cảm xúc trong văn bản",
    x = "Loại cảm xúc", y = "Số từ"
  ) +
  theme_minimal(base_family = "Times New Roman")

# 🧠 Nhận xét bảng
nhan_xet_bang_cx <- glue::glue(
  "Tổng cộng có {sum(sentiment_words$n)} từ mang sắc thái cảm xúc, ",
  "trong đó có {sentiment_words$n[sentiment_words$sentiment == 'positive']} từ tích cực ",
  "và {sentiment_words$n[sentiment_words$sentiment == 'negative']} từ tiêu cực."
)

# 📌 Nhận xét biểu đồ
nhan_xet_bieu_do_cx <- glue::glue(
  "Biểu đồ cho thấy tỉ lệ từ tích cực chiếm khoảng {round(100 * sentiment_words$n[sentiment_words$sentiment == 'positive'] / sum(sentiment_words$n), 1)}%, ",
  "cao hơn so với từ tiêu cực, phản ánh giọng văn lạc quan và tích cực trong tác phẩm."
)

# ✍️ Bàn luận inline chi tiết
ban_luan_cx <- glue::glue(
  "Phân tích cảm xúc cho thấy tác phẩm *Around the World in 80 Days* chứa phần lớn từ ngữ mang sắc thái tích cực, ",
  "với tỉ lệ lên đến {round(100 * sentiment_words$n[sentiment_words$sentiment == 'positive'] / sum(sentiment_words$n), 1)}%. ",
  "Điều này phản ánh bút pháp đầy hy vọng và hướng ngoại của Jules Verne trong việc miêu tả hành trình mạo hiểm vòng quanh thế giới. ",
  "Tuy vẫn có sự xuất hiện của từ tiêu cực (chiếm khoảng {round(100 * sentiment_words$n[sentiment_words$sentiment == 'negative'] / sum(sentiment_words$n), 1)}%), ",
  "nhưng nhìn chung, giọng văn xuyên suốt thiên về sự hào hứng, năng động và tích cực – đặc trưng cho thể loại văn học phiêu lưu thời kỳ đầu thế kỷ XX."
)
