# Sözlük (English - Türkçe)

Derste geçen teknik terimler. Anlatım Türkçe, ama terimlerin İngilizcesini bilmen gerekiyor: dokümantasyon, hata mesajları ve iş ilanları İngilizce.

Terimler dönem boyunca eklenir. Eksik bulduğun bir terim varsa Issue aç.

## Temel kavramlar

| English | Türkçe | Not |
|---|---|---|
| database | veritabanı | |
| DBMS (database management system) | VTYS (veritabanı yönetim sistemi) | Veritabanını yöneten yazılım, PostgreSQL gibi |
| relational model | ilişkisel model | |
| table / row / column | tablo / satır / sütun | Satır için *record*, sütun için *field* de denir |
| record / field | kayıt / alan | |
| schema | şema | İki anlamı var: tabloların yapısı, bir de veritabanı içindeki klasör |
| cluster | küme | Bir sunucudaki tüm veritabanları |
| client-server architecture | istemci-sunucu mimarisi | |
| query | sorgu | |
| data type | veri tipi | `integer`, `text`, `boolean`, `timestamptz` |

## SQL alt dilleri

| English | Türkçe | Örnek komut |
|---|---|---|
| DQL (data query language) | veri sorgulama dili | `SELECT` |
| DDL (data definition language) | veri tanımlama dili | `CREATE`, `ALTER`, `DROP` |
| DML (data manipulation language) | veri işleme dili | `INSERT`, `UPDATE`, `DELETE` |
| DCL (data control language) | veri kontrol dili | `GRANT`, `REVOKE` |
| TCL (transaction control language) | işlem kontrol dili | `COMMIT`, `ROLLBACK` |

## Sorgulama (Hafta 4)

| English | Türkçe | Not |
|---|---|---|
| select | seçme | Hangi sütunlar gelsin |
| where / filter | koşul / filtreleme | Hangi satırlar gelsin |
| alias | takma ad | `AS` ile verilir |
| comparison operator | karşılaştırma operatörü | `=`, `<>`, `<`, `>`, `<=`, `>=` |
| logical operator | mantıksal operatör | `AND`, `OR`, `NOT` |
| pattern matching | kalıp eşleştirme | `LIKE`, `ILIKE`, `%`, `_` |
| order by (ascending, descending) | sıralama (artan, azalan) | `ASC`, `DESC` |
| limit / offset | sınırlama / atlama | Sayfalama için |
| distinct | benzersiz (tekrarsız) | |
| collation | harmanlama (sıralama kuralı) | Türkçe sıralama için `tr-TR-x-icu` |

## Özetleme (Hafta 5)

| English | Türkçe | Not |
|---|---|---|
| aggregate function | toplama fonksiyonu | `count`, `sum`, `avg`, `min`, `max` |
| aggregation | toplulaştırma | Çok satırı tek değere indirgemek |
| group by | gruplama | |
| having | gruplanmış koşul | Gruplara uygulanan filtre |
| null | boş değer | "Bilinmiyor" demek, sıfır değil |
| three-valued logic | üç değerli mantık | doğru / yanlış / bilinmiyor |
| coalesce | boşsa yerine koyma | İlk dolu değeri döndürür |
| conditional expression | koşullu ifade | `CASE WHEN ... THEN ... ELSE ... END` |
| timestamp / time zone | zaman damgası / saat dilimi | |
| interval | zaman aralığı | `interval '7 days'` |

## Birleştirme (Hafta 6)

| English | Türkçe | Not |
|---|---|---|
| join | birleştirme | İki tabloyu tek sonuçta buluşturmak |
| inner join | iç birleştirme | Sadece iki tarafta da eşleşenler |
| left (outer) join | sol birleştirme | Soldakilerin hepsi, eşleşmeyenler NULL ile |
| self join | kendiyle birleştirme | Bir tabloyu kendisiyle birleştirmek |
| cross join / cartesian product | çapraz birleştirme / kartezyen çarpım | Her satır her satırla |
| join condition | birleştirme koşulu | `ON` ile yazılır |
| fan-out / row multiplication | satır çoğalması | JOIN sonrası yanlış toplamların sebebi |
| junction (bridge) table | ara tablo | Çoka-çok ilişkiyi çözer |

## Tasarım (Hafta 7, 9)

