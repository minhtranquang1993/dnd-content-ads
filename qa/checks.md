# QA Checklist — DND Ads

> Chạy checklist này SAU KHI sinh content, TRƯỚC KHI output.
> Nếu BẤT KỲ check FAIL → sửa ngay.
> Scoring average ≤ 6 → viết lại.

---

## QA Flow (thứ tự cố định — không đảo)

```
1. Generate assets
2. Chạy scripts/validate_chars.py (character/count validator)
3. Persona QA — forced defect search (self-QA, xem "Persona QA" bên dưới)
4. Sửa lỗi nếu có
5. Chạy lại validate_chars.py
6. Chỉ output asset đã pass
```

### Bước 2 & 5 — Chạy validator

Chuẩn bị input JSON rồi pipe vào script:

```bash
echo '{
  "titles": ["...", "...", "..."],
  "descriptions": ["...", "...", "...", "..."],
  "url_paths": ["/...", "/..."],
  "expected_title_count": 15,
  "expected_description_count": 4
}' | python3 /Users/minhtqm1993/.claude/skills/dnd-ads/scripts/validate_chars.py
```

- Exit code `0` = tất cả pass. Exit code `1` = có ít nhất 1 fail → xem field nào fail trong JSON output, sửa asset đó, chạy lại.
- Google RSA: `expected_title_count=15`, `expected_description_count=4` (4 final, không phải 6 candidates).
- Facebook: chỉ cần check `titles` (Headline ≤ 40 tự set limit riêng — script này dùng limit cứng Google 30/90/15, nên với Facebook chỉ dùng script để đếm chính xác số ký tự, so sánh tay với limit F2/F3 bên dưới).

### Bước 3 — Persona QA (Forced Defect Search)

Chạy tuần tự qua 6 persona dưới đây, TRONG CÙNG 1 lượt (không tách sub-agent trừ khi rơi vào điều kiện Strict QA). Mỗi persona **PHẢI** làm 1 trong 2:
- Chỉ ra ít nhất 1 lỗi cụ thể: "Asset #{n}, câu '{quote}' — vi phạm vì {lý do}"
- Hoặc khai báo rõ đã kiểm tra gì và tại sao không tìm thấy lỗi: "Đã check {list checks} — không phát hiện vi phạm"

Không được chỉ trả lời "OK" hoặc chấm điểm mà không có evidence.

| Persona | Trách nhiệm | Check tương ứng |
|---------|-------------|------------------|
| **Policy** | Chính sách quảng cáo Google/Facebook y tế | C9, G1-G2 (hard limits), no excessive caps/special chars |
| **Medical Claims** | Claims tuyệt đối, kết quả/phục hồi/an toàn | C1, C10 (disclaimer) |
| **Offer/Doctor Accuracy** | Khớp promotions.md và dnd-info.md | C4, C5 |
| **Mobile Scanability** | Đọc được trên mobile, hook trong budget | F1, F2, F3, F5 |
| **Brand/Tone** | Nhân xưng, từ cấm, formal level | C2, C3, C6, C7, C8 |
| **RSA Diversity** | Không trùng ý/từ đầu/format (chỉ áp dụng Google) | G3, G4, G5 |

### Strict QA (escalation — tách sub-agent riêng)

Tự động chuyển sang Strict QA (gọi lại qua Agent tool, KHÔNG dùng self-QA trong cùng completion) khi gặp BẤT KỲ điều kiện sau:
- Phát hiện tên bác sĩ không match danh sách trong `dnd-info.md` (nghi là bác sĩ mới hoặc viết sai)
- Content chứa claim liên quan đến kết quả/phục hồi/an toàn vượt quá những gì `dnd-info.md` xác nhận
- Số tiền/% giảm/deadline ưu đãi trong content khác với `promotions.md`
- Validator (`validate_chars.py`) fail sau khi đã sửa 1 lần

Khi Strict QA kích hoạt: dùng Agent tool, spawn 1 agent review độc lập với đầy đủ context (content đã sinh + `dnd-info.md` + `promotions.md`), yêu cầu agent đó tự tìm lỗi từ đầu (không được biết content này đã qua self-QA trước đó).

---

## Cross-Platform Checks (10 items)

Áp dụng cho CẢ Facebook và Google RSA.

