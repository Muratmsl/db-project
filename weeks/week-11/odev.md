# Ödev 6: Görünüm, güvenlik ve YZ bileşeni

> **Bu ödev henüz açılmadı.** Konusu belli, tarihi değil. Şu an aktif olan tek ödev [Ödev 1](../week-05/odev.md), son teslim 23 Ekim 2026 Cuma. Buradaki yönergeyi şimdiden okuyabilirsin.

Hafta 11 konusu. 100 puan. Dönemin son haftalık ödevi.

**Son teslim: tarih sonra duyurulacak, ders saatinden önce GitHub'da. Kâğıt rapor final günü derste.**

## Amaç

Projeni sunuma hazır hale getirmek. Bu ödevin çıktıları doğrudan final teslimine girer, yani iki kere iş yapmıyorsun.

## Yapılacaklar

### Bölüm 1: Görünümler (zorunlu)

`migrations/002_views.sql` dosyasında en az **iki view** tanımla.

İyi bir view, tekrar eden bir raporu tek isme indirger:

```sql
CREATE OR REPLACE VIEW critical_robots AS
SELECT r.name, r.zone, r.battery_level, o.phone
FROM robots r
LEFT JOIN operators o ON r.operator_name = o.operator_name
WHERE r.status = 'active' AND r.battery_level < 20;
```

- [ ] En az 2 view
- [ ] Her birinin ne işe yaradığı yorum olarak yazılmış
- [ ] En az biri JOIN içeriyor

### Bölüm 2: İndeks (zorunlu)

`migrations/003_indexes.sql` dosyasında en az **bir indeks** oluştur ve gerekçelendir.

Gerekçe şöyle olmalı:

- [ ] İndeks öncesi `EXPLAIN ANALYZE` çıktısı
- [ ] `CREATE INDEX` ifadesi
- [ ] İndeks sonrası `EXPLAIN ANALYZE` çıktısı
- [ ] İki çıktı arasındaki farkın yorumu (sequential scan → index scan oldu mu, süre ne kadar düştü)

> Küçük tablolarda indeks fark yaratmayabilir, hatta PostgreSQL onu kullanmayabilir. Bu da bir bulgudur: raporunda "fark görmedim, çünkü tablom küçük" demek, uydurma bir hızlanma yazmaktan iyidir.

### Bölüm 3: Güvenlik (zorunlu)

`migrations/004_roles.sql` dosyasında en az **bir rol** tanımla.

```sql
CREATE ROLE app_readonly;
GRANT CONNECT ON DATABASE benim_projem TO app_readonly;
GRANT USAGE ON SCHEMA public TO app_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_readonly;
```

Raporunda: bu role neden sadece bu yetkileri verdin? En az yetki ilkesini kendi projen üzerinden açıkla.

### Bölüm 4: Yapay zeka bileşeni (zorunlu, birini seç)

**Seçenek A (jsonb):** yarı yapılandırılmış bir veriyi `jsonb` sütununda sakla ve `->`, `->>`, `@>` operatörleriyle sorgula.

**Seçenek B (pgvector):** hazır embedding'lerle anlamsal arama kur. En yakın 5 kaydı bulan bir sorgu yaz.

**Seçenek C (text-to-SQL değerlendirmesi):** bir LLM'e kendi şemanı ver, ondan 5 soru için SQL üretmesini iste. Her üretilen sorguyu çalıştır ve değerlendir:

| Soru | LLM'in ürettiği SQL | Çalıştı mı | Doğru mu | Hata türü |
|---|---|---|---|---|
| | | | | |

Bu tabloyu `odevler/odev-06/text-to-sql.md` içine koy. En ilginç kısmı: **çalışan ama yanlış** sorgular. Varsa onları ayrıca anlat.

## Teslim

| Ne | Nerede |
|---|---|
| Görünümler | `migrations/002_views.sql` |
| İndeks ve gerekçe | `migrations/003_indexes.sql` |
| Roller | `migrations/004_roles.sql` |
| YZ bileşeni | `odevler/odev-06/` |
| Rapor (dijital) | `odevler/odev-06/rapor.md` |
| PR | Branch `odev-06`, reviewer: gizemturker |
| **Rapor (kâğıt)** | **Hafta 12, final günü elden** |

## Değerlendirme

[RUBRIK.md bölüm 1](../../RUBRIK.md).

> Bu ödevin çıktıları final rubriğinin C ve D ölçütlerine doğrudan girer. İyi yaparsan final işinin yarısı bitmiş olur.