| English | Türkçe | Not |
|---|---|---|
| entity / entity set | varlık / varlık kümesi | |
| attribute | nitelik | |
| relationship | ilişki | |
| cardinality | kardinalite (ilişki oranı) | 1-1, 1-N, M-N |
| participation (total, partial) | katılım (zorunlu, isteğe bağlı) | |
| weak entity | zayıf varlık | |
| ERD (entity-relationship diagram) | varlık-ilişki diyagramı | |
| primary key | birincil anahtar | Satırı benzersiz tanımlar |
| foreign key | yabancı anahtar | Başka tablonun anahtarına işaret eder |
| natural key / surrogate key | doğal anahtar / yapay anahtar | İsim gibi gerçek bir değer, ya da üretilmiş `id` |
| candidate key / super key | aday anahtar / süper anahtar | |
| constraint | kısıt | `NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT` |
| referential integrity | bütünlük (gönderimsel bütünlük) | Yabancı anahtarın boşa düşmemesi |
| functional dependency | fonksiyonel bağımlılık | |
| normalization (1NF, 2NF, 3NF, BCNF) | normalizasyon | |
| denormalization | denormalizasyon | Bilinçli olarak tekrarı kabul etmek |
| anomaly (insert, update, delete) | anomali (ekleme, güncelleme, silme) | Kötü tasarımın belirtisi |
| migration | göç dosyası (şema değişikliği) | |

## Veri işleme ve işlemler (Hafta 10)

| English | Türkçe | Not |
|---|---|---|
| insert / update / delete | ekleme / güncelleme / silme | |
| upsert | varsa güncelle yoksa ekle | `INSERT ... ON CONFLICT` |
| transaction | işlem | Ya hepsi ya hiçbiri |
| commit / rollback | onaylama / geri alma | |
| ACID | ACID (atomiklik, tutarlılık, yalıtım, kalıcılık) | |
| subquery | alt sorgu | Sorgu içinde sorgu |
| CTE (common table expression) | ortak tablo ifadesi | `WITH` ile yazılır |
| seed data | başlangıç verisi | |

## Görünüm, performans, güvenlik (Hafta 11)

| English | Türkçe | Not |
|---|---|---|
| view / materialized view | görünüm / gerçekleştirilmiş görünüm | |
| index | indeks (dizin) | Aramayı hızlandırır |
| query plan | sorgu planı | `EXPLAIN` ile görülür |
| sequential scan / index scan | sıralı tarama / indeks taraması | |
| role | rol | Kullanıcı ya da kullanıcı grubu |
| grant / revoke | yetki verme / yetki alma | |
| least privilege principle | en az yetki ilkesi | Herkese sadece gereken yetki |
| row-level security (RLS) | satır düzeyinde güvenlik | |
| SQL injection | SQL enjeksiyonu | Sorguya kötü niyetli kod sızdırma |
| parameterized query | parametreli sorgu | SQL injection'a karşı doğru çözüm |
| backup / restore | yedekleme / geri yükleme | `pg_dump`, `pg_restore` |
| embedding / vector search | gömme (sayısal temsil) / vektör arama | pgvector |
| RAG (retrieval-augmented generation) | getirmeyle desteklenmiş üretim | |
| text-to-SQL | metinden SQL üretme | |

## Programlama ve araçlar (Hafta 1-2)

| English | Türkçe | Not |
|---|---|---|
| algorithm | algoritma | |
| pseudocode / flowchart | sözde kod / akış şeması | |
| trace table | iz sürme tablosu | Algoritmayı elle adım adım çalıştırma |
| variable | değişken | |
| conditional statement | koşullu ifade | `if`, `elif`, `else` |
| loop (for, while) | döngü | |
| iteration | yineleme | Döngünün her bir adımı |
| list / array | liste / dizi | |
| repository (repo) | repo | Derste İngilizcesini kullanıyoruz: "repo" |
| branch | branch | Türkçesi "dal" ama kimse öyle demiyor |
| main | main | Projenin ana branch'i |
| commit | commit | Bir değişikliği kaydetme |
| push / pull | push / pull | Gönderme / çekme |
| clone / fork | clone / fork | |
| merge | merge | İki branch'i birleştirme |
| issue | issue | Soru ya da hata kaydı |
| pull request (PR) | pull request | Branch'teki işi main'e almak için açılan istek |
| reviewer | reviewer | PR'ı inceleyen kişi |
