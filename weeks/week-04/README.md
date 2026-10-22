# Hafta 4: Ortam kurulumu, SELECT ve WHERE

Durum: Yayında

## Bu hafta ne işliyoruz

- Çalışma ortamını açma ve örnek veritabanlarına bağlanma
- `SELECT`, `FROM`, sütun seçimi, takma adlar (`AS`)
- `WHERE`: karşılaştırma operatörleri, `AND`, `OR`, `NOT` ve parantez
- `BETWEEN`, `IN`, `LIKE`, `ILIKE`
- `ORDER BY`, `LIMIT`, `OFFSET`, `DISTINCT`
- Sorgunun mantıksal işlenme sırası: FROM, WHERE, SELECT, ORDER BY, LIMIT
- Türkçe metin sıralama sorunu ve `COLLATE "tr-TR-x-icu"`

## Hafta sonunda yapabileceklerin

- Türkçe sorulmuş bir soruyu tek tablolu bir SQL sorgusuna çevirebilirsin
- Bir sorgunun sonucunu belirli bir koşula, sıralamaya ve limite göre daraltabilirsin
- Kendi ortamını açıp ilk sorgunu çalıştırabilirsin
- Bir sorgu beklediğin sonucu vermediğinde nereye bakacağını bilirsin

## Bu haftanın dosyaları

- [ders-notu.md](ders-notu.md): haftanın ders notu, çalıştırılabilir örneklerle
- [lab.md](lab.md): laboratuvar föyü, 15 soru

Bu haftanın **metin sürümü** `ders-notu.md` dosyasıdır: slaytlardaki her konuyu, her sorguyu ve her sonucu içerir, ekran okuyucuyla okunabilir ve tarayıcıda büyütülebilir. Slayt sırasına göre ayrı bir `slides-text.md` slaytlar güncellendiğinde eklenecek.

## Hazırlık

Ders öncesi örnek veritabanlarını kur: [data/README.md](../../data/README.md)

```bash
createdb robot_fleet && psql -d robot_fleet -f data/robot_fleet.sql
createdb llm_ops     && psql -d llm_ops     -f data/llm_ops.sql
```

Kuramazsan sorun değil, lab saatinde birlikte kurarız.

## Anahtar terimler

| English | Türkçe |
|---|---|
| select / from | seçme / kaynak tablo |
| where / filter | koşul / filtreleme |
| alias | takma ad (`AS`) |
| comparison operator | karşılaştırma operatörü |
| pattern matching | kalıp eşleştirme (`LIKE`) |
| order by (ascending, descending) | sıralama (artan, azalan) |
| limit / offset | sınırlama / atlama |
| distinct | benzersiz (tekrarsız) |
| collation | harmanlama (sıralama kuralı) |

Tüm terimler: [GLOSSARY.md](../../GLOSSARY.md)

## Laboratuvar

Kolaydan zora 15 soru: [lab.md](lab.md). Kendi programının veritabanında çalış, bitirirsen diğerine geç.

## Okuma

PostgreSQL Tutorial, Querying a Table: https://www.postgresql.org/docs/current/tutorial-select.html

## Ek kaynaklar

- SQLBolt, ders 1-5 (tarayıcıda, kurulum yok): https://sqlbolt.com/
- Select Star SQL, Bölüm 1 (gerçek veri üzerinde sorgu yazma): https://selectstarsql.com/

## Kilometre taşı

Gerçek veri kaynağı, ham CSV

## Ödev

Bu haftanın lab soruları **Ödev 1**'in Bölüm 1'i.

Yönerge: [../week-05/odev.md](../week-05/odev.md)

- PR ile teslim: branch `odev-01`, reviewer **gizemturker**
- **Kâğıt rapor derste elden teslim edilir**

Kurallar: [ODEVLER.md](../../ODEVLER.md), rubrik: [RUBRIK.md](../../RUBRIK.md)
