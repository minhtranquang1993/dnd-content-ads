# Platform: Facebook Ads — DND Sài Gòn

> Module chuyên biệt cho Facebook Ads của BV Mắt Quốc tế DND Sài Gòn.
> Bố cục 4 phần: Hook → Nội dung chính → Ưu đãi → CTA.

---

## Platform Specs

### Character Limits (visible_budget)

| Element | Limit kỹ thuật | Visible Budget | Lý do |
|---------|:--------------:|:--------------:|-------|
| **Primary Text** | 2.200 chars | **≤ 125 chars trước "Xem thêm"** | Mobile truncate sau 125 chars |
| **Headline** | 255 chars | **≤ 40 chars** | Bị cắt trên mobile |
| **Description** | 255 chars | **≤ 30 chars** | Không hiện trên mọi placement |

> ⚠️ Hook PHẢI nằm trong 125 chars đầu. Headline PHẢI ≤ 40 chars.

### Mobile-First Rules
- 95%+ user xem ads trên mobile
- Câu ngắn, xuống dòng nhiều
- Emoji tiết chế (1-3, không spam)
- Preview ở mobile feed view trước

---

## Bố cục Content DND (4 phần bắt buộc)

### Phần 1: 🪝 Hook (8-10 từ)
- Câu mở đầu ngắn, gây chú ý ngay lập tức
- Phải nằm trong 125 chars đầu (trước "Xem thêm")
- **KHÔNG dùng nội dung tiêu cực** (sợ mù, hối hận, đau đớn, cảnh báo kiểu dọa)
- **KHÔNG dùng nhân xưng** — thiếu chủ ngữ hoặc passive

**Loại hook ưu tiên cho DND:**

| Loại | Ví dụ | Khi nào dùng |
|------|-------|-------------|
| **Pattern Interrupt** | "8 giây — và mắt sáng lại từ đây" | Video SMILE Pro |
| **Curiosity/Open Loop** | "Lý do 10.000 người chọn bỏ kính tại đây" | General awareness |
| **Future Pacing** | "Tưởng tượng sáng mai mở mắt — không cần kính" | Emotional hook |
| **Social Proof + Số** | "300.000 ca thành công — câu chuyện tiếp theo là..." | Authority |
| **Micro-Question** | "Cận 5 độ — mổ hay đeo kính cả đời?" | Engagement |
| **Benefit-First** | "Bỏ kính chỉ 15 phút — không đau, phục hồi 24h" | Direct benefit |

**Hook KHÔNG được dùng:**
- ❌ "Đừng để mắt hỏng mới hối hận" (tiêu cực)
- ❌ "Bạn có biết cận thị gây nguy hiểm..." (dọa)
- ❌ "Chúng tôi là bệnh viện hàng đầu..." (nhân xưng + tự khen)
- ❌ "Anh/chị đang bị cận thị?" (nhân xưng)

---

### Phần 2: 📝 Nội dung chính (3-5 câu)
- Mô tả ngắn gọn về nội dung video/ảnh/dịch vụ
- Nếu material là video: tóm tắt ý chính từ transcript
- Nếu material là ảnh: mô tả những gì ảnh thể hiện
- Nếu không có material: viết dựa trên `desc` + context từ `dnd-info.md`
- **Nếu nhắc đến bác sĩ**: Đưa vào thông tin BS (kinh nghiệm, số ca, chuyên môn)
- Thiếu chủ ngữ, câu ngắn, xuống dòng thường xuyên

---

### Phần 3: 🎁 Ưu đãi
- Copy nội dung từ `promotions.md` section tương ứng (`kx`, `pc`, `or`)
- Format phù hợp cho ads (có thể rút gọn nếu quá dài)
- Giữ nguyên emoji ✨🔥 từ promotions.md
- Tách thành list bullet để dễ đọc trên mobile

---

### Phần 4: 📣 CTA
- Luôn có action cụ thể + lợi ích
- Thiếu chủ ngữ

**CTA Templates cho DND:**

