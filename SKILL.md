---
name: dnd-ads
description: >
  Tạo content quảng cáo Facebook & Google RSA cho Bệnh viện Mắt Quốc tế DND Sài Gòn.
  Hỗ trợ phân tích ảnh, transcribe video qua Deepgram, auto-detect bác sĩ từ nội dung,
  3 loại ưu đãi (kx/pc/or) lưu file riêng dễ update hàng tháng.
  Trigger: /dnd-ads fb|gg [uudai=kx|pc|or] [desc="..."] hoặc kèm ảnh/video.
metadata:
  version: "1.0.0"
  author: openclaw
  category: content-marketing
  risk: low
  scripts: true
  status: active
  triggers:
    - "/dnd-ads"
    - "/dnd-ads fb"
    - "/dnd-ads gg"
    - "/dnd-ads fb gg"
    - "viết ads dnd"
    - "tạo content ads dnd"
    - "content quảng cáo dnd"
---

# Skill: dnd-ads 👁️

Tạo content quảng cáo chuyên biệt cho **Bệnh viện Mắt Quốc tế DND Sài Gòn** (147 Trương Định, Q3, TP.HCM). Hỗ trợ Facebook Ads và Google RSA.

> ⚠️ **MANDATORY WORKFLOW:**
> 1. Parse input → 2. Process material (ảnh/video) → 3. Auto-detect bác sĩ → 4. Load context (dnd-info + promotions) → 5. Generate content → 6. **BẮT BUỘC QA** → 7. Output
> Chưa qua QA = chưa xong task.

---

## Trigger & Usage

```
/dnd-ads <platform> uudai=<type> desc="<mô tả>"
```

### Ví dụ

```
/dnd-ads fb uudai=kx desc="video review mổ SMILE Pro của BS Tuấn"
```

```
/dnd-ads gg uudai=pc desc="phẫu thuật Femto Phaco cho người già"
```

```
/dnd-ads fb gg uudai=or desc="kính Ortho-K cho trẻ em"
```

```
/dnd-ads fb uudai=kx video="/c/Users/Admin/Downloads/review-smile-pro.mp4"
```

```
/dnd-ads fb uudai=kx lang=en desc="SMILE Pro surgery review"
```

Có thể kèm ảnh trực tiếp trong message → skill tự phân tích.

---

## Input Parameters

| Param | Bắt buộc | Default | Mô tả |
|-------|:--------:|---------|-------|
| `platform` | ✅ | — | `fb` (Facebook) \| `gg` (Google RSA) \| `fb gg` (cả 2) |
| `uudai` | ✅ | — | `kx` (khúc xạ/mổ cận) \| `pc` (phaco) \| `or` (ortho-k) |
| `desc` | ✅ | — | Mô tả ngắn nội dung ads (bắt buộc nếu không có ảnh/video) |
| `video` | ❌ | — | Đường dẫn file video trên máy → transcribe qua Deepgram |
| `lang` | ❌ | `vi` | `vi` (Việt) hoặc `en` (English cho expat) |
| `variations` | ❌ | `3` | Số variations Facebook (1-5). Google RSA luôn 1 asset set |

> **Ảnh:** Nếu user đính kèm ảnh trong message → tự phân tích bằng vision, không cần param.
> **Video:** Phải chỉ định path qua param `video="..."`.

---

## Workflow Chi Tiết

### Bước 0 — Parse Input

1. Detect platform(s): `fb`, `gg`, hoặc cả 2
2. Parse `uudai` → xác định loại ưu đãi (`kx`, `pc`, `or`)
3. Parse `desc` → context chính
4. Nếu có `video` → ghi nhận path
5. Nếu có ảnh trong message → ghi nhận có ảnh

**Validation:**
- Nếu thiếu `platform` → hỏi user
- Nếu thiếu `uudai` → hỏi user: "Loại ưu đãi nào? kx (khúc xạ), pc (phaco), or (ortho-k)"
- Nếu thiếu cả `desc` lẫn ảnh/video → hỏi user mô tả ngắn

---

### Bước 1 — Material Input Processing

