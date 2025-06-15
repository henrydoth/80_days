# 📚 Tổng hợp các lệnh Git Bash cơ bản (cho Windows, RStudio, WSL)

## 📁 1. Điều hướng thư mục
| Lệnh | Mô tả |
|------|------|
| `pwd` | Hiển thị đường dẫn thư mục hiện tại |
| `ls` | Liệt kê file/thư mục |
| `ls -l` | Liệt kê chi tiết |
| `ls -a` | Bao gồm cả file ẩn |
| `cd folder_name` | Vào thư mục con |
| `cd ..` | Lùi 1 cấp thư mục |
| `cd ~` | Về thư mục gốc người dùng |
| `cd -` | Quay lại thư mục trước đó |

## 🧱 2. Quản lý file & thư mục
| Lệnh | Mô tả |
|------|------|
| `mkdir ten_thu_muc` | Tạo thư mục |
| `touch file.txt` | Tạo file trống |
| `rm file.txt` | Xóa file |
| `rm -r thu_muc/` | Xóa thư mục và toàn bộ nội dung |
| `cp file1 file2` | Sao chép file |
| `cp -r thu_muc1 thu_muc2` | Sao chép thư mục |
| `mv ten_cu ten_moi` | Đổi tên hoặc di chuyển file/thư mục |

## 📝 3. Xem và chỉnh sửa file
| Lệnh | Mô tả |
|------|------|
| `cat file.txt` | In nội dung file |
| `less file.txt` | Cuộn đọc file lớn |
| `nano file.txt` | Soạn thảo file trong terminal |
| `head -n 5 file.txt` | 5 dòng đầu |
| `tail -n 5 file.txt` | 5 dòng cuối |

## 🔎 4. Tìm kiếm
| Lệnh | Mô tả |
|------|------|
| `grep "chuỗi" file.txt` | Tìm dòng chứa chuỗi |
| `find . -name "*.R"` | Tìm file có đuôi `.R` từ thư mục hiện tại |
| `history` | Xem lịch sử lệnh đã dùng |
| `Ctrl + R` | Tìm lại lệnh đã gõ trước đó (search ngược) |

## 📦 5. Git cơ bản (trong Git Bash)
| Lệnh | Mô tả |
|------|------|
| `git status` | Xem trạng thái |
| `git add .` | Thêm toàn bộ thay đổi |
| `git commit -m "ghi chú"` | Ghi lại thay đổi |
| `git log` | Xem lịch sử commit |
| `git clone URL` | Tải repo về |
| `git pull` | Cập nhật từ GitHub |
| `git push` | Đẩy lên GitHub |

## ⚙️ 6. Các lệnh hệ thống hữu ích
| Lệnh | Mô tả |
|------|------|
| `echo "xin chào"` | In ra màn hình |
| `date` | Xem ngày giờ hệ thống |
| `sleep 5` | Chờ 5 giây |
| `whoami` | Tên người dùng hiện tại |
| `uname -a` | Thông tin hệ điều hành |
| `clear` | Dọn sạch màn hình terminal |

## 🔄 7. Toán tử & chuyển hướng đầu ra
| Cú pháp | Mô tả |
|--------|------|
| `>` | Ghi đè vào file |
| `>>` | Ghi thêm vào file |
| `|` | Truyền kết quả sang lệnh khác |
| `&&` | Lệnh thứ 2 chỉ chạy nếu lệnh 1 thành công |
| `;` | Chạy lần lượt 2 lệnh bất kể lỗi |

## 🧠 Gợi ý nâng cao:
- Dùng `alias` để rút gọn lệnh (cấu hình trong `.bashrc`)
- Viết `bash script` để tự động hóa thao tác lặp lại
- Kết hợp `awk`, `cut`, `sort`, `uniq` để xử lý dữ liệu dạng dòng
- Sử dụng `tldr` để xem hướng dẫn nhanh: `tldr ls`, `tldr grep`,...

---

👉 *Tài liệu này dành cho người dùng Git Bash trong RStudio hoặc Windows 11 muốn làm việc hiệu quả hơn với dòng lệnh.*