| # | Check | Mô tả | Pass? |
|---|-------|-------|:-----:|
| C1 | **No Absolute Claims** | Không "100% thành công", "chắc chắn khỏi", "cam kết khỏi bệnh" | ✅/❌ |
| C2 | **No Banned Words** | Không "mua ngay", "deal sốc", "sale sập sàn", "giá rẻ", "shock", "điên", "khủng", "nhanh tay", "chớp ngay" | ✅/❌ |
| C3 | **No Pronouns** | Không "chúng tôi", "chúng mình", "anh/chị", "bạn" — chỉ dùng thiếu chủ ngữ hoặc passive | ✅/❌ |
| C4 | **Promotion Accuracy** | Thông tin ưu đãi khớp chính xác với `promotions.md` (%, số tiền, tên ưu đãi) | ✅/❌ |
| C5 | **Doctor Accuracy** | Thông tin bác sĩ khớp chính xác với `dnd-info.md` (tên, chức danh, kinh nghiệm) | ✅/❌ |
| C6 | **Clear CTA** | CTA có action cụ thể + lợi ích rõ ràng | ✅/❌ |
| C7 | **Hook Quality** | Hook 8-10 từ, gây chú ý, KHÔNG tiêu cực, KHÔNG nhân xưng | ✅/❌ |
| C8 | **Emoji Discipline** | Facebook: ≤ 3 emoji. Google: 0 emoji | ✅/❌ |
| C9 | **Healthcare Compliance** | Tuân thủ chính sách quảng cáo y tế (Facebook/Google) | ✅/❌ |
| C10 | **Disclaimer** | Có disclaimer nếu claim kết quả: "* Kết quả phụ thuộc tình trạng mắt và cơ địa" | ✅/❌ |

---

## Facebook-Specific Checks (F1-F5)

Chỉ áp dụng khi platform = `fb`.

| # | Check | Mô tả | Pass? |
|---|-------|-------|:-----:|
| F1 | **Hook ≤ 125 chars** | Hook phải nằm trong 125 chars đầu (trước "Xem thêm") | ✅/❌ |
| F2 | **Headline ≤ 40 chars** | Headline visible budget | ✅/❌ |
| F3 | **Description ≤ 30 chars** | Description visible budget | ✅/❌ |
| F4 | **Variation Diversity** | 3 variations khác style/angle, không lặp cấu trúc | ✅/❌ |
| F5 | **Mobile-First** | Câu ngắn, xuống dòng nhiều, preview OK trên mobile | ✅/❌ |

---

## Google RSA-Specific Checks (G1-G5)

Chỉ áp dụng khi platform = `gg`.

| # | Check | Mô tả | Pass? |
|---|-------|-------|:-----:|
| G1 | **Title ≤ 30 chars** | HARD LIMIT — đếm chính xác từng title, REJECT nếu vượt | ✅/❌ |
| G2 | **Description ≤ 90 chars** | HARD LIMIT — đếm chính xác từng description | ✅/❌ |
| G3 | **15 Titles, 5 Categories** | Đủ 15 titles: 3 Brand + 4 Benefit + 3 Urgency + 3 CTA + 2 Proof | ✅/❌ |
| G4 | **4 Final Descriptions (từ 6 candidates)** | Đủ 4 descriptions final, ưu tiên giữ Benefit + CTA, chọn thêm 2 trong Proof/Offer/Technology/Experience | ✅/❌ |
| G5 | **No Redundancy** | Không 2 titles trùng ý, cùng từ đầu, hoặc cùng format pattern | ✅/❌ |

---

## Scoring System

### Facebook: Score mỗi Variation (1-10)

| Tiêu chí | Weight |
|----------|:------:|
| Hook gây chú ý & không tiêu cực | 25% |
| Nội dung chính relevant & compelling | 25% |
| Ưu đãi rõ ràng, hấp dẫn | 20% |
| CTA mạnh, action cụ thể | 15% |
| Tone đúng (thiếu chủ ngữ, formal 7/10) | 15% |

### Google RSA: Score Overall Asset Quality (1-10)

| Tiêu chí | Weight |
|----------|:------:|
| Title diversity (5 categories covered) | 25% |
| Description diversity (4 final focuses covered, từ 6 candidates) | 20% |
| Character limit compliance | 20% |
| No redundancy | 20% |
| DND brand representation | 15% |

### Quy tắc Scoring
- **Score ≥ 8:** ✅ Tốt — output ngay
- **Score 7:** ⚠️ OK — output kèm gợi ý cải thiện
- **Score ≤ 6:** ❌ Viết lại — không output

---

## Auto-Review Template

Sau khi chạy QA, output review summary:

```markdown
## 🔍 QA Report

### Cross-Platform: {X}/10 passed
{Liệt kê các check FAIL nếu có}

### Platform-Specific: {X}/5 passed
{Liệt kê các check FAIL nếu có}

### Scores
- Variation 1: {score}/10
- Variation 2: {score}/10
- Variation 3: {score}/10
- **Average: {avg}/10** {✅ ≥ 7 | ❌ ≤ 6 → rewrite}
```
