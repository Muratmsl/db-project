# Kaynaklar

Hiçbirini baştan sona okumak zorunda değilsin. Her haftanın README'sinde o haftayla ilgili 1-2 bağlantı ayrıca var, burası tam liste.

Kaynakların çoğu İngilizce. Bunun sebebi şu: veritabanı dünyasının birincil kaynakları İngilizce yazılıyor ve mezun olduğunda da bu sayfalara bakacaksın. Terimleri anlamakta zorlanırsan [GLOSSARY.md](GLOSSARY.md) yanında dursun.

## Ana ders kitabı

Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7. baskı, McGraw-Hill, 2019. Yazarların resmi sitesinde (db-book.com) içindekiler, örnek veritabanları ve tarayıcı içi bir SQL çalıştırma aracı ücretsiz: https://www.db-book.com/

## PostgreSQL resmi dokümantasyonu

Dönem boyunca en çok başvuracağın kaynak, https://www.postgresql.org/docs/current/ üzerinden, konuya göre:

| Konu | Hafta | Sayfa |
|---|---|---|
| Getting Started (sunucu, istemci, `psql`) | 3 | https://www.postgresql.org/docs/current/tutorial-start.html |
| Querying a Table (SELECT, WHERE) | 4 | https://www.postgresql.org/docs/current/tutorial-select.html |
| SELECT komut referansı (çalışma sırası) | 4 | https://www.postgresql.org/docs/current/sql-select.html |
| Aggregate Functions (tutorial) | 5 | https://www.postgresql.org/docs/current/tutorial-agg.html |
| Aggregate Functions (tam liste) | 5 | https://www.postgresql.org/docs/current/functions-aggregate.html |
| Date/Time Functions (`date_trunc`, `EXTRACT`, `now`) | 5 | https://www.postgresql.org/docs/current/functions-datetime.html |
| Conditional Expressions (`CASE`, `COALESCE`, `NULLIF`) | 5 | https://www.postgresql.org/docs/current/functions-conditional.html |
| Joins Between Tables | 6 | https://www.postgresql.org/docs/current/tutorial-join.html |
| Table Expressions (JOIN türleri, ayrıntılı) | 6 | https://www.postgresql.org/docs/current/queries-table-expressions.html |
| Data Definition (DDL) | 9 | https://www.postgresql.org/docs/current/ddl.html |
| Foreign Keys | 9 | https://www.postgresql.org/docs/current/tutorial-fk.html |
| Data Manipulation (DML) | 10 | https://www.postgresql.org/docs/current/dml.html |
| Transactions | 10 | https://www.postgresql.org/docs/current/tutorial-transactions.html |
| WITH Queries (CTE) | 10 | https://www.postgresql.org/docs/current/queries-with.html |
| Views | 11 | https://www.postgresql.org/docs/current/tutorial-views.html |
| Indexes | 11 | https://www.postgresql.org/docs/current/indexes.html |
| Using EXPLAIN | 11 | https://www.postgresql.org/docs/current/using-explain.html |
| Database Roles | 11 | https://www.postgresql.org/docs/current/user-manag.html |
| Row Security Policies | 11 | https://www.postgresql.org/docs/current/ddl-rowsecurity.html |
| JSON Types | 11 | https://www.postgresql.org/docs/current/datatype-json.html |

## Hafta 1-2: algoritma ve Python

- **Python Tutor**, kodunu yapıştırıp satır satır çalıştırıyorsun, her adımda değişkenlerin değerini görüyorsun. İz sürme (trace table) sorularında önce kâğıtta çöz, sonra buradan kontrol et: https://pythontutor.com/
- **Python resmi öğreticisi**, 4. bölüm akış kontrolü (`if`, `for`, `range`), 5. bölüm veri yapıları (liste, sözlük): https://docs.python.org/3/tutorial/

## Uygulama ve pratik

- **SQLBolt**, 18 adımlık interaktif SQL dersi, tarayıcıda çalışır, kurulum yok: https://sqlbolt.com/
- **PGExercises**, tek bir örnek veri seti üzerinde kategorilere ayrılmış sorular, PostgreSQL sözdizimi: https://pgexercises.com/
- **Select Star SQL**, ücretsiz interaktif kitap; gerçek bir veri seti üzerinde sorgu yazarak ilerliyorsun, her bölüm yaklaşık 30 dakika. Gruplama ve JOIN bölümleri Hafta 5-6 ile birebir örtüşür: https://selectstarsql.com/
- **SQL Murder Mystery**, bir cinayeti SQL sorgularıyla çözüyorsun, JOIN pratiği için iyi bir ısınma: https://mystery.knightlab.com/

## Konuya göre okuma

- **NULL ve üç değerli mantık** (Hafta 5). Markus Winand'ın NULL sayfası: NULL'ın amacı, karşılaştırmalarda neden "bilinmiyor" ürettiği, toplama fonksiyonlarının onu neden atladığı. https://modern-sql.com/concept/null
- **Modern SQL**, SQL-92 sonrası eklenen özellikler ve hangi veritabanının neyi desteklediği. İleri haftalarda CTE ve pencere fonksiyonları için: https://modern-sql.com/
- **SQL Style Guide** (Simon Holywell). Okunur SQL nasıl yazılır: adlandırma, girintileme, hizalama. Projende tutarlı bir stil tutturmak istersen: https://www.sqlstyle.guide/

## İleri okuma

- Markus Winand, *Use The Index, Luke*, indeksleme ve sorgu performansı üzerine ücretsiz bir site, PostgreSQL dahil: https://use-the-index-luke.com/
- CMU 15-445, Intro to Database Systems, açık ders materyalleri ve video kayıtları: https://15445.courses.cs.cmu.edu/

## Araçlar

- **Mermaid ERD sözdizimi**, ERD'ni markdown içinde çizip GitHub'da otomatik render ettirmek için: https://mermaid.js.org/syntax/entityRelationshipDiagram.html
- **pgvector**, PostgreSQL için vektör benzerlik araması eklentisi (L2, kosinüs, iç çarpım mesafeleri, HNSW ve IVFFlat indeksleri): https://github.com/pgvector/pgvector
- **GitHub Docs, pull request oluşturma**, resmi adımlar: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request
- **Learn Git Branching**, branch açmayı ve merge etmeyi görselleştirerek öğreten interaktif bir oyun, açık kaynak: https://learngitbranching.js.org/
- **explain.dalibo.com**, `EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)` çıktısını okunur bir ağaca çeviriyor (Hafta 11): https://explain.dalibo.com/
- **GitHub Docs**: https://docs.github.com/

## Veri kaynağı bulmak için

Projende en az bir gerçek veri kaynağı olacak. Başlangıç için:

- İBB Açık Veri Portalı: https://data.ibb.gov.tr/
- Türkiye Açık Veri Portalı: https://acikveri.gov.tr/
- Kaggle Datasets: https://www.kaggle.com/datasets
- Hugging Face Datasets: https://huggingface.co/datasets
- Open-Meteo (ücretsiz hava durumu API'si, anahtar gerektirmez): https://open-meteo.com/
- phyphox (telefonunun sensörlerinden veri toplama): https://phyphox.org/

Bu liste sabit değil. Bir şeyi anlamanı kolaylaştıran başka bir kaynak bulursan bir Issue aç, listeye ekleyelim.
