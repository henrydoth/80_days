# 📄 01_load_clean_text.R – Tải và làm sạch văn bản Jules Verne

# 🎯 Nạp gói cần thiết
pacman::p_load(gutenbergr, dplyr, stringr, readr, here)

# ✏️ Hàm chuyển số La Mã sang số thường (thay cho package roman)
roman_to_integer <- function(roman) {
  roman_vals <- c(I = 1, V = 5, X = 10, L = 50, C = 100, D = 500, M = 1000)
  roman <- toupper(roman)
  chars <- strsplit(roman, "")[[1]]
  values <- roman_vals[chars]
  
  total <- 0
  i <- 1
  while (i <= length(values)) {
    if (i < length(values) && values[i] < values[i + 1]) {
      total <- total + (values[i + 1] - values[i])
      i <- i + 2
    } else {
      total <- total + values[i]
      i <- i + 1
    }
  }
  return(total)
}

# 📥 Tải văn bản từ Gutenberg (ID 103)
raw_text <- gutenberg_download(103, mirror = "http://mirrors.xmission.com/gutenberg/")

# 🧼 Làm sạch văn bản: loại bỏ phần đầu/cuối Project Gutenberg
clean_text <- raw_text %>%
  mutate(text = str_squish(text)) %>%       # Loại khoảng trắng thừa
  filter(text != "") %>%                    # Bỏ dòng trống
  slice(50:(n() - 350)) %>%                 # Bỏ phần đầu/cuối của file Gutenberg
  mutate(line = row_number()) %>%
  select(line, text)

# 💾 Ghi ra file CSV trong thư mục /data
write_csv(clean_text, here("data", "around_the_world_clean.csv"), na = "")

# 📥 Đọc văn bản làm sạch
clean_text <- read_csv(here("data", "around_the_world_clean.csv"), show_col_types = FALSE)

# 🧠 Nhận diện dòng là tiêu đề chương (ví dụ: CHAPTER III.)
chaptered_text <- clean_text %>%
  mutate(
    is_chapter = str_detect(text, regex("^CHAPTER\\s+[IVXLCDM]+\\.?$", ignore_case = TRUE)),
    chapter_roman = if_else(
      is_chapter,
      str_extract(text, regex("^CHAPTER\\s+([IVXLCDM]+)", ignore_case = TRUE)) %>%
        str_remove("CHAPTER\\s+") %>%
        toupper(),
      NA_character_
    ),
    chapter_number = if_else(
      !is.na(chapter_roman),
      sapply(chapter_roman, roman_to_integer),
      NA_real_
    )
  ) %>%
  mutate(chapter_id = cumsum(!is.na(chapter_number))) %>%
  filter(chapter_id > 0) %>%
  group_by(chapter_id) %>%
  mutate(chapter = paste0("Chapter ", first(chapter_number))) %>%
  ungroup() %>%
  select(chapter, text)

# 💾 Ghi kết quả ra file CSV
write_csv(chaptered_text, here("data", "around_world_by_chapter.csv"), na = "")
