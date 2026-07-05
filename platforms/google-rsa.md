# Platform: Google RSA — DND Sài Gòn

> Google Responsive Search Ads chuyên biệt cho BV Mắt Quốc tế DND Sài Gòn.
> Google tự phối hợp headlines + descriptions → test nhiều tổ hợp.
> Mỗi asset PHẢI work standalone VÀ combinable.

---

## Platform Specs

### Character Limits (HARD LIMIT — Google sẽ REJECT nếu vượt)

| Element | Hard Limit | Số lượng | Display |
|---------|:----------:|:--------:|---------| 
| **Title (Headline)** | **≤ 30 ký tự** | **15** | Google hiển thị 2-3 cùng lúc |
| **Description** | **≤ 90 ký tự** | **4 final** (từ 6 candidates) | Google hiển thị 1-2 cùng lúc |
| **URL Path** | 15 ký tự | Tối đa 2 | VD: /kham-mat/uu-dai |

> ⚠️ **HARD LIMIT**: Google Ads API chỉ cho upload tối đa **15 headlines + 4 descriptions** mỗi RSA. Google REJECT nếu vượt.
> ⚠️ **Đếm ký tự**: KHÔNG tự đếm bằng mắt/LLM. PHẢI chạy `scripts/validate_chars.py` (xem `qa/checks.md`) trước khi output — đếm code-point sau NFC normalize, chính xác 100% cho tiếng Việt.
> ⚠️ **Tiếng Việt**: Dấu Unicode tính 1 ký tự. "Phẫu thuật" = 10 chars. Rất chặt!

---

## Title Strategy (15 Titles)

### Category Distribution

| Category | Số lượng | Mục đích | Gợi ý Pin |
|----------|:--------:|----------|:---------:|
| **Brand DND** | 3 | Tên BV, uy tín, hệ thống | Pin 1 (optional) |
| **Benefit** | 4 | Lợi ích cụ thể cho bệnh nhân | Unpinned |
| **Urgency/Offer** | 3 | Ưu đãi hiện tại, deadline | Unpinned |
| **CTA** | 3 | Kêu gọi hành động cụ thể | Pin 3 (optional) |
| **Proof** | 2 | Số liệu, chứng nhận | Unpinned |

### Ví dụ Titles theo Category (DND-specific)

**Brand DND (3):**
- "BV Mắt DND Sài Gòn" (19 chars)
- "DND — Uy Tín Nhãn Khoa" (22 chars)
- "Mắt Quốc Tế DND — Q3" (21 chars)

**Benefit (4):**
- "Bỏ Kính Chỉ 15 Phút" (20 chars)
- "Phục Hồi Sau 24 Giờ" (20 chars)
- "Không Đau Khi Mổ Mắt" (21 chars)
- "Mổ SMILE Pro 8 Giây" (20 chars)

**Urgency/Offer (3):**
- "Giảm Đến 50% T7/2026" (21 chars)
- "Khám 12 Bước Miễn Phí" (22 chars)
- "Ưu Đãi Hè — Giới Hạn" (21 chars)

**CTA (3):**
- "Đặt Lịch Khám Free" (19 chars)
- "Gọi Ngay 0775.147.147" (22 chars)
- "Đăng Ký Tư Vấn Online" (22 chars)

**Proof (2):**
- "300.000+ Ca Thành Công" (22 chars)
- "Công Nghệ Carl Zeiss" (21 chars)

### Title Rules
- ❌ KHÔNG 2 titles cùng nói 1 ý
- ❌ KHÔNG bắt đầu 2 titles bằng cùng 1 từ
- ❌ KHÔNG 2 titles cùng format
- ❌ KHÔNG excessive caps: "MỔ MẮT GIÁ RẺ" (Google reject)
- ❌ KHÔNG special characters lạ: ★, ♥, ⚡ (Google reject)
- ❌ KHÔNG nhân xưng ("Chúng tôi", "Bạn")
- ✅ Mỗi title mang 1 thông điệp/angle khác
- ✅ Mỗi title work standalone
- ✅ Abbreviation OK: "BV" (Bệnh viện), "BS" (Bác sĩ), "Free" (Miễn phí)

### Vietnamese Character Tips
- 30 chars rất chặt với tiếng Việt
- "Phẫu thuật" = 10 chars, "Mổ mắt" = 6 chars → ưu tiên từ ngắn
- Bỏ dấu trong URL path: /mo-mat-can
- Title Case cho titles

---

## Description Strategy (6 Candidates → 4 Final)

> Google RSA chỉ cho upload tối đa **4 descriptions**. Sinh 6 candidates theo 6 focus dưới đây để có đa dạng, sau đó **chọn đúng 4 final** trước khi output (loại bỏ 2 candidate yếu nhất hoặc trùng lặp ý nhiều nhất với candidate khác).

| # | Focus | Template | Max |
|---|-------|----------|:---:|
| 1 | **Benefit** | Lợi ích chính + USP dịch vụ | 90 chars |
| 2 | **Proof** | Social proof + authority + số liệu | 90 chars |
| 3 | **Offer** | Ưu đãi hiện tại + chi tiết | 90 chars |
| 4 | **CTA** | Kêu gọi hành động + risk reversal + next step | 90 chars |
| 5 | **Technology** | Công nghệ + phương pháp + thiết bị | 90 chars |
| 6 | **Experience** | Trải nghiệm bệnh nhân, quy trình nhanh | 90 chars |