#### Nếu có ẢNH (user đính kèm trong message):
1. Phân tích ảnh bằng vision capability
2. Extract: chủ đề, người xuất hiện, text trên ảnh, bối cảnh
3. Nếu thấy bác sĩ → ghi nhận tên BS
4. Dùng kết quả phân tích làm context bổ sung cho `desc`

#### Nếu có VIDEO (param `video="<path>"`):
1. Kiểm tra file tồn tại
2. Chạy script transcribe:
```bash
bash ~/.claude/skills/dnd-ads/scripts/transcribe_video.sh "<video_path>"
```
3. Nhận transcript text từ stdout
4. Dùng transcript làm context chính (thay thế hoặc bổ sung `desc`)

#### Nếu KHÔNG có ảnh/video:
- Dùng `desc` làm context chính
- Vẫn load đầy đủ dnd-info + promotions để viết content

---

### Bước 2 — Auto-detect Bác sĩ

Scan toàn bộ nội dung (transcript, desc, phân tích ảnh) tìm tên bác sĩ:

| Từ khóa nhận diện | Bác sĩ |
|-------------------|--------|
| "BS Tuấn", "bác sĩ Tuấn", "Bùi Quang Tuấn", "giám đốc" | BSNT Bùi Quang Tuấn |
| "BS Linh", "Hoàng Mai Linh" | ThS.BS Hoàng Mai Linh |
| "PGS Lan", "Võ Thị Hoàng Lan" | PGS.TS.BS Võ Thị Hoàng Lan |
| "BS Dũng", "Nguyễn Đăng Dũng", "người sáng lập" | BS.CKII Nguyễn Đăng Dũng |

Nếu detect được bác sĩ:
1. Load thông tin BS từ `dnd-info.md` → section "Đội ngũ Bác sĩ"
2. Nếu cần thêm thông tin chi tiết → search trên `https://matquoctednd.vn/ve-dnd/doi-ngu-bac-si/` bằng `read_url_content` hoặc `search_web`
3. Đưa thông tin BS vào phần "Nội dung chính" của ads

---

### Bước 3 — Load Context

1. Đọc `dnd-info.md` → thông tin BV, công nghệ, USP, social proof
2. Đọc `promotions.md` → tìm section heading khớp với `uudai`:
   - `uudai=kx` → section `## kx`
   - `uudai=pc` → section `## pc`
   - `uudai=or` → section `## or`
3. Merge tất cả context:
   - Material content (ảnh/video/desc)
   - Thông tin bác sĩ (nếu có)
   - Ưu đãi từ promotions.md
   - Company info từ dnd-info.md

---

### Bước 4 — Generate Content

Route theo platform:

#### Nếu `fb` (Facebook):
1. Đọc `platforms/facebook.md`
2. Sinh content theo bố cục 4 phần:
   - **Hook** (8-10 từ, gây chú ý, không tiêu cực, thiếu chủ ngữ)
   - **Nội dung chính** (3-5 câu mô tả, thiếu chủ ngữ)
   - **Ưu đãi** (copy từ promotions.md, format bullets)
   - **CTA** (action cụ thể + lợi ích)
3. Sinh Headline + Description
4. Tạo `variations` phiên bản (default 3), mỗi variation khác angle/style
5. Nếu `lang=en`: sinh thêm bản tiếng Anh bên dưới mỗi variation

#### Nếu `gg` (Google RSA):
1. Đọc `platforms/google-rsa.md`
2. Sinh 1 asset set:
   - **15 Titles** (≤ 30 ký tự mỗi title, 5 categories)
   - **6 Description candidates** (≤ 90 ký tự mỗi desc, 6 focuses) → chọn đúng **4 final** theo hướng dẫn "Chọn 4 Final" trong `platforms/google-rsa.md`
3. Chạy `scripts/validate_chars.py` để đếm chính xác số ký tự — KHÔNG tự đếm bằng mắt/LLM (xem `qa/checks.md` mục "Bước 2 & 5")
4. Check redundancy
5. Nếu `lang=en`: sinh thêm 1 asset set tiếng Anh bên dưới (cũng phải chạy lại validator cho bản tiếng Anh)

#### Nếu `fb gg` (cả 2):
1. Sinh Facebook content trước
2. Sinh Google RSA sau
3. Output cả 2 trong cùng 1 response

