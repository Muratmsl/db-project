# Ödev 4: Şema kurma (DDL)

> **Bu ödev henüz açılmadı.** Konusu belli, tarihi değil. Şu an aktif olan tek ödev [Ödev 1](../week-05/odev.md), son teslim 23 Ekim 2026 Cuma. Buradaki yönergeyi şimdiden okuyabilirsin.

Hafta 9 konusu. 100 puan.

**Son teslim: tarih sonra duyurulacak, ders saatinden önce GitHub'da. Tek sayfalık kâğıt rapor aynı gün derste.**

## Amaç

Hafta 7'de kâğıt üzerinde tasarladığın şemayı gerçekten kurmak.

## Yapılacaklar

### Bölüm 1: Migration dosyası (zorunlu)

`migrations/001_create_tables.sql` dosyasını yaz. İçinde olması gerekenler:

- [ ] Bütün tabloların `CREATE TABLE` ifadeleri
- [ ] Her tabloda birincil anahtar
- [ ] İlişkili tablolarda yabancı anahtar ve bir silme davranışı (`ON DELETE CASCADE` / `RESTRICT` / `SET NULL`)
- [ ] Uygun veri tipleri (`integer`, `text`, `numeric`, `boolean`, `date`, `timestamptz`)
- [ ] En az üç `NOT NULL` kısıtı
- [ ] En az bir `UNIQUE` kısıtı
- [ ] En az bir `CHECK` kısıtı
- [ ] En az bir `DEFAULT` değeri
- [ ] Dosyanın başında `DROP TABLE IF EXISTS` satırları (tekrar çalıştırılabilir olsun)

Dosyan baştan sona hatasız çalışmalı:

```bash
createdb benim_projem
psql -d benim_projem -f migrations/001_create_tables.sql
```

### Bölüm 2: Kısıt denemeleri (zorunlu)

`odevler/odev-04/kisit-denemeleri.sql` dosyasında, kendi şemanı **bilerek bozmaya çalış.** Her denemenin altına aldığın hata mesajını yapıştır.

En az dört deneme:

- [ ] Birincil anahtarı tekrar eden satır eklemeye çalış
- [ ] Olmayan bir yabancı anahtara işaret eden satır ekle
- [ ] `NOT NULL` sütuna NULL koy
- [ ] `CHECK` kısıtını ihlal eden değer koy

```sql
-- Deneme 1: ayni id ile iki satir
INSERT INTO robots (id, name) VALUES (1, 'Test-01');
INSERT INTO robots (id, name) VALUES (1, 'Test-02');
-- ERROR: duplicate key value violates unique constraint "robots_pkey"
-- DETAIL: Key (id)=(1) already exists.
-- Yorum: birincil anahtar tekrari engelledi, veri bozulmadan korundu.
```

### Bölüm 3: Silme davranışı (zorunlu, kısa)

Raporunda: yabancı anahtarlarında hangi silme davranışını seçtin ve neden? `CASCADE` seçtiğin bir yer varsa, yanlışlıkla ne kaybedebileceğini düşün ve yaz.

## Teslim

| Ne | Nerede |
|---|---|
| Şema | `migrations/001_create_tables.sql` |
| Kısıt denemeleri | `odevler/odev-04/kisit-denemeleri.sql` |
| Rapor (dijital) | `odevler/odev-04/rapor.md` |
| PR | Branch `odev-04`, reviewer: gizemturker |
| **Rapor (kâğıt)** | **Hafta 10 dersinde elden** |

## Değerlendirme

[RUBRIK.md bölüm 1](../../RUBRIK.md). "Doğruluk" = şemanın hatasız çalışması ve kısıtların yerinde olması.
