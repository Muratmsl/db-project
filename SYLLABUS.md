# Ders Bilgileri

## Dersin amacı

Excel'de tuttuğun bir tablo bir yere kadar gider: birkaç kullanıcı, birkaç bin satır, tek bir dosya. Gerçek bir ürün, bir chatbot'un konuşma geçmişi, bir filonun sensör verisi, bir hastanenin kayıt sistemi, aynı anda birden fazla kişinin okuyup yazdığı, milyonlarca satırlık, hatasız kalması gereken bir veri katmanı ister. Bu ders sana o katmanı kurmayı öğretir: PostgreSQL ile.

Dönem boyunca tek bir soruyu cevaplarsın: bu veriye nasıl güvenilir biçimde soru sorarım? İlk haftalarda hazır bir veritabanını sorgulayarak başlarız (SELECT, WHERE, GROUP BY, JOIN). Tasarım ve modelleme (E-R diyagramı, normalizasyon, DDL) sorgu deneyiminden sonra gelir, çünkü neyi modelleyeceğini önce ne sorduğunu görmeden bilemezsin.

## Öğrenme çıktıları

Bu dersi tamamlayan öğrenci:

1. Bir VTYS'nin hangi problemleri çözdüğünü ve PostgreSQL'in istemci-sunucu mimarisini açıklar.
2. SELECT, WHERE, GROUP BY, JOIN (INNER/LEFT/self-join) ve alt sorguyla çok adımlı analiz sorguları yazar.
3. NULL'ın sorgu sonuçlarını nasıl etkilediğini açıklar ve eksik veriyi bilinçli olarak ele alır.
4. Bir problem senaryosundan E-R modeli çıkarır, normalize edilmiş (1NF-3NF) bir ilişkisel şemaya dönüştürür ve `CREATE TABLE` ile hayata geçirir.
5. INSERT/UPDATE/DELETE, transaction ve UPSERT kullanarak veri bütünlüğünü bozmadan veri taşır.
6. Görünüm (view) tanımlar, indeksin ne zaman işe yaradığını açıklar.
7. En az yetki ilkesine göre rol, `GRANT`/`REVOKE` tasarlar, SQL injection riskini açıklar.
8. Projesine bir yapay zeka bileşeni ekler: `jsonb` ile yarı yapılandırılmış veri, pgvector ile anlamsal arama ya da bir LLM'in ürettiği SQL'i şemasına karşı doğrulama.
9. Çalışmasını README, ERD, demo videosu ve canlı bir savunmayla profesyonel biçimde sunar.
10. Git/GitHub ile sürüm kontrollü, tekrar üretilebilir bir veritabanı projesi yönetir.

Bu çıktılar araçtan bağımsız yazıldı. PostgreSQL bu dönemki aracımız, ama öğrendiğin kavramlar (ilişkisel model, normalizasyon, transaction, indeks, en az yetki ilkesi) her VTYS'de geçerli.

## Ders yapısı

Haftada 2 saat ders ve 2 saat laboratuvar, **12 hafta**. Laboratuvar dersin devamı olarak aynı hafta içinde uygulamadır. İlk iki hafta algoritmik düşünme ve Python'la for/if tekrarına ayrılır, veritabanı konuları Hafta 3'ten başlar.

Haftalık konu listesi için [README.md](README.md) tablosuna bak.

### Dönem akışı

| Haftalar | Aşama | Ne yapıyorsun |
|---|---|---|
| 1-2 | Hazırlık | Algoritmik düşünme, döngü ve koşul |
| 3-6 | Sorgulama | Hazır bir veritabanına soru sorma: SELECT, GROUP BY, JOIN |
| 7 | Tasarım | Kendi senaryonun E-R modeli ve normalizasyonu |
| 8 | Ara değerlendirme | Mini proje sunumu |
| 9-11 | Kurma | Şemayı kurma, veriyi taşıma, görünüm, güvenlik, YZ bileşeni |
| 12 | Teslim | Jüri önünde final sunumu |

## Değerlendirme

| Bileşen | Ağırlık | İçerik |
|---|---|---|
| Ara sınav | %30 | Hafta 8, mini proje ve sunum |
| Proje | %30 | 6 ödevin ortalaması (en düşük bir not atılır) |
| Yarıyıl sonu | %40 | Ana proje ve sektör jürisi önünde 5 dakikalık sunum |

Yazılı sınav yok: sorgu yazar, şema kurar, sonra savunursun.

Ödev teslim kuralları, takvim ve geç teslim politikası: **[ODEVLER.md](ODEVLER.md)**
Her bileşenin ayrıntılı değerlendirme ölçütleri: **[RUBRIK.md](RUBRIK.md)**

## Kurallar

- Her hafta commit at. Son gece atılan tek dev commit yerine haftalar boyunca ilerleyen bir geçmiş istiyorum.
- Ödevler PR ile teslim edilir, kâğıt rapor derste elden verilir. İkisi de zorunludur.
- Tablo ve sütun adları İngilizce, küçük harf ve `snake_case`: `sensor_readings`, `battery_level`.
- YZ kullanmak serbest, beyan zorunlu. Lab föyünün YZ kullanım beyanı bölümüne hangi aracı, hangi prompt ile kullandığını yaz.
- Her projede en az bir gerçek veri kaynağı olacak.
- Şifre, API anahtarı ve kişisel veri repoya girmez.
- LinkedIn paylaşımı gönüllüdür ve notu etkilemez.
- Çalışmalar bireyseldir, her öğrenci kendi senaryosunda çalışır.

## Erişilebilirlik

Görme, işitme ya da başka bir nedenle farklı bir düzenlemeye ihtiyacın varsa derse gelmeden bana yazman yeterli: büyük punto föy, sınavda ek süre veya farklı sunum biçimi birlikte planlanır. Haftalık slaytların metin sürümü ayrıca yayımlanır.

## İletişim

Kurulum sorunu, ödev takılması ya da ders içeriğiyle ilgili sorular için GitHub üzerinden bir Issue aç ya da ders/lab saatinde sor.
