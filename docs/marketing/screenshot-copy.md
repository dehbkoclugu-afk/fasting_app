# Ekran görüntüsü metinleri (6 dil)

Pazarlama planı Faz 0, madde 3. Bu dosya tasarımcıya verilecek metni içerir —
görselleri Ay 1 bütçesiyle dışarıya yaptıracaksın, ama metin önce hazır olmalı,
yoksa tasarımcı yer tutucuyla çalışır ve iki tur döner.

## Kurallar

- Play'de **ilk 3 görsel kritik**; çoğu kullanıcı dördüncüyü hiç görmez. Sıralama
  aşağıdaki gibi olmalı.
- Her görselde **tek cümle**. Özellik değil fayda yaz.
- Telefonda okunabilirlik için üst şeritte, en fazla 6–8 kelime.
- Play en fazla 8 telefon görseli kabul eder; 5 tanesi fazlasıyla yeterli.
- Aynı metinler App Store için de kullanılır (iOS yayına girdiğinde).

## Kare 1 — Çalışan oruç zamanlayıcısı

Ekran: `lib/features/timer/screens/timer_screen.dart`, faz halkası oruç ortasında
(`fasting_ring.dart`). Halkanın renk aldığı, saatin ilerlediği bir an seç.

| Dil | Metin |
|---|---|
| en | See what your body is doing, hour by hour |
| tr | Vücudunda saat saat ne oluyor, gör |
| de | Stunde für Stunde: was dein Körper macht |
| es | Hora a hora, qué hace tu cuerpo |
| fr | Heure par heure, ce que fait votre corps |
| pt | Hora a hora, o que seu corpo faz |

## Kare 2 — Metabolik yolculuk

Ekran: `lib/features/timer/widgets/metabolic_journey.dart`. Ketozis evresi görünür
olsun.

| Dil | Metin |
|---|---|
| en | Ketosis at hour 16 — explained, not promised |
| tr | 16. saatte ketozis — vaat değil, açıklama |
| de | Ketose ab Stunde 16 — erklärt, nicht versprochen |
| es | Cetosis en la hora 16: explicada, no prometida |
| fr | Cétose à la 16e heure : expliquée, pas promise |
| pt | Cetose na hora 16: explicada, não prometida |

"Vaat değil, açıklama" ayrımı bilinçli. Rakipler burada sonuç vaat ediyor; bizim
mağaza metnimiz ve uygulama içi dilimiz evre saatlerinin tahmin olduğunu söylüyor.
Görselde de aynı çizgide kal — aksi hem konumlandırmayı hem Play sağlık
politikasını zorlar.

## Kare 3 — İlerleme ve düzen

Ekran: `lib/features/stats/screens/stats_screen.dart`, aylık ısı haritası ve seri
kartı görünür (`monthly_heatmap.dart`, `streak_card.dart`). Dolu ama kusursuz
olmayan bir ay seç — birkaç boş gün olsun, mesaj bu.

| Dil | Metin |
|---|---|
| en | Your rhythm, not a scoreboard |
| tr | Senin ritmin, skor tablosu değil |
| de | Dein Rhythmus, keine Punktetafel |
| es | Tu ritmo, no un marcador |
| fr | Votre rythme, pas un tableau de scores |
| pt | Seu ritmo, não um placar |

## Kare 4 — Su ve kilo

Ekran: `lib/features/water/screens/water_tracker_screen.dart` ve
`lib/features/weight/screens/weight_tracker_screen.dart` (BMI göstergesiyle) —
ikisi tek karede yan yana.

| Dil | Metin |
|---|---|
| en | Water and weight, in the same place |
| tr | Su ve kilo, aynı yerde |
| de | Wasser und Gewicht an einem Ort |
| es | Agua y peso, en el mismo sitio |
| fr | Eau et poids, au même endroit |
| pt | Água e peso, no mesmo lugar |

## Kare 5 — Gizlilik

Bu karenin tek bir ekranı yok; metin öne çıkar, arkada profil ekranı
(`lib/features/profile/screens/profile_screen.dart`) yumuşatılmış durur. Rakiplerin
hepsi kayıt zorunlu tuttuğu için bu kare bir ayrışma noktası.

| Dil | Metin |
|---|---|
| en | No account. Your data stays on your phone. |
| tr | Hesap yok. Verin telefonunda kalır. |
| de | Kein Konto. Deine Daten bleiben auf dem Gerät. |
| es | Sin cuenta. Tus datos se quedan en tu móvil. |
| fr | Pas de compte. Vos données restent sur votre téléphone. |
| pt | Sem conta. Seus dados ficam no seu celular. |

## Tasarımcıya brief

- Uygulamanın kendi paleti: birincil `#6C63FF`, koyu zemin `#0F0F1A`
  (`pubspec.yaml` içindeki launcher/splash ayarları ve `lib/core/theme/app_colors.dart`).
- Koyu tema kullan — uygulamanın karakteri o, ayrıca mağaza listesinde kontrast
  yüksek çıkıyor.
- Cihaz çerçevesi opsiyonel; metin şeridi üstte sabit yükseklikte olsun ki altı dil
  aynı şablonda dursun.
- Almanca ve Fransızca metinler en uzunu — şablonu onlara göre boyutlandır, kısa
  dillerde boşluk sorun değil.

## Sonraki adım

Görseller geldiğinde Play Console → Mağaza girişi → **Listing experiments** ile
eskisiyle A/B testine sok. Ücretsiz ve dönüşüm farkını ölçmenin tek dürüst yolu bu;
bütçe harcamadan önce çalıştır.
