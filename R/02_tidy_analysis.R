options(repos = c(CRAN = "https://cloud.r-project.org"))

source(here::here("R", "packages.R"))
check_and_load()


# 📂 Đọc dữ liệu văn bản sạch
text_lines <- readr::read_csv(here::here("data", "around_the_world_clean.csv"), show_col_types = FALSE)

# 🔤 Tách từ (tokenize) và loại bỏ stop words
tidy_words <- text_lines %>%
  tidytext::unnest_tokens(word, text) %>%
  dplyr::anti_join(tidytext::stop_words, by = "word") %>%
  dplyr::count(word, sort = TRUE)

# 🏆 Lấy Top 10 từ phổ biến
top_words <- tidy_words %>%
  dplyr::slice_max(order_by = n, n = 10)

# 💾 (Tuỳ chọn) Ghi lại CSV để kiểm tra
readr::write_csv(top_words, here::here("data", "top_words.csv"))

# 📋 Bảng flextable hiển thị top từ
bang_top_words <- ft_vn(top_words)

# 📊 Biểu đồ ggplot top từ
bieu_do_top_words <- top_words %>%
  ggplot(aes(x = reorder(word, n), y = n)) +
  geom_col(fill = "#2C3E50") +
  coord_flip() +
  labs(
    title = "Top 10 từ phổ biến trong văn bản",
    x = "Từ", y = "Tần suất"
  ) +
  theme_minimal()

# 🧠 Nhận xét bảng
nhan_xet_bang_top_words <- glue::glue(
  "Từ xuất hiện nhiều nhất trong văn bản là '{top_words$word[1]}' với {top_words$n[1]} lần, ",
  "cho thấy đây là từ khóa then chốt phản ánh nội dung chính của tác phẩm."
)

# 📌 Nhận xét biểu đồ
nhan_xet_bieu_do_top_words <- glue::glue(
  "Biểu đồ thể hiện rõ sự áp đảo của từ '{top_words$word[1]}', ",
  "theo sau là '{top_words$word[2]}' và '{top_words$word[3]}'. ",
  "Điều này phản ánh chủ đề xoay quanh hành trình, nhân vật và hành động."
)

# ✍️ Bàn luận chi tiết
ban_luan_top_words <- glue::glue(
  "Qua phân tích tần suất từ, chúng tôi nhận thấy sự xuất hiện nổi bật của các từ như ",
  "'{top_words$word[1]}', '{top_words$word[2]}' và '{top_words$word[3]}'. Đây đều là những từ khóa ",
  "liên quan mật thiết đến nội dung cốt lõi của tác phẩm *Around the World in 80 Days*. ",
  "Việc các từ này xuất hiện với tần suất cao cho thấy văn bản tập trung mô tả hành trình, ",
  "các hành động và môi trường xung quanh nhân vật chính. Điều này hoàn toàn phù hợp với đặc trưng thể loại ",
  "phiêu lưu và phản ánh cách xây dựng không gian – thời gian trong tiểu thuyết của Jules Verne."
)

# 📦 Phân tích từ khóa theo nhóm chủ đề

# 🎯 Định nghĩa nhóm từ khóa theo ngữ nghĩa
tu_khoa_chia_nhom <- tidy_words %>%
  dplyr::filter(word %in% c(
    # Nhân vật chính
    "fogg", "passepartout", "fix", "aouda", "phileas",
    # Chủ đề hành động & kỹ thuật
    "train", "steam", "ship", "master", "passport",
    # Không gian – thời gian
    "time", "day", "journey", "mile", "london", "india", "america"
  )) %>%
  dplyr::mutate(chu_de = dplyr::case_when(
    word %in% c("fogg", "passepartout", "fix", "aouda", "phileas") ~ "Nhân vật",
    word %in% c("train", "steam", "ship", "master", "passport") ~ "Kỹ thuật – Hành động",
    word %in% c("time", "day", "journey", "mile") ~ "Thời gian",
    word %in% c("london", "india", "america") ~ "Không gian",
    TRUE ~ "Khác"
  ))

# 📋 Bảng từ theo chủ đề
bang_tu_khoa_nhom <- flextable::flextable(
  tu_khoa_chia_nhom %>%
    dplyr::group_by(chu_de, word) %>%
    dplyr::summarise(n = sum(n), .groups = "drop") %>%
    dplyr::arrange(desc(n))
)

# 📊 Biểu đồ từ khóa theo chủ đề
bieu_do_tu_khoa_nhom <- tu_khoa_chia_nhom %>%
  dplyr::group_by(chu_de, word) %>%
  dplyr::summarise(n = sum(n), .groups = "drop") %>%
  ggplot(aes(x = reorder(word, n), y = n, fill = chu_de)) +
  geom_col(show.legend = TRUE) +
  coord_flip() +
  labs(
    title = "Tần suất từ khóa theo chủ đề",
    x = "Từ khóa", y = "Tần suất"
  ) +
  theme_minimal(base_family = "Times New Roman")

# 🧠 Nhận xét tự động
nhan_xet_tu_khoa_nhom <- glue::glue(
  "Từ khóa xuất hiện nhiều nhất thuộc nhóm '{tu_khoa_chia_nhom$chu_de[1]}' là ",
  "'{tu_khoa_chia_nhom$word[1]}' với {tu_khoa_chia_nhom$n[1]} lần. ",
  "Các nhóm từ như 'Nhân vật', 'Kỹ thuật – Hành động' và 'Thời gian' phản ánh rõ cấu trúc ",
  "và nội dung xoay quanh hành trình vượt thời gian, không gian trong tác phẩm."
)
