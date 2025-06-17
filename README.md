## **TOÀN DIỆN DỰ ÁN `80_days`**

**Phân tích văn bản \*Around the World in 80 Days\* với R, Quarto và tidytext**

------

### ✅ 1. **Mục tiêu của dự án**

- Phân tích văn bản *Around the World in 80 Days* (ID 103 - Project Gutenberg).
- Ứng dụng `tidytext`, `ggplot2`, `flextable` để phân tích tần suất từ, cảm xúc, và cấu trúc văn bản.
- Triển khai báo cáo kết quả bằng Quarto (`.qmd`) xuất ra Word/HTML.

------

### 📁 2. **Cấu trúc thư mục dự án**

```
lessCopy code80_days/
├── R/
│   ├── 00_setup.R                # Thiết lập gói và hàm tiện ích
│   ├── 01_load_clean_text.R      # Tải và làm sạch văn bản từ Gutenberg
│   ├── 02_tidy_analysis.R        # Phân tích từ khóa, tần suất
│   ├── 03_sentiment_analysis.R   # (dự phòng cho phân tích cảm xúc)
│   └── run_all.R                 # Chạy toàn bộ script theo thứ tự
├── data/
│   └── around_the_world_clean.csv  # Văn bản đã làm sạch
├── output/                       # (nơi lưu kết quả phân tích)
├── images/                       # (tuỳ chọn: lưu biểu đồ)
├── 80_quarto_words_output.qmd   # File báo cáo chính bằng Quarto
```

------

### 📦 3. **Các bước xử lý chính đã thực hiện**

#### 🔧 `00_setup.R`

- Cài và nạp các gói: `tidyverse`, `gutenbergr`, `tidytext`, `ggplot2`, `flextable`, `here`, `glue`, `officedown`, `quarto`.
- Định nghĩa hàm tiện ích: `check_and_load()`, `ft_vn()` định dạng bảng tiếng Việt.

#### 📥 `01_load_clean_text.R`

- Tải văn bản từ Project Gutenberg bằng `gutenberg_download(103)`.
- Làm sạch: loại bỏ khoảng trắng, dòng trống, phần giới thiệu/cuối sách.
- Ghi vào `data/around_the_world_clean.csv`.

#### 🧹 `02_tidy_analysis.R`

- Đọc file `around_the_world_clean.csv`.
- Token hóa (phân tách từ), loại bỏ stop words.
- Tính tần suất xuất hiện từ, lấy top 10 từ phổ biến.
- Tạo bảng flextable (`bang_top_words`) và biểu đồ ggplot (`bieu_do_top_words`).
- Viết các đoạn `glue::glue()` để diễn giải kết quả.

------

### 📊 4. **Các đối tượng chính sinh ra trong môi trường R**

| Tên biến            | Mục đích                             |
| ------------------- | ------------------------------------ |
| `text_lines`        | Dữ liệu văn bản sau khi làm sạch     |
| `tidy_words`        | Bảng từ đã lọc stop words + tần suất |
| `top_words`         | 10 từ phổ biến nhất                  |
| `bang_top_words`    | Bảng flextable trình bày top từ      |
| `bieu_do_top_words` | Biểu đồ cột các từ phổ biến          |
| `nhan_xet_*`        | Nhận xét tự động bằng `glue::glue()` |



------

### 🧾 5. **Báo cáo Quarto**

- Đặt tên: `80_quarto_words_output.qmd`
- Nội dung:
  - Giới thiệu đề tài, lý do chọn tác phẩm.
  - Mục tiêu: phân tích từ ngữ và cảm xúc văn bản.
  - Tổng quan tài liệu: bạn đã viết phần này với citation dạng AMA11.
  - Đối tượng & phương pháp: sử dụng văn bản gốc, tidytext và ggplot.
  - Phân tích: top từ, nhận xét bảng, biểu đồ.
  - Tài liệu tham khảo: định dạng BibTeX kèm abstract dịch sang tiếng Việt.

------

### 📚 6. **Ghi chú và mẹo quan trọng**

- ✅ Dùng `here::here()` để đảm bảo đường dẫn hoạt động trên mọi hệ điều hành.
- 📊 Biểu đồ dùng `ggplot2::geom_col()` + `coord_flip()` để hiển thị dễ đọc.
- 💾 Ghi file dùng `readr::write_csv()`; có thể bỏ qua cảnh báo `NAs introduced by coercion`.
- 📋 Bảng nên định dạng `Times New Roman`, cỡ 13, tự động co giãn với `autofit()` từ `flextable`.
- 📎 Nếu render Word bằng Quarto, nên dùng `dev: dml` để chèn hình ảnh vector đẹp.

------

### 🔁 7. **Gợi ý tiếp theo**

- Viết thêm `03_sentiment_analysis.R` để phân tích cảm xúc (dùng lexicon như `bing`, `afinn`).
- Thêm biểu đồ thời gian nếu bạn chia văn bản theo chương.
- Tạo giao diện Shiny nếu muốn tương tác (sẽ làm sau giai đoạn Quarto ổn định).