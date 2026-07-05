# QA Checklist — DND Ads

> Chạy checklist này SAU KHI sinh content, TRƯỚC KHI output.
> Nếu BẤT KỲ check FAIL → sửa ngay.
> Scoring average ≤ 6 → viết lại.

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
| G4 | **6 Descriptions, 6 Focuses** | Đủ 6 descriptions: Benefit + Proof + Offer + CTA + Technology + Experience | ✅/❌ |
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
| Description diversity (6 focuses covered) | 20% |
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
