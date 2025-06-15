# 🧠 Ôn tập Git Bash Alias – Từ sáng đến giờ

## ✅ 1. Alias là gì?
Alias là lệnh rút gọn, giúp bạn không phải gõ dài dòng mỗi lần dùng terminal.

---

## ✅ 2. Tạo alias tạm thời (chỉ dùng trong phiên hiện tại)

```bash
alias ten_alias='lệnh_gốc'
```

📌 Ví dụ:
```bash
alias down='cd "/c/Users/liem2/Downloads"'
alias gh='cd "/d/GitHub"'
alias e='explorer .'
```

---

## ✅ 3. Tạo alias vĩnh viễn (tự động khi mở Git Bash)

Dùng `echo` để thêm vào file `~/.bashrc`:

```bash
echo "alias down='cd "/c/Users/liem2/Downloads"'" >> ~/.bashrc
echo "alias gh='cd "/d/GitHub"'" >> ~/.bashrc
echo "alias e='explorer .'" >> ~/.bashrc
```

Sau đó **nạp lại `.bashrc`** để áp dụng alias mới:

```bash
source ~/.bashrc
```

---

## ✅ 4. Sử dụng alias

| Alias | Thực hiện |
|-------|-----------|
| `down` | Vào thư mục Downloads |
| `gh` | Vào thư mục D:\GitHub |
| `e` | Mở thư mục hiện tại bằng Explorer |

---

## 🔎 Kiểm tra alias đã tạo

```bash
alias         # Hiển thị tất cả alias
alias gh      # Kiểm tra alias cụ thể
```

---

## ⚠️ Lỗi thường gặp

| Lỗi | Nguyên nhân |
|-----|-------------|
| `'rm' is not recognized` | Dùng sai môi trường (CMD thay vì Git Bash) |
| `rm: cannot remove 'folder': Is a directory` | Thiếu `-r` khi xóa thư mục |
| `exploerer` | Gõ sai chính tả, đúng là `explorer` |

---

## 📁 Gợi ý alias thường dùng khác

```bash
alias doc='cd "/c/Users/liem2/Documents"'
alias proj='cd "/d/Projects"'
alias r='cd "/c/Users/liem2/Documents/R"'
```

---

👉 Bạn có thể mở và sửa file `~/.bashrc` bằng lệnh:
```bash
nano ~/.bashrc
```
Sau đó thêm, xoá, hoặc chỉnh sửa các alias theo ý muốn.
