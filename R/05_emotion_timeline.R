# 📆 05_emotion_timeline.R – Biểu đồ timeline cảm xúc theo chương 📘🧠

# --- Nạp gói cần thiết ---
pacman::p_load(dplyr, ggplot2, readr, here, stringr, tidytext, glue, flextable)

# --- Đọc dữ liệu văn bản đã chia theo chương ---
chapter_df <- read_csv(here("data", "around_world_by_chapter.csv"), show_col_types = FALSE) %>%
  mutate(chapter_num = str_extract(chapter, "\\d+") %>% as.integer())

# --- Gán điểm cảm xúc bằng lexicon 'bing' ---
sentiment_by_word <- chapter_df %>%
  unnest_tokens(word, text) %>%
  inner_join(get_sentiments("bing"), by = "word") %>%
  mutate(sentiment_score = ifelse(sentiment == "positive", 1, -1))

# --- Tính điểm cảm xúc trung bình theo chương ---
sentiment_summary <- sentiment_by_word %>%
  group_by(chapter_num) %>%
  summarise(
    n = n(),
    net_sentiment = sum(sentiment_score),
    avg_sentiment = mean(sentiment_score),
    .groups = "drop"
  )

# --- Vẽ biểu đồ timeline cảm xúc ---
bieu_do_timeline_cx <- ggplot(sentiment_summary, aes(x = chapter_num, y = avg_sentiment)) +
  geom_line(size = 1, color = "steelblue") +
  geom_point(size = 2, color = "darkred") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  labs(
    title = "Biểu đồ timeline cảm xúc theo chương 📖",
    subtitle = "Điểm cảm xúc trung bình theo lexicon 'bing'",
    x = "Chương",
    y = "Điểm cảm xúc trung bình"
  ) +
  theme_minimal(base_family = "Times New Roman", base_size = 13)

# --- Tạo nhận xét inline để chèn Quarto ---
nhan_xet_timeline <- sentiment_summary %>%
  summarise(
    min_val = round(min(avg_sentiment), 2),
    max_val = round(max(avg_sentiment), 2),
    min_chap = chapter_num[which.min(avg_sentiment)],
    max_chap = chapter_num[which.max(avg_sentiment)]
  ) %>%
  glue_data(
    "Chương có cảm xúc tích cự nhất là chương {max_chap} (trung bình {max_val}), ",
    "trong khi chương {min_chap} có xu hướng tiêu cực hơn (trung bình {min_val}). ",
    "Điều này phản ánh biến động cảm xúc của hành trình trong tác phẩm."
  )

# --- 📋 Bảng flextable cảm xúc theo chương ---
bang_timeline_cx <- sentiment_summary %>%
  mutate(
    net_sentiment = round(net_sentiment, 0),
    avg_sentiment = round(avg_sentiment, 2)
  ) %>%
  rename(
    "Chương" = chapter_num,
    "Số từ cảm xúc" = n,
    "Tổng điểm cảm xúc" = net_sentiment,
    "Điểm trung bình" = avg_sentiment
  ) %>%
  flextable::flextable() %>%
  flextable::set_table_properties(layout = "autofit") %>%
  flextable::fontsize(size = 13, part = "all") %>%
  flextable::font(fontname = "Times New Roman", part = "all")

# --- 📌 Nhận xét bảng cảm xúc theo chương (inline) ---
nhan_xet_bang_timeline <- sentiment_summary %>%
  summarise(
    tb = round(mean(avg_sentiment), 2),
    max_val = round(max(avg_sentiment), 2),
    min_val = round(min(avg_sentiment), 2)
  ) %>%
  glue::glue_data(
    "Trung bình các chương có điểm cảm xúc là {tb}. ",
    "Chương tích cực nhất đạt {max_val} điểm, trong khi chương thấp nhất là {min_val}."
  )
