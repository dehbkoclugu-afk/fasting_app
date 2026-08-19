# FastTrack Pazarlama Planı (90 gün)

## Context

FastTrack Play Store'da yayında ama bugüne kadar hiç pazarlanmadı. Bugün satın alma
akışındaki üç ayrı bug düzeltildi (paywall layout istisnası, dart-define'sız build,
karşılıksız premium vaatleri), yani ürün artık para kazanabilir durumda. Sıradaki
darboğaz kullanıcı: uygulamayı kimse bilmiyor.

Kararlaştırılan çerçeve:

- **Bütçe:** aylık 1.000–3.000 ₺
- **Pazar:** önce global / İngilizce
- **İçerik:** ekran kaydı + metin (yüz/ses yok)
- **Premium:** şimdilik olduğu gibi kalıyor, önce trafik

Bu üçlü kombinasyon planın şeklini belirliyor: para kazanma ağırlığı reklamda olacak,
dolayısıyla hedef "çok ödeyen kullanıcı" değil, **çok ve düzenli açan kullanıcı**.
Ölçtüğümüz şey de kurulum sayısı değil, D7 tutunma ve günlük oturum sayısı.

## Gerçekçi beklenti (önce bunu bilelim)

Premium şu an 6 ek plan + reklamsızlık. Ücretsiz tarafta 12:12 ve 16:8 var; 18:6, 20:4,
OMAD, 5:2, Eat-Stop-Eat ve Warrior premium (`lib/core/constants/fasting_plans.dart`).
Bu paketle abonelik dönüşümü tipik olarak **%0,5–1** bandında kalır. Reklam tarafında
sağlık uygulamaları için ARPDAU kabaca **0,005–0,02 $**.

Kaba matematik: 10.000 kurulum → ~2.500 aylık aktif → aylık ~30–150 $ reklam + ~20–40
abone. Yani bu plan seni "ayda 50.000 $" noktasına götürmez; götüreceği yer ürünün kendi
ayakları üzerinde durduğu, ölçülebilir bir taban. 90 gün sonunda hangi mesajın tuttuğunu
bilirsen, ya premium'u güçlendirip aynı trafikten 5–10 kat gelir çıkarırsın, ya da reklam
ağırlıklı hacim oyununa yüklenirsin. **O karar için veri üretmek bu planın asıl amacı.**

## Konumlandırma

Rakipler (Zero, Simple, Fastic, BodyFast) agresif: kilo vaadi, koçluk, sıkı paywall,
bildirim baskısı. FastTrack'in kodunda ve tasarım dokümanlarında zaten bunun tersi bir
duruş var — `docs/superpowers/specs/2026-07-17-ethical-gamification-plan.md` açıkça
"hedefin ötesine geçmeyi ödüllendirme, ceza mekaniği kurma" diyor, `store_metadata/`
metinleri "baskı hissetmeden" vurgusu yapıyor.

Pazarlama mesajı bunun üstüne kurulmalı:

> **"Fasting without the pressure."**
> Sana bağırmayan, kilo vaadi satmayan, verini cihazında tutan sakin bir oruç takipçisi.

Somut ayrışma noktaları (hepsi bugün üründe mevcut):

1. **Baskısız ton** — streak kaybında suçlama yok, crisis mode pes etmeyi başarısızlık
   saymıyor
2. **Gizlilik** — hesap yok, veri cihazda; rakiplerin hepsi kayıt zorunlu
3. **6 dil** — çoğu rakip 2–3 dilde
4. **Cömert ücretsiz sürüm** — 12:12 ve 16:8 (en popüler iki plan) ücretsiz

## Faz 0 — Hunının tabanını kapat (gün 0–14, ücretsiz)

Trafik getirmeden önce gelen trafiğin sızmadığından emin ol. Bu fazdaki her madde kalıcı
etki yapar ve para istemez.

1. **Play listing'i 6 dile çevir.** `store_metadata/app_store_{en,tr,es,pt,de,fr}.txt`
   altında altı dilin metni zaten hazır. Play Console → Mağaza girişi → dil ekle →
   yapıştır. Almanca/Fransızca/İspanyolca aramalarından ücretsiz kurulum gelir;
   rakiplerin çoğu bu kadar dilde listelenmiyor. **En yüksek getirili tek iş bu.**

