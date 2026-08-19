# Kanal takip linkleri (UTM)

Pazarlama planı Faz 0, madde 5. İçerik yayına girmeden **önce** kurulmalı: etiketsiz
gönderilen bir link geriye dönük etiketlenemez, o kanalın 90 gün boyunca getirdiği
kurulum ölçülemez kalır.

## Nasıl çalışıyor

Play, kurulumun kaynağını `referrer` parametresinden okur — standart `utm_*`
parametrelerini doğrudan URL'ye eklemek işe yaramaz. Doğru biçim, `utm_*` çiftlerini
**URL-encode edilmiş tek bir `referrer` değeri** içine koymaktır:

```
https://play.google.com/store/apps/details?id=com.dehbkoclugu.fasttrack&referrer=utm_source%3DKAYNAK%26utm_medium%3DORTAM%26utm_campaign%3DKAMPANYA
```

`%3D` = `=`, `%26` = `&`. Bu kodlama bozulursa Play parametreyi sessizce yok sayar ve
kurulum "organik" görünür — yani hata verdiğini fark etmezsin. Linki yayınlamadan
önce mutlaka tarayıcıda aç ve mağaza sayfasının açıldığını doğrula.

Raporlama: Play Console → **Kullanıcı kazanımı** → kaynağa göre kırılım. Veride 2–3
günlük gecikme var, aynı gün bakıp panik yapma.

## Hazır linkler

Paket adı: `com.dehbkoclugu.fasttrack` (`android/app/build.gradle.kts:33`).

### Kısa video — organik

TikTok, Reels ve Shorts'a aynı klipler gidiyor ama **ayrı kaynak** kullan; hangisinin
çalıştığını ancak böyle görürsün.

```
# TikTok (bio linki)
https://play.google.com/store/apps/details?id=com.dehbkoclugu.fasttrack&referrer=utm_source%3Dtiktok%26utm_medium%3Dsocial%26utm_campaign%3Dorganic_video

# Instagram Reels (bio linki)
https://play.google.com/store/apps/details?id=com.dehbkoclugu.fasttrack&referrer=utm_source%3Dinstagram%26utm_medium%3Dsocial%26utm_campaign%3Dorganic_video

# YouTube Shorts (açıklama linki)
https://play.google.com/store/apps/details?id=com.dehbkoclugu.fasttrack&referrer=utm_source%3Dyoutube%26utm_medium%3Dsocial%26utm_campaign%3Dorganic_video
```

### Topluluk

```
# Reddit — r/intermittentfasting, r/fasting lansman paylaşımı
https://play.google.com/store/apps/details?id=com.dehbkoclugu.fasttrack&referrer=utm_source%3Dreddit%26utm_medium%3Dcommunity%26utm_campaign%3Dlaunch_post

# Product Hunt
https://play.google.com/store/apps/details?id=com.dehbkoclugu.fasttrack&referrer=utm_source%3Dproducthunt%26utm_medium%3Dcommunity%26utm_campaign%3Dlaunch
```

### Çapraz tanıtım

Regl takip uygulamasındaki kart bu linke gitmeli. Kendi trafiğin olduğu için en temiz
ölçüm burada çıkar.

```
https://play.google.com/store/apps/details?id=com.dehbkoclugu.fasttrack&referrer=utm_source%3Ddongutakip%26utm_medium%3Dcrosspromo%26utm_campaign%3Din_app_card
```

### Ücretli (Ay 2)

Organikten ayrı `medium` kullan, yoksa boost edilen videonun getirdiği kurulumu
organik videodan ayıramazsın.

```
https://play.google.com/store/apps/details?id=com.dehbkoclugu.fasttrack&referrer=utm_source%3Dtiktok%26utm_medium%3Dpaid%26utm_campaign%3Dcreative_test_m2
```

## Adlandırma kuralı

Yeni kanal eklerken bu üçlüye sadık kal, yoksa rapor okunmaz hale gelir:

| Alan | Ne yazılır | Örnek |
|---|---|---|
| `utm_source` | Platformun adı, küçük harf, boşluksuz | `tiktok`, `reddit`, `dongutakip` |
| `utm_medium` | Trafiğin türü | `social`, `community`, `crosspromo`, `paid` |
| `utm_campaign` | Neyi test ettiğin | `organic_video`, `launch_post`, `creative_test_m2` |

Türkçe karakter, büyük harf ve boşluk kullanma — Play bunları ayrı değer olarak
sayar ve tek kanal raporda ikiye bölünür.

## iOS notu

Bu mekanizma yalnızca Play için. iOS henüz canlı değil (`lib/core/config/build_config.dart`
içinde `_iosStoreUrlFallback` boş). Yayına girdiğinde App Store tarafı farklı çalışır —
App Store Connect'te kampanya linki üretilir (`pt` ve `ct` parametreleri), Play'in
`referrer` biçimi orada geçersizdir. O zaman bu dosyaya ikinci bir bölüm eklenecek.
