# Hafta 3: Veritabanı temel kavramları ve mimari

Durum: Yayında

## Bu hafta ne işliyoruz

- Dosya tabanlı sistemlerin sorunları: veri tekrarı, tutarsızlık, eşzamanlı erişim, güvenlik
- İlişkisel model: tablo, satır, sütun, şema
- SQL'in alt dilleri: DQL, DDL, DML, DCL, TCL
- İstemci-sunucu mimarisi ve küme, veritabanı, şema, tablo hiyerarşisi
- Yapay zeka sistemlerinde veritabanının yeri: LLM loglama, robotik telemetri

## Hafta sonunda yapabileceklerin

- Excel/Sheets ile bir veritabanı arasındaki temel farkları örnekle açıklayabilirsin
- Hafta 2'de `for` ve `if` ile yazdığın döngünün SQL'de neden tek satıra indiğini gösterebilirsin
- Küme, veritabanı, şema, tablo hiyerarşisini sırayla sayabilirsin
- Kendi proje reponu açıp ilk commit'ini atabilirsin

## Bu haftanın dosyaları

- [ders-notu.md](ders-notu.md): haftanın ders notu
- [slides-text.md](slides-text.md): slaytların metin sürümü
- [odev-algoritma.md](odev-algoritma.md): Hafta 1-2 alıştırmaları, Ödev 1 Bölüm 1'in kaynağı

## Anahtar terimler

| English | Türkçe |
|---|---|
| relational model | ilişkisel model |
| schema | şema |
| client-server architecture | istemci-sunucu mimarisi |
| query | sorgu |
| DQL / DDL / DML / DCL / TCL | SQL'in alt dilleri |

Tüm terimler: [GLOSSARY.md](../../GLOSSARY.md)

## Laboratuvar

1. Şablondan kendi proje reponu oluştur, adım adım: [SETUP.md](../../SETUP.md), bölüm 4
2. Canlı kurada senaryonu çek.
3. `SCENARIO.md` dosyasını doldur.
4. Repo adını projene göre değiştir (örnek: `smart-farm-drone-db`).
5. `lab-sheets/week-03.md` föyünü doldur ve commit et.

## Okuma

PostgreSQL Tutorial, giriş bölümü: https://www.postgresql.org/docs/current/tutorial-sql-intro.html

## Kilometre taşı

Kura, repo, senaryo kartı

## Ödev

Bu haftanın konusu **Ödev 1**'in 2. bölümünde: veritabanı kavramları.

Yönerge: [../week-05/odev.md](../week-05/odev.md)

Teslim kuralları: [ODEVLER.md](../../ODEVLER.md)

- `SCENARIO.md` içindeki beş soruyu tamamla.
- Senaryon için bir gerçek veri kaynağı adayı bul ve linkini `SCENARIO.md` içine yaz. Fikirler [RESOURCES.md](../../RESOURCES.md) sonundaki "Veri kaynağı bulmak için" bölümünde.
- Ek olarak, ilk iki haftanın algoritma konularını pekiştiren bir ödev var, GitHub'a değil, derse elden getireceksin: [odev-algoritma.md](odev-algoritma.md). Teslim 5 gün sonra.

## Gelecek haftaya hazırlık

Hafta 4'te ilk sorgunu çalıştıracaksın. Ders öncesi örnek veritabanlarını kurmayı dene: [data/README.md](../../data/README.md). Kuramazsan sorun değil, lab saatinde birlikte kurarız.
