# 📄 01_load_clean_text.R – Tải và làm sạch văn bản Jules Verne

# 🎯 Nạp gói cần thiết
pacman::p_load(gutenbergr, dplyr, stringr, readr, here)

# 📥 Tải văn bản từ Gutenberg (ID 103)
raw_text <- gutenberg_download(103, mirror = "http://mirrors.xmission.com/gutenberg/")

# 🧼 Làm sạch văn bản: loại bỏ phần đầu/cuối Project Gutenberg
clean_text <- raw_text %>%
  mutate(text = str_squish(text)) %>%       # Loại khoảng trắng thừa
  filter(!text == "") %>%                   # Bỏ dòng trống
  slice(50:(n() - 350)) %>%                 # Bỏ phần đầu/cuối của file Gutenberg
  mutate(line = row_number()) %>%
  select(line, text)

# 💾 Ghi ra file CSV trong thư mục /data
write_csv(clean_text, here("data", "around_the_world_clean.csv"))