2. **Başlığa anahtar kelime koy.** Play'de başlık sıralamada en ağır sinyal. Şu an
   "FastTrack: Oruç Takibi". İngilizce listede: `FastTrack: Fasting Tracker`
   (30 karakter sınırı). Kısa açıklamaya (80 karakter) "intermittent fasting timer"
   geçir.

3. **Ekran görüntülerini yenile.** Play'de ilk 3 görsel kritik — çoğu kullanıcı
   dördüncüyü hiç görmez. Sıra önerisi:
   1. Faz halkası çalışırken + üstte "See what your body is doing, hour by hour"
   2. Metabolik yolculuk ekranı + "Ketosis at hour 16 — explained, not promised"
   3. İstatistik/ısı haritası + "Your rhythm, not a scoreboard"

   Her görselde tek cümle, özellik değil fayda yaz.

4. **Uygulama içi puan isteme ekle.** Şu an yok. Yıldız sayısı hem sıralamayı hem kurulum
   dönüşümünü doğrudan etkiliyor. `in_app_review` paketi ile, 3. tamamlanan oruçtan sonra
   bir kez sor (tamamlanma anı, memnuniyetin en yüksek olduğu an). ~1 saatlik geliştirme
   işi. *(Bu madde bu planla birlikte uygulandı — `lib/services/review_service.dart`.)*

5. **Kaynak takibi kur.** Play Console → Kullanıcı kazanımı, UTM'li linklerle çalışıyor.
   Her kanal için ayrı link üret (TikTok, Reddit, regl uygulaması), yoksa 90 gün sonra
   neyin işe yaradığını bilemezsin.

## Faz 1 — Bedava kanallar (gün 0–45)

### Çapraz tanıtım — en hızlı kazanç

Elinde zaten kullanıcısı olan ikinci bir uygulama var: **Döngü Takip: Regl Takvimi**.
Kitle örtüşmesi yüksek (sağlık takibi yapan, alışkanlık kuran kullanıcılar). Yapılacak:

- Regl uygulamasına FastTrack'i tanıtan bir kart/banner koy (AdMob house ad ya da basit
  bir in-app kart — reklam geliri kaybı yok, kendi trafiğin)
- İki uygulama da aynı geliştirici hesabında olduğu için Play'deki "Bu geliştiricinin
  diğer uygulamaları" bölümü zaten çalışıyor; geliştirici adını ve ikonları tutarlı hale
  getir

### Kısa video (ekran kaydı, yüz yok)

Haftada 3 video, İngilizce, TikTok + Reels + Shorts'a aynı anda. Yüz gerekmiyor; bu
üründe zaten güçlü görsel var. Çalışan format fikirleri:

- Faz halkasının 16 saatte renk değiştirmesi + "hour by hour, what changes"
- "I fasted for 30 days — here's the heatmap" (ısı haritası ekranı)
- Crisis mode akışı: "the app doesn't tell you to push through"
- Rakip eleştirisi değil ama kontrast: "no account, no weight promises"

Toplu çek: bir oturumda 6–8 klip kaydet, haftaya yay.

### Topluluk

- **r/intermittentfasting** ve **r/fasting**: önce 2 hafta gerçekten katıl, soru cevapla.
  Sonra "I built a free fasting tracker, no account required" formatında **tek bir**
  paylaşım. Spam yaparsan ban yersin, sabırlı ol.
- **r/androidapps** haftalık serbest paylaşım başlıkları
- **Product Hunt** lansmanı (tek seferlik, ücretsiz, kalıcı backlink)

## Faz 2 — Küçük bütçeyi doğru yere koy (gün 15–90)

Aylık 1.000–3.000 ₺ ile kullanıcı satın almak matematiksel olarak anlamsız: sağlık
kategorisinde kurulum başı maliyet 1,5–4 $, yani ayda 20–40 kurulum. **Bu para dönüşüme
gitmeli, medyaya değil.**

Öncelik sırası:

1. **Ay 1 (~1.500 ₺):** profesyonel ekran görüntüsü + ikon seti (Fiverr/Upwork). Mağaza
   dönüşümünde %20–30 fark yaratabilir ve etkisi kalıcıdır — her ay yeniden ödemezsin.