### Chọn 4 Final
- Ưu tiên giữ **Benefit** và **CTA** (2 focus cốt lõi luôn nên có mặt)
- Chọn thêm 2 trong 4 còn lại (Proof/Offer/Technology/Experience) dựa trên context cụ thể của campaign (VD: nếu đang có ưu đãi mạnh trong `promotions.md` → ưu tiên giữ Offer)
- Output chỉ hiển thị 4 descriptions đã chọn, không hiển thị 6 candidates gốc

### Ví dụ Descriptions (DND-specific)

1. **Benefit**: "Mổ cận SMILE Pro chỉ 8 giây, không đau, phục hồi 24h. Bỏ kính vĩnh viễn tại DND SG." (85 chars)
2. **Proof**: "300.000+ ca thành công. BS Bùi Quang Tuấn 13 năm kinh nghiệm trực tiếp phẫu thuật." (83 chars)
3. **Offer**: "Giảm đến 50%++ chi phí mổ cận tháng 7. Khám chuyên sâu 12 bước miễn phí tại DND." (81 chars)
4. **CTA**: "Đặt lịch khám miễn phí hôm nay. Tư vấn phương pháp phù hợp. Đồng hành hậu phẫu 3 năm." (88 chars)
5. **Technology**: "VISUMAX 800 Carl Zeiss — Máy mổ SMILE Pro mới nhất. Định tâm tự động, vết mổ chỉ 2mm." (86 chars)
6. **Experience**: "Mổ xong về nhà ngay trong ngày. Tái khám miễn phí. Tặng thẻ Family 5 triệu chăm sóc mắt." (90 chars)

### Description Rules
- ❌ KHÔNG nhân xưng
- ❌ KHÔNG excessive punctuation (!!!, ???)
- ❌ KHÔNG misleading claims
- ✅ Proper punctuation
- ✅ Mỗi description cover 1 angle khác
- ✅ Descriptions work independently VÀ kết hợp được

---

## Headline Independence Rule

> BẮT BUỘC: Mỗi title PHẢI work standalone VÀ kết hợp tự nhiên với bất kỳ title khác.

### Test Independence
- Đọc title đơn lẻ → có nghĩa không?
- Ghép 2 titles bất kỳ → có mâu thuẫn không?
- Ghép title + description → có tự nhiên không?

---

## Output Contract — Google RSA DND

```markdown
# 🔍 Google RSA — DND {Dịch vụ}

## Thông tin chiến dịch
- **Dịch vụ:** {dịch vụ tương ứng với uudai}
- **Target keyword:** {primary keyword}
- **Ưu đãi:** {tóm tắt từ promotions.md}
- **Brand:** Bệnh viện Mắt Quốc tế DND Sài Gòn

---

## 15 Titles

| # | Category | Title | Chars | Pin |
|---|----------|-------|:-----:|:---:|
| 1 | Brand | {title} | {n} | P1 |
| 2 | Brand | {title} | {n} | — |
| 3 | Brand | {title} | {n} | — |
| 4 | Benefit | {title} | {n} | — |
| 5 | Benefit | {title} | {n} | — |
| 6 | Benefit | {title} | {n} | — |
| 7 | Benefit | {title} | {n} | — |
| 8 | Urgency | {title} | {n} | — |
| 9 | Urgency | {title} | {n} | — |
| 10 | Urgency | {title} | {n} | — |
| 11 | CTA | {title} | {n} | P3 |
| 12 | CTA | {title} | {n} | — |
| 13 | CTA | {title} | {n} | — |
| 14 | Proof | {title} | {n} | — |
| 15 | Proof | {title} | {n} | — |

## 4 Descriptions (Final — đã chọn từ 6 candidates)

| # | Focus | Description | Chars |
|---|-------|-------------|:-----:|
| 1 | Benefit | {desc} | {n} |
| 2 | CTA | {desc} | {n} |
| 3 | {Proof/Offer/Technology/Experience} | {desc} | {n} |
| 4 | {Proof/Offer/Technology/Experience} | {desc} | {n} |

## URL Paths
- Path 1: /{slug-dịch-vụ}
- Path 2: /{slug-ưu-đãi}

## Asset Quality Check
- ✅ Brand coverage: {X}/3 unique angles
- ✅ Benefit coverage: {X}/4 unique benefits
- ✅ Urgency uniqueness: no duplicate offers
- ✅ CTA variety: {X}/3 different actions
- ✅ Proof diversity: {X}/2 different proofs

## Redundancy Check
- No duplicate meanings: ✅/❌
- No same opening words: ✅/❌
- No same format patterns: ✅/❌
- All titles ≤ 30 chars: ✅/❌
- All descriptions ≤ 90 chars: ✅/❌
- Descriptions count == 4 (final, not 6 candidates): ✅/❌

## Pin Suggestions
- **Position 1:** #{title_number} — {reason}
- **Position 3:** #{title_number} — {reason}
```

---

## Google Ads Compliance Notes (Y tế)

- ❌ Không excessive caps: "MỔ MẮT GIÁ RẺ" (Google reject)
- ❌ Không misleading claims ("100% thành công")
- ❌ Không special characters lạ: ★, ♥, ⚡ (Google reject)
- ❌ Không nhân xưng
- ✅ Proper punctuation
- ✅ Healthcare ads: Có thể cần Google Healthcare advertiser certification
- ✅ Trademark usage nếu authorized
- ✅ Title Case cho titles
