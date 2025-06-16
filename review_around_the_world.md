# 🧠 ÔN TẬP DỰ ÁN PHÂN TÍCH VĂN BẢN: *Around the World in 80 Days* bằng R & Quarto

---

## 📁 Cấu trúc dự án

```
project/
├── data/
│   └── around_the_world_clean.csv
├── R/
│   ├── packages.R
│   ├── 01_load_clean_data.R
│   ├── 02_tidy_analysis.R
│   ├── 03_sentiment_analysis.R
├── source/
│   ├── sstt_dtcs_quato_words_input.docx
│   ├── 80-days.bib
│   ├── ama-brackets.csl
├── 80_quato_words_output.qmd
```

---

## ✅ `packages.R`: Thiết lập ban đầu

```r
pacman::p_load(
  dplyr, tidyr, forcats, haven,
  ggplot2, lubridate, glue, flextable,
  officer, officedown, jpeg, png, grid,
  tidyverse, magrittr, purrr, RColorBrewer,
  emo, janitor, effectsize, patchwork,
  scales, stringr, tidytext
)
```

---

## 📄 `02_tidy_analysis.R`: Phân tích tần suất từ

### Các bước:
1. Đọc dữ liệu `.csv`
2. Token hóa: `unnest_tokens()`
3. Loại stopwords
4. Đếm từ & chọn Top 10
5. Hiển thị bằng `flextable`
6. Vẽ biểu đồ `ggplot2`
7. Tạo nhận xét bằng `glue::glue()`

### Kết quả:
- Top từ: `fogg`, `passepartout`, `fix`
- Bàn luận: Phản ánh nhân vật, hành động, không gian

---

## 💬 `03_sentiment_analysis.R`: Phân tích cảm xúc

### Các bước:
- Kết hợp từ với `get_sentiments("bing")`
- Đếm từ tích cực / tiêu cực
- Vẽ biểu đồ cảm xúc
- Nhận xét tự động + bàn luận giọng văn

### Nhận xét:
- >60% từ mang sắc thái tích cực
- Văn phong tích cực, truyền cảm hứng phiêu lưu

---

## 📑 Trích dẫn và cấu hình Word

- `bibliography: source/80-days.bib`
- `csl: source/ama-brackets.csl`
- `reference-doc`: mẫu Word đã thiết kế
- `lang: vi`, `dev: dml` → hỗ trợ tiếng Việt & biểu đồ vector

---

## ❗ Tránh lỗi thường gặp

| Lỗi                                  | Nguyên nhân                              | Cách khắc phục                           |
|--------------------------------------|------------------------------------------|------------------------------------------|
| `get_sentiments()` not found         | Chưa cài/nạp `tidytext`                  | Thêm vào `packages.R`                    |
| `object not found: bang_cam_xuc`     | Gọi đối tượng trước khi khởi tạo         | Gọi `source()` đúng thứ tự               |
| Không có output trong Word           | Dùng `source()` nhưng không in           | Chia block riêng để hiện `flextable`     |

---

## 🔎 Gợi ý mở rộng

- 📍 **N-gram analysis**: bigram, trigram
- 🧍 **Phân tích tên riêng**: nhân vật chính/phụ
- 🌍 **Địa danh**: vẽ bản đồ hành trình
- 🕰 **Biến đổi cảm xúc theo chương**

---

## 📌 Tổng kết

Bạn đã xây dựng một hệ thống phân tích văn học hiện đại, kết hợp:

- `tidytext` cho xử lý ngôn ngữ
- `ggplot2` cho biểu đồ đẹp
- `flextable` cho bảng chuẩn Word
- `glue` cho nhận xét tự động
- `Quarto + officedown` cho xuất bản chuyên nghiệp

---

## ✍️ Câu hỏi luyện tập

1. Làm thế nào để lọc cảm xúc theo từng chương?
2. Vì sao dùng `coord_flip()` trong biểu đồ từ?
3. Cách tạo nhận xét động bằng `glue` như thế nào?

---

📌 Tệp này có thể lưu thành `review_around_the_world.md`, dùng để tự học hoặc hướng dẫn người khác làm phân tích văn học bằng R.