2. **Ay 2 (~1.000 ₺):** en iyi performans gösteren 2 videoyu TikTok'ta "boost" et. Amaç
   kurulum değil, **hangi mesajın tuttuğunu öğrenmek.** Kazanan mesajı mağaza metnine ve
   tüm içeriğe taşı.
3. **Ay 3:** kazanan kreatife küçük ölçekli devam, ya da iOS yayına girdiyse Apple Search
   Ads'te marka dışı düşük rekabetli kelimelerde test (iOS'ta abonelik geliri Android'in
   kat kat üstünde). *Not: iOS henüz canlı değil —* `lib/core/config/build_config.dart`
   *içinde iOS mağaza URL'si, RevenueCat ve AdMob anahtarları hâlâ boş. Bu madde iOS
   yayına girene kadar koşullu.*

**Play Store listing experiments** ücretsiz A/B testi sunuyor — ikon, ekran görüntüsü ve
kısa açıklama varyantlarını para harcamadan test et. Bütçeden önce bunu kullan.

## Ölçüm

Haftada bir 15 dakika, üç ekran:

| Kaynak | Bakılacak | Hedef (90. gün) |
|---|---|---|
| Play Console | Mağaza dönüşüm oranı | %25 → %35 |
| Play Console | D1 / D7 tutunma | D1 %35+, D7 %15+ |
| Play Console | Kaldırma oranı | %30 altı |
| AdMob | Günlük aktif başına gelir | ölç, taban oluştur |
| RevenueCat | Abone sayısı | ölç, %1 dönüşüm bekle |

**Kurulum sayısını değil D7 tutunmayı kovala.** Reklam geliri tutunmanın doğrudan
fonksiyonu; ayrıca Play algoritması da tutunması iyi uygulamaları öne çıkarıyor.

## Yapma listesi

- **Sahte yorum / kurulum botu satın alma** — Play hesabı kapatma sebebi, iki uygulamanı
  birden kaybedersin
- **Tıbbi iddia** — "kilo verdirir", "insülin direncini düzeltir" gibi cümleler hem Play
  sağlık politikasına takılır hem de mağaza metnindeki mevcut temkinli dille çelişir
- **Bildirim bombardımanı ile tutunma şişirme** — kaldırma oranını yükseltir, ürünün
  "baskısız" konumlandırmasını çürütür
- **Aynı anda 6 kanal** — tek kişisin; ASO + tek video kanalı + çapraz tanıtım ile başla

## 90. günde karar noktası

Veri geldiğinde iki yoldan biri:

- **Tutunma iyi, dönüşüm düşük** (muhtemel senaryo) → premium'u güçlendirme zamanı:
  gelişmiş istatistikler, kişisel oruç planı, veri dışa aktarma gibi gerçekten ödenecek
  özellikler. Aynı trafikten kat kat gelir.
- **Tutunma düşük** → pazarlama değil ürün sorunu; onboarding ve ilk hafta deneyimine dön.

## Uygulama sırası (özet)

1. Play listing'i 6 dile çevir + başlık/kısa açıklama optimizasyonu (gün 1–3)
2. Ekran görüntüsü metinlerini yenile, listing experiment başlat (gün 3–7)
3. `in_app_review` ile puan isteme ekle (gün 7, ~1 saat kod)
4. Regl uygulamasına çapraz tanıtım kartı (gün 7–10)
5. UTM linkleri + ölçüm rutini (gün 10)
6. İçerik motoru: haftada 3 video, İngilizce (gün 14'ten itibaren sürekli)
7. Reddit katılımı → tek lansman paylaşımı (gün 21–30)
8. Product Hunt lansmanı (gün 30)
9. Bütçe: ay 1 tasarım, ay 2 kreatif testi (gün 30–90)
10. 90. gün: verilere bak, premium mü hacim mi kararını ver

## Doğrulama

Bu planın işe yarayıp yaramadığı şuradan görülür:

- **2 hafta:** Play Console'da mağaza dönüşüm oranı yükselmeye başladı mı, yeni dillerden
  kurulum geliyor mu (Kullanıcı kazanımı → Ülke raporu)
- **6 hafta:** UTM'li linklerden hangi kanalın kurulum getirdiği ayrışıyor mu
- **12 hafta:** D7 tutunma %15'i geçti mi, AdMob günlük geliri ölçülebilir bir tabana
  oturdu mu
