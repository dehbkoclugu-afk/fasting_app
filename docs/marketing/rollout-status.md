# Pazarlama lansmanı — durum ve devir notu

Son güncelleme: 2026-08-16. Bu dosya 90 günlük pazarlama planının nerede olduğunu
tutar. Yeni bir oturum ya da yeni biri devraldığında okunacak ilk dosya budur.

## Tek cümlelik durum

Planın **yazıyla halledilebilecek kısmının tamamı bitti ve PR'da**; kalan her şey
Play Console, tasarım ve çekim işi — yani repo dışında.

## Nerede duruyor

- Branch: `claude/fasttrack-marketing-plan-ov80u7`
- PR: [#10](https://github.com/dehbkoclugu-afk/fasting_app/pull/10) → `main`, 5 commit, henüz merge edilmedi
- CI: `Android build` push edilen her commit'te yeşil. Kod değişikliğini taşıyan
  commit `4a73023`; sonrakiler yalnızca doküman ve mağaza metni.

| Commit | İçerik |
|---|---|
| `0e8b26a` | 90 günlük pazarlama planı |
| `4a73023` | `in_app_review` ile puan isteme (tek kod değişikliği) |
| `72f8929` | 6 dilde ASO optimizasyonu |
| `7c338ef` | Ekran görüntüsü metinleri + UTM linkleri |
| `c8f9ee0` | Video çekim listesi + lansman metinleri |

## Dosyalar

| Dosya | Ne işe yarar |
|---|---|
| `docs/marketing/2026-08-16-90-day-marketing-plan.md` | Ana plan: bütçe, konumlandırma, 3 faz, ölçüm hedefleri, 90. gün karar noktası |
| `docs/marketing/screenshot-copy.md` | 5 kare × 6 dil mağaza görseli metni + tasarımcı brief'i |
| `docs/marketing/utm-links.md` | Kanal başına hazır, etiketli Play linkleri |
| `docs/marketing/video-scripts.md` | 8 klip çekim listesi + 3 haftalık yayın takvimi |
| `docs/marketing/launch-posts.md` | Reddit ve Product Hunt metinleri + lansman günü kontrol listesi |
| `store_metadata/app_store_*.txt` | 6 dilde mağaza metni — konsola girilecek kaynak |
| `lib/services/review_service.dart` | Puan isteme servisi |

## Kararlaştırılmış çerçeve (yeniden tartışılmasın)

- **Bütçe:** aylık 1.000–3.000 ₺
- **Pazar:** önce global / İngilizce
- **İçerik:** ekran kaydı, yüz ve ses yok
- **Premium:** şimdilik değişmiyor, önce trafik
- **Konumlandırma:** "Fasting without the pressure" — kilo vaadi yok, hesap yok, veri cihazda
- **Ölçüt:** kurulum sayısı değil **D7 tutunma**. Gelir ağırlığı reklamda olduğu için
  hedef çok ödeyen değil, çok ve düzenli açan kullanıcı.
- **Gerçekçi beklenti:** 10.000 kurulum → ~2.500 aylık aktif → aylık ~30–150 $ reklam +
  ~20–40 abone. Bu planın amacı gelir patlaması değil, 90. gündeki "premium mü hacim mi"
  kararı için veri üretmek.

## Sıradaki iş — kim yapacak

### Play Console (kullanıcı)

1. **6 dilde mağaza girişi.** Metinler `store_metadata/` altında hazır ve limitlere göre
   doğrulandı. Play Console → Mağaza girişi → dil ekle → yapıştır. **En yüksek getirili
   tek iş bu.**
   Not: otomatik makine çevirisi açık olsa bile elle girilen listing onu geçersiz kılar;
   ikisi yarışmıyor.
2. **UTM linklerini test et** (`utm-links.md`), sonra kanallarda kullanmaya başla.
3. **Listing experiments** başlat — ücretsiz A/B testi, bütçe harcamadan önce çalıştır.

### Tasarım (Ay 1 bütçesi, ~1.500 ₺)

4. Ekran görüntüsü seti. Metin ve brief `screenshot-copy.md` içinde hazır; tasarımcının
   beklemesine gerek yok.

### Çekim (kullanıcı)

5. 8 klip, tek oturumda toplu çekim. Liste `video-scripts.md`. Haftada 3 yayın.

### Topluluk (kullanıcı)

6. Reddit'te **önce iki hafta gerçek katılım**, sonra tek paylaşım. Metinler
   `launch-posts.md`. Göndermeden önce her subreddit'in kural sayfasını oku.
7. Product Hunt lansmanı (gün 30).

### Repo tarafında kalan tek iş

8. **Çapraz tanıtım kartı.** Regl takip uygulamasına (Döngü Takip) FastTrack'i tanıtan
   bir in-app kart. O repo bu oturuma bağlı değildi; `add_repo` ile eklenmesi gerekiyor.
   Hedef link `utm-links.md` içindeki `utm_source=dongutakip` linki.

## Doğrulanmamış olanlar

Bunlar bilinmiyor, "çalışıyor" diye varsayma:

- **Puan isteme akışının cihazdaki davranışı.** CI yalnızca derlendiğini doğruladı.
  Play'den kurulmuş bir build'de 3 oruç tamamla, tamamlanma ekranını kapat: puan sayfası
  açılmalı, **o seferde interstitial gelmemeli**, tekrarında bir daha sormamalı. Debug
  build'de Play sayfayı çoğu zaman göstermez; log'daki
  `Review request sent after N fasts.` satırı entegrasyonun doğru olduğunu gösterir.
- **UTM linkleri tarayıcıda açılmadı.** Geliştirme ortamından `play.google.com`'a çıkış
  engelli. Biçim doğru ama yayınlamadan önce bir kez aç.
- **Subreddit kuralları okunmadı.** Aynı sebep. Self-promo için mod izni ya da belirli
  gün isteyen subreddit'ler var.
- **de/fr/es/pt çevirileri anadili konuşuru gözünden geçmedi.**

## Bilinmesi gereken tuzaklar

- **Play, `utm_*` parametrelerini doğrudan URL'den okumaz.** Kaynağı yalnızca
  URL-encode edilmiş tek bir `referrer` parametresinden alır. Yanlışsa **sessizce**
  başarısız olur — kurulum "organik" görünür, hata mesajı gelmez. Doğru biçim
  `utm-links.md` içinde.
- **Uygulamada 14:10 planı yok.** Plan listesi: 12:12, 16:8, 18:6, 20:4, OMAD, 5:2,
  Eat-Stop-Eat, Warrior (`lib/core/constants/fasting_plans.dart`). Ücretsiz olanlar
  12:12 ve 16:8. Mağaza metinleri eskiden olmayan 14:10'u tanıtıyordu, düzeltildi —
  yeni metin yazarken tekrar sokma.
- **iOS henüz canlı değil.** `lib/core/config/build_config.dart` içinde
  `_iosStoreUrlFallback`, `_revenueCatIosKeyFallback` ve iOS AdMob unit'leri boş.
  Apple Search Ads maddesi bu yüzden koşullu; App Store kampanya linkleri de Play'in
  `referrer` biçiminden farklı çalışır (`pt` / `ct` parametreleri).
- **Tıbbi iddia yok.** Ne mağaza metninde, ne videoda, ne anahtar kelimede. Hem Play
  sağlık politikası hem ürünün duruşu. Anahtar kelimelere bilerek "kilo verme / abnehmen
  / weight loss" tipi terimler konmadı.
- **Sorumluluk reddi paragrafı harfiyen korunacak.** Altı dilde de bilerek yazılmış;
  parafraze edilecek yer değil.
- **Türkçe başlıkta tercih yapıldı:** `Oruç Takibi` yerine `Aralıklı Oruç`. "Oruç takibi"
  Ramazan aramalarından hacim çeker ama o kullanıcı imsakiye arıyor — kurup siler, kaldırma
  oranını yükseltir. Geri almak istenirse tek satır.
- **Fransızca başlık tam 30/30 karakter.** Payı yok. Konsol itiraz ederse iki nokta
  öncesindeki boşluğu kaldır (29 olur).

## Puan isteme akışının tasarımı (değiştirmeden önce oku)

`lib/services/review_service.dart` → `maybeRequestReview(db)`, `timer_screen.dart`
içindeki `_afterCompletionDismissed()`'tan çağrılıyor.

- **Puan sayfası ile interstitial sırayla çalışır.** Tamamlanma ekranı kapanışı premium
  olmayan kullanıcıya zaten reklam gösteriyordu. İkisi de tam ekran; üst üste binerse
  Google sessizce hiçbir şey göstermeyebilir. Puan istenen tek seferde reklam atlanır —
  kullanıcı ömrü boyunca bir gösterim kaybı.
- **`review_requested` bayrağı istek gönderildiğinde yazılır, puan verildiğinde değil.**
  Hiçbir mağaza kullanıcının puan verip vermediğini bildirmiyor ve ikisi de kendi kotasını
  uyguluyor (App Store yılda 3), yani güvenilebilecek tek sinyal "sorduk".
- **Yeni sayaç yok.** `AppDatabase.getCompletedSessions()` zaten vardı ve geçmiş oruçları
  doğru sayıyor. `finalizeActiveSession` overlay tetiklenmeden önce await edildiği için
  3. oruçta sayım doğru.
- **`isAvailable()` guard'ı** sideload build'lerde çökmeyi engelliyor.
- **l10n değişikliği yok** — puan sayfasını işletim sistemi cihaz diline göre kendisi
  render ediyor.

## 90. günde karar

- **Tutunma iyi, dönüşüm düşük** (muhtemel senaryo) → premium'u güçlendir: gelişmiş
  istatistik, kişisel oruç planı, veri dışa aktarma. Aynı trafikten kat kat gelir.
- **Tutunma düşük** → pazarlama değil ürün sorunu; onboarding ve ilk hafta deneyimine dön.