---

### Bước 5 — QA (BẮT BUỘC)

Đọc `qa/checks.md` và chạy đúng **QA Flow** theo thứ tự cố định ghi trong file đó:

1. Generate assets (đã làm ở Bước 4)
2. Chạy `scripts/validate_chars.py` (character/count validator — deterministic, không tự đếm bằng LLM)
3. **Persona QA** (self-QA, forced defect search) — 6 persona: Policy, Medical Claims, Offer/Doctor Accuracy, Mobile Scanability, Brand/Tone, RSA Diversity. Mỗi persona PHẢI chỉ ra lỗi cụ thể (asset # + câu trích) hoặc khai báo rõ đã check gì
4. Sửa lỗi nếu có
5. Chạy lại `scripts/validate_chars.py`
6. Chỉ output asset đã pass

**Strict QA (escalation)**: nếu gặp 1 trong các điều kiện sau, PHẢI chuyển từ self-QA sang spawn 1 Agent review độc lập (không self-QA trong cùng completion) — xem chi tiết "Strict QA" trong `qa/checks.md`:
- Bác sĩ detect được không match danh sách `dnd-info.md`
- Claim về kết quả/phục hồi/an toàn vượt quá thông tin xác nhận
- Số tiền/%/deadline ưu đãi khác với `promotions.md`
- Validator fail sau khi đã sửa 1 lần

**Scoring** (sau khi qua Persona QA):
- Facebook: score mỗi variation (1-10)
- Google RSA: score overall asset quality (1-10)
- Average score ≤ 6 → **viết lại**, không output

---

### Bước 6 — Output

Output trực tiếp trong chat theo format của platform module tương ứng:

- Facebook → Output Contract trong `platforms/facebook.md`
- Google RSA → Output Contract trong `platforms/google-rsa.md`

Kèm QA Report ở cuối:

```markdown
---

## 🔍 QA Report

### Cross-Platform: {X}/10 passed
### Platform-Specific: {X}/5 passed
### Scores
- Variation 1: {score}/10
- Variation 2: {score}/10
- Variation 3: {score}/10
- **Average: {avg}/10** ✅
```

---

## Tone & Writing Rules

### Formal Level: 7/10
- Chuyên nghiệp nhưng gần gũi — không lạnh lùng y khoa

### Nhân xưng: TUYỆT ĐỐI KHÔNG DÙNG
- ❌ "chúng tôi", "chúng mình", "anh/chị", "bạn"
- ✅ Thiếu chủ ngữ: "Bỏ kính chỉ sau 15 phút"
- ✅ Passive: "Thị lực phục hồi sau 24h"
- ✅ Tên cụ thể: "Bệnh viện Mắt DND Sài Gòn", "DND"

### Emotional Range
- ✅ An tâm, tin tưởng, hy vọng, quyết tâm, empathy
- ❌ Bi kịch, panic, aggressive, dọa, tiêu cực

### Từ cấm
```
"mua ngay", "deal sốc", "sale sập sàn", "giá rẻ"
"100% thành công", "chắc chắn khỏi", "cam kết khỏi bệnh"
"anh/chị", "bạn", "chúng tôi", "chúng mình"
"miễn phí" lặp > 2 lần
"shock", "điên", "khủng", "nhanh tay", "chớp ngay"
```

---

## Cập nhật Ưu đãi

Khi cần update ưu đãi theo tháng:
1. Mở file `promotions.md`
2. Sửa nội dung section tương ứng (`## kx`, `## pc`, `## or`)
3. Lần chạy `/dnd-ads` tiếp theo sẽ tự động dùng nội dung mới

> ⚠️ Giữ nguyên heading format `## kx`, `## pc`, `## or` — skill parse theo heading này.

---

## Video Transcription

Script `scripts/transcribe_video.sh` sử dụng Deepgram REST API (model nova-3).

**Supported formats:** mp4, mp3, wav, m4a, mov, webm, ogg, flac

**API key** lưu tại `credentials/deepgram_api_key.txt`.

**Features:**
- Auto-detect ngôn ngữ (hỗ trợ tiếng Việt)
- Smart format (paragraphs, punctuation)
- Output transcript text to stdout

---

## Category
content-marketing