| Loại ưu đãi | CTA gợi ý |
|-------------|-----------|
| kx (khúc xạ) | "NHẮN TIN đặt lịch khám miễn phí + nhận ưu đãi mổ cận tháng 7 🔥" |
| kx (khúc xạ) | "💬 Inbox ngay — Khám 12 bước miễn phí, tư vấn phương pháp phù hợp" |
| kx (khúc xạ) | "Đăng ký khám chuyên sâu FREE → Nhận ưu đãi giảm đến 50%++" |
| pc (phaco) | "NHẮN TIN đặt lịch khám miễn phí + nhận ưu đãi Femto Phaco 30% 🎁" |
| pc (phaco) | "💬 Inbox — Được tư vấn chi tiết về phẫu thuật đục thủy tinh thể" |
| or (ortho-k) | "NHẮN TIN đặt lịch khám mắt miễn phí cho bé + ưu đãi Ortho-K tháng 7" |
| or (ortho-k) | "💬 Inbox — Tư vấn kính Ortho-K kiểm soát cận cho trẻ" |

---

## Tone & Writing Rules (DND-specific)

### Formal Level: 7/10
- Chuyên nghiệp nhưng gần gũi — không lạnh lùng y khoa
- Thiếu chủ ngữ là phong cách chính

### Nhân xưng: KHÔNG DÙNG
- ❌ "chúng tôi", "chúng mình", "anh/chị", "bạn"
- ✅ Thiếu chủ ngữ: "Được đồng hành hậu phẫu 3 năm"
- ✅ Passive: "Thị lực phục hồi sau 24h"
- ✅ Dùng tên cụ thể: "Bệnh viện Mắt DND Sài Gòn" hoặc "DND"

### Emotional Range
- ✅ An tâm, tin tưởng, hy vọng, quyết tâm
- ✅ Empathy, supportive
- ⚠️ Loss Aversion tinh tế (không gây hoảng)
- ❌ Bi kịch, panic, aggressive, dọa

### Từ cấm
```
❌ "mua ngay" — y tế không phải mua bán
❌ "deal sốc", "sale sập sàn", "giá rẻ" — hạ giá trị y tế
❌ "100% thành công", "chắc chắn khỏi", "cam kết khỏi bệnh"
❌ "anh/chị", "bạn", "chúng tôi", "chúng mình"
❌ "miễn phí" lặp quá 2 lần
❌ "shock", "điên", "khủng"
❌ "nhanh tay", "chớp ngay"
```

### Emoji Guidelines
- Tối đa 1-3 emoji cho toàn bộ primary text
- Dùng emoji y tế phù hợp: 👁️ 🔬 ✨ 🎁 💬
- Không spam emoji kiểu ecommerce

---

## Output Contract — Facebook DND

```markdown
# 📱 Facebook Ads — DND {Dịch vụ}

## Thông tin chiến dịch
- **Ưu đãi:** {uudai_type — kx/pc/or}
- **Material:** {image/video/description only}
- **Bác sĩ:** {tên BS nếu detect được, hoặc "N/A"}
- **Ngôn ngữ:** {vi/en}

---

## Variation 1: {Tên style/angle}

### 🪝 Hook
{Câu hook 8-10 từ — gây chú ý, không tiêu cực, thiếu chủ ngữ}

### 📝 Nội dung chính
{3-5 câu mô tả — thiếu chủ ngữ, mobile-first, xuống dòng}

### 🎁 Ưu đãi
{Nội dung từ promotions.md, format bullets}

### 📣 CTA
{Action cụ thể + lợi ích}

### Headline
{≤ 40 ký tự}

### Description
{≤ 30 ký tự}

---

## Variation 2: {Tên style/angle}
{...tương tự...}

---

## Variation 3: {Tên style/angle}
{...tương tự...}

---

## 🧪 Gợi ý A/B Test
- **Hook:** {V1 vs V2 — lý do}
- **CTA:** {variation — lý do}
- **Visual:** {gợi ý creative cho từng variation}

## 💬 Conversation Starters (Messenger)
- "Muốn tìm hiểu về {dịch vụ}"
- "Cho hỏi giá {dịch vụ}"
- "Muốn đặt lịch khám"
```

---

## Facebook Compliance Notes (Y tế)

- ❌ Không claim tuyệt đối: "100% thành công", "chắc chắn khỏi"
- ❌ Không before/after ảnh quá dramatic (FB reject)
- ❌ Không clickbait quá mức → giảm trust score
- ❌ Không nội dung gây sợ hãi, bi kịch
- ✅ Disclaimer nhẹ nếu cần: "* Kết quả phụ thuộc vào tình trạng mắt và cơ địa từng người"
- ✅ Tuân thủ chính sách healthcare ads của Facebook
- ✅ Emoji tiết chế — phù hợp brand tone y tế
