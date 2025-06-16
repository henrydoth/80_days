# run_all.R — Chạy toàn bộ pipeline phân tích cho dự án 80_days 📊

# Nạp packages và thiết lập mặc định 📦
source(here::here("R", "packages.R"))
message("✅ Đã nạp packages!")

# Thiết lập các thông số chung (theme, option...) ⚙️
source(here::here("R", "00_setup.R"))
message("🛠️ Đã thiết lập thông số mặc định!")

# Bước 1: Xử lý dữ liệu văn bản 🧹
if (askYesNo("👉 Chạy bước 1: Nạp & làm sạch dữ liệu văn bản?")) {
  source(here::here("R", "01_load_clean_text.R"))
  message("📂 Đã xử lý dữ liệu văn bản!")
}

# Bước 2: Phân tích dữ liệu 🧠
if (askYesNo("👉 Chạy bước 2: Phân tích dữ liệu (tidy analysis)?")) {
  source(here::here("R", "02_tidy_analysis.R"))
  message("📊 Đã hoàn tất phân tích dữ liệu tidy!")
}

# Bước 3: Kết xuất báo cáo Word bằng Quarto 📄
if (askYesNo("📝 Render file Word từ Quarto?")) {
  quarto::quarto_render(
    input = here::here("80_quato_words_output.qmd"),
    output_format = "docx"
  )
  message("📄 Đã tạo báo cáo Word từ Quarto!")
}

# Kết thúc 🎉
message("🎉 Toàn bộ quy trình đã hoàn tất (hoặc theo lựa chọn của bạn)!")
