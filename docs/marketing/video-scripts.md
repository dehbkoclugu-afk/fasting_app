# Kısa video çekim listesi

Pazarlama planı Faz 1, içerik motoru. Kısıtlar planda kararlaştırıldı: **ekran kaydı,
yüz yok, ses yok, İngilizce, haftada 3 video.** Aynı klipler TikTok + Reels + Shorts'a
gidiyor, linkler `utm-links.md` içinde kanal başına ayrı.

## Çekim yöntemi

Tek oturumda 8 klip kaydet, üç haftaya yay. Toplu çekim bu işin sürdürülebilir olmasının
tek yolu — haftada bir kez kamera açmaya çalışırsan üçüncü haftada bırakırsın.

- Cihazın kendi ekran kaydını kullan (Android: hızlı ayarlar; iOS: Kontrol Merkezi).
- Koyu tema, uygulamanın karakteri o.
- Kayıt öncesi bildirimleri kapat ve pil/saat göstergesinin temiz göründüğü bir an seç.
- Dikey, tam ekran. Sonradan kırpma kalite kaybettirir.
- Ses yok → **trend olan bir sesi platformda ekle**, metni ekran üstü yazıyla ver.
- İlk **1,5 saniye** her şeydir. Hook metni ilk karede ekranda olmalı, kaydırmadan önce.

## Uyulacak sınır

Sağlık kategorisinde iddia sorun çıkarır — hem platform kısıtı hem de ürünün duruşuyla
çelişir. Videolarda **kilo verme vaadi, hastalık iddiası, "detoks/temizlik" dili yok.**
Uygulamanın kendi metni bile evre saatleri için "genel tahmin, tıbbi ölçüm değil" diyor
(`phase_estimateShort`); videolarda da o çizgide kal. Bu bir kısıt değil, ayrışma
noktası — rakiplerin tamamı vaat satıyor.

---

## Klip 1 — Saat saat renk değişimi

**Hook (0–1,5 sn):** `16 hours, watched`
**Kayıt:** `timer_screen.dart` faz halkası. Orucun farklı saatlerinde 4–5 ayrı kısa kayıt
al, kurguda arka arkaya diz — halka renk değiştirdikçe geçiş görünsün.
**Ekran üstü metin:** `hour 4 · hour 8 · hour 12 · hour 16`
**Kapanış:** `no notifications shouting at you`
**Süre:** 8–12 sn

## Klip 2 — Vücudunda ne oluyor

**Hook:** `what's actually happening in there`
**Kayıt:** `metabolic_journey.dart` ekranını yavaşça kaydır.
**Ekran üstü metin:** uygulamanın kendi ifadeleri — `Anabolic → digestion in progress`,
`Catabolic → energy transition`, `Fat Burning`, `Ketosis → ketone production active`,
`Autophagy → cell renewal`
**Kapanış:** ekrandaki uyarıyı göster: `a general estimate, not a medical measurement`
**Süre:** 12–15 sn

Bu kapanış sayfada zaten var; kesip atma. Yorumlarda "bu bilimsel mi" sorusunun cevabı
o satır, ve dürüstlüğü içeriğin en çok paylaşılan kısmı oluyor.

## Klip 3 — Pes etmek başarısızlık değil

**Hook:** `every fasting app pushes you to keep going`
**Kayıt:** `crisis_mode_sheet.dart` üç adımı sırayla — sebep seçimi (Hunger / Habit /
Stress), `Drink a glass of water`, `Delay the decision for 10 minutes`.
**Kapanış (tam ekran, uygulamanın kendi cümlesi):**
`If you feel unwell, ending the fast is not failure.`
**Süre:** 10–14 sn

En güçlü klip bu. Cümle uydurma değil, uygulamanın içinde birebir öyle yazıyor
(`crisis_delayDesc`) — ekran kaydında görünmesi iddiayı kanıtlıyor.

## Klip 4 — 30 gün, dürüstçe

**Hook:** `30 days of fasting — the honest version`
**Kayıt:** `monthly_heatmap.dart`, **boşlukları olan** bir ay. Kusursuz seri gösterme.
**Ekran üstü metin:** `missed days included`
**Kapanış:** `your rhythm, not a scoreboard`
**Süre:** 8–10 sn

## Klip 5 — Hesap yok

**Hook:** `no sign up. watch.`
**Kayıt:** uygulamayı sıfırdan aç → onboarding → doğrudan zamanlayıcı. Kesintisiz, tek
çekim; kurgu yapma, kesintisizlik iddianın kendisi.
**Ekran üstü metin:** `no email · no password · no account`
**Kapanış:** `your data stays on your phone`
**Süre:** 10–12 sn

## Klip 6 — Planını seç

**Hook:** `12:12 or OMAD?`
**Kayıt:** `plan_select_screen.dart` — planlar arasında gez, zorluk etiketleri görünsün.
**Ekran üstü metin:** `12:12 beginner · 16:8 most popular · OMAD expert`
**Kapanış:** `start where you actually are`
**Süre:** 8–10 sn

## Klip 7 — Ana ekran widget'ı

**Hook:** `without opening the app`
**Kayıt:** ana ekrandaki widget'ta kalan sürenin görünmesi, sonra uygulamaya giriş.
**Ekran üstü metin:** `remaining time, on your home screen`
**Süre:** 6–8 sn

## Klip 8 — Su ve kilo

**Hook:** `one app, not three`
**Kayıt:** `water_tracker_screen.dart` damla dolum animasyonu, ardından
`weight_tracker_screen.dart` BMI göstergesi.
**Ekran üstü metin:** `water · weight · fasting`
**Süre:** 8–10 sn

---

## Yayın düzeni

Haftada 3 gönderi, sırayı karıştırma — güçlü kliplerle başla, algoritma ilk
performansa göre sonrakileri taşıyor.

| Hafta | Pazartesi | Çarşamba | Cuma |
|---|---|---|---|
| 1 | Klip 3 (pes etmek) | Klip 1 (renk değişimi) | Klip 5 (hesap yok) |
| 2 | Klip 2 (metabolik) | Klip 4 (30 gün) | Klip 6 (plan seçimi) |
| 3 | Klip 8 (su/kilo) | Klip 7 (widget) | en iyi performansı tekrar kurgula |

Üçüncü haftanın sonunda hangi hook'un tuttuğu belli olur. Kazanan mesajı mağaza kısa
açıklamasına taşı — planın Ay 2 kreatif testi tam olarak bunu ölçmek için var.

## Açıklama metni ve etiketler

Her platformda aynı metin çalışır:

```
A fasting tracker that doesn't shout at you.
No account, no weight promises. Link in bio.

#intermittentfasting #fasting #16of8 #omad #fastingjourney #wellness
```

Link'i doğrudan gönderiye koyma — TikTok ve Instagram harici linkli gönderilerin
erişimini kısıyor. Bio'ya `utm_source=tiktok` / `utm_source=instagram` linkini koy;
hangisinin kurulum getirdiğini ancak böyle ayırabilirsin.
