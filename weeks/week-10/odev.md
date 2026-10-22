# Ödev 5: Veriyi taşıma (DML)

> **Bu ödev henüz açılmadı.** Konusu belli, tarihi değil. Şu an aktif olan tek ödev [Ödev 1](../week-05/odev.md), son teslim 23 Ekim 2026 Cuma. Buradaki yönergeyi şimdiden okuyabilirsin.

Hafta 10 konusu. 100 puan.

**Son teslim: tarih sonra duyurulacak, ders saatinden önce GitHub'da. Tek sayfalık kâğıt rapor aynı gün derste.**

## Amaç

Ham CSV'ni, Hafta 9'da kurduğun şemaya güvenli biçimde taşımak. Artık gerçek veriyle çalışıyorsun.

## Yapılacaklar

### Bölüm 1: Veriyi yükle (zorunlu)

`data/seed/` klasörüne yükleme dosyalarını koy. İki yol var, hangisini kullandığını raporunda belirt:

- `\copy` ile doğrudan CSV'den
- `INSERT` ifadeleriyle (veriyi önce temizlediysen)

Dosyan tekrar çalıştırılabilir olsun: baştan `TRUNCATE` ya da `DELETE` ile temizle.

- [ ] Bütün tablolara veri yüklendi
- [ ] Yabancı anahtar ilişkileri tutuyor (yükleme sırası doğru: önce ana tablo, sonra bağlı tablo)
- [ ] En az 50 satır gerçek veri var

### Bölüm 2: Güvenli DML alışkanlığı (zorunlu)

`odevler/odev-05/dml-denemeleri.sql` dosyasında şunları göster:

- [ ] **Önce SELECT, sonra UPDATE:** bir güncelleme yapmadan önce aynı `WHERE` ile `SELECT` çalıştır, kaç satır etkileneceğini gör, sonra `UPDATE` yap
- [ ] **Transaction ile kurtarma:** `BEGIN` ile başla, bilerek yanlış bir `UPDATE` çalıştır, `SELECT` ile hasarı gör, `ROLLBACK` ile geri al, tekrar `SELECT` ile düzeldiğini göster
- [ ] **RETURNING:** bir `INSERT` sonrası eklenen satırı `RETURNING` ile geri al
- [ ] **UPSERT:** `INSERT ... ON CONFLICT` ile var olan bir kaydı güncelle

Her adımın altına ne olduğunu yorum olarak yaz.

```sql
-- Guvenli UPDATE alistirmasi
BEGIN;

-- 1) Once bakalim: kac satir etkilenecek?
SELECT count(*) FROM robots WHERE zone = 'Depo A';
-- 2 satir

-- 2) Simdi guncelleyelim
UPDATE robots SET zone = 'Depo C' WHERE zone = 'Depo A';
-- UPDATE 2  --> beklenen sayi, iyi

ROLLBACK;
-- Deneme bitti, veri eski halinde.
```

### Bölüm 3: İlk gerçek analiz (zorunlu)

Artık kendi verin veritabanında. Hafta 3'te yazdığın beş Türkçe sorudan **üçünü** gerçek SQL'e çevir ve çalıştır.

`queries/analiz-01.sql` dosyasına koy. Her sorgunun üstünde Türkçe soru, altında sonucun yorumu olsun.

## Teslim

| Ne | Nerede |
|---|---|
| Yükleme dosyaları | `data/seed/` |
| DML denemeleri | `odevler/odev-05/dml-denemeleri.sql` |
| Analiz sorguları | `queries/analiz-01.sql` |
| Rapor (dijital) | `odevler/odev-05/rapor.md` |
| PR | Branch `odev-05`, reviewer: gizemturker |
| **Rapor (kâğıt)** | **Hafta 11 dersinde elden** |

## Raporda özellikle cevaplamanı istediklerim

1. Veriyi yüklerken hangi sorunla karşılaştın? (tip uyuşmazlığı, boş hücre, tarih biçimi, Türkçe karakter…) Nasıl çözdün?
2. Yabancı anahtar kısıtı bir yükleme denemeni reddetti mi? Hangi satır ve neden?
3. `ROLLBACK` denemende ne hissettin? (Bu ciddi bir soru: geri alınabilir olmanın güvenini fark etmeni istiyorum.)

## Değerlendirme

[RUBRIK.md bölüm 1](../../RUBRIK.md).
