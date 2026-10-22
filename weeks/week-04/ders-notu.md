# Hafta 4 ders notu: SELECT ve WHERE

> Haftanın ders notu ve metin sürümü (ekran okuyucu ve büyütme dostu).
> Buradaki bütün sorgular `robot_fleet` ve `llm_ops` veritabanlarında çalışır ve gösterilen sonuçlar gerçek çıktılardır. Kurulum: [data/README.md](../../data/README.md)

## 1. Başlarken: bu sorguyu zaten anlıyorsun

```sql
SELECT name
FROM robots
WHERE battery_level < 20;
```

Türkçeye çevirelim: *select* seç, *name* adı, *from robots* robotlardan, *where* şu koşulla, *battery level less than 20* bataryası yirmiden küçük olanlar.

Yani: **bataryası %20'nin altındaki robotların adlarını seç.**

Sonuç:

```
   name
-----------
 Atlas-02
 Kartal-01
 Mars-02
 Atlas-03
(4 rows)
```

SQL'in sırrı bu: bir programlama dilinden çok, İngilizce yazılmış bir soru cümlesi.

## 2. psql: hayatta kalma kiti

`psql` terminalden veritabanına bağlanan programdır.

```bash
psql -d robot_fleet
```

İçeride işine yarayacak komutlar:

| Komut | Ne yapar |
|---|---|
| `\l` | Veritabanlarını listeler |
| `\c llm_ops` | Başka veritabanına geçer |
| `\dt` | Tabloları listeler |
| `\d robots` | Tablonun sütunlarını ve tiplerini gösterir |
| `\x` | Geniş satırları alt alta gösterir (aç/kapat) |
| `\q` | Çıkar |

**İki komut ailesi var, karıştırma:**

- `\` ile başlayanlar psql'in kendi komutlarıdır, sunucuya gitmez, **noktalı virgül istemez.**
- SQL sorguları sunucuya gider ve **noktalı virgülle biter.**

> **En sık takılma.** Sorgunun sonuna `;` koymazsan Enter'a bastığında hiçbir şey olmaz, istem `robot_fleet=#` yerine `robot_fleet-#` olur. Bu "cümlen bitmedi, bekliyorum" demektir. Panik yapma: `;` yazıp Enter'a bas.

## 3. Tablonun anatomisi

```sql
SELECT * FROM robots;
```

| id | name | model | status | battery_level | zone | operator_name |
|---|---|---|---|---|---|---|
| 1 | Atlas-01 | AMR-200 | active | 82 | Depo A | Zeynep |
| 2 | Atlas-02 | AMR-200 | charging | 15 | Şarj | Can |
| 3 | Kartal-01 | DRN-X1 | active | 18 | Dış Alan | Çağla |
| 4 | Kartal-02 | DRN-X1 | maintenance | 64 | Atölye | Ahmet |
| 5 | Mars-01 | AMR-300 | active | 47 | Depo B | Şule |
| 6 | Mars-02 | AMR-300 | active | 9 | Depo B | Büşra |
| 7 | Atlas-03 | AMR-200 | offline | 0 | Depo A | İsmail |
| 8 | Kartal-03 | DRN-X1 | active | 91 | Dış Alan | Deniz |
| 9 | Mars-03 | AMR-300 | active | 55 | *(boş)* | *(boş)* |
| 10 | Kartal-04 | DRN-X1 | charging | *(boş)* | Şarj | Emre |

- `status`: `active` görevde, `charging` şarjda, `maintenance` bakımda, `offline` kapalı
- `battery_level`: yüzde (0-100)
- Boş hücreler kasıtlı; onları Hafta 5'te konuşacağız

YZO tarafında `llm_calls` tablosu var: her satır bir yapay zeka çağrısının kaydı (hangi model, kim, kaç milisaniye, kaça mal oldu). **Dikkat: `latency_ms` milisaniye cinsinden, 1 saniye = 1000 ms.**

## 4. Sorgunun anatomisi

Her sorgunun omurgası iki soru:

```sql
SELECT name, battery_level   -- NE?      hangi sütunlar
FROM robots                  -- NEREDEN? hangi tablo
;                            -- BİTTİ
```

Yazım kuralları ve nedenleri:

| Kural | Neden |
|---|---|
| Anahtar kelimeler BÜYÜK | Zorunlu değil, ama sorgunun iskeleti gözle ayrılır |
| Sütunlar virgülle ayrılır | Sonuncudan sonra virgül yok |
| Her ana kelime yeni satırda | Şimdi 3 satır, birkaç hafta sonra 15 satır olacak |

## 5. Sütun seçmek

```sql
SELECT name, battery_level FROM robots;
```

```
   name    | battery_level
-----------+---------------
 Atlas-01  |            82
 Atlas-02  |            15
 Kartal-01 |            18
 ...
```

`SELECT *` bütün sütunları getirir. Tabloyu tanırken iyidir, ama **raporda ve programda sütunları tek tek yaz.** İki sebep: tabloya yarın elli sütun eklenirse sorgu gereksiz veri taşır, sütun sırası değişirse de programın sessizce bozulur.

İki uyarı:

- Sütunlar **senin yazdığın sırada** gelir.
- **Satır sırası garanti değildir.** Bugün id sırasıyla geliyor diye yarın da öyle geleceğini varsayma. Sıra istiyorsan `ORDER BY` ile söyle.

## 6. AS: takma ad ve hesaplanmış sütun

```sql
SELECT name AS robot,
       100 - battery_level AS missing_charge
FROM robots;
```

```
   robot   | missing_charge
-----------+----------------
 Atlas-01  |             18
 Atlas-02  |             85
 Kartal-01 |             82
 ...
```

İki yeni şey var:

1. **`AS` başlığı değiştirir.** Raporda `battery_level` yerine okunur bir isim yazdırabilirsin.
2. **`SELECT` içinde hesap yapabilirsin.** Dört işlem de çalışır.

> **Önemli güvence:** `100 - battery_level` yazdım ama tablodaki değer değişmedi. **`SELECT` hiçbir şeyi değiştirmez, sadece okur.** Bu yüzden SELECT ile oynarken korkmana gerek yok, veriyi bozamazsın.

YZO örneği:

```sql
SELECT model_name AS model,
       prompt_tokens + completion_tokens AS total_tokens
FROM llm_calls;
```

## 7. WHERE: bir elek

Şimdiye kadar hep bütün satırları getirdik. `WHERE` satırları eler.

```sql
SELECT name, status
FROM robots
WHERE status = 'active';
```

```
   name    | status
-----------+--------
 Atlas-01  | active
 Kartal-01 | active
 Mars-01   | active
 Mars-02   | active
 Kartal-03 | active
 Mars-03   | active
(6 rows)
```

Elek benzetmesi: on satır eleğe düşer, WHERE her satıra aynı soruyu sorar ("koşul doğru mu?"), doğru olanlar kalır.

> **Aklında tut:** `SELECT` sütunları seçer, `WHERE` satırları seçer. Biri tabloyu soldan sağa keser, öteki yukarıdan aşağı.

Metin değerleri **tek tırnak** içinde yazılır: `'active'`.

## 8. Karşılaştırma operatörleri

| Operatör | Anlamı | Örnek |
|---|---|---|
| `=` | eşit | `status = 'active'` |
| `<>` veya `!=` | eşit değil | `status <> 'active'` |
| `<` `>` | küçük, büyük | `battery_level < 20` |
| `<=` `>=` | küçük eşit, büyük eşit | `cost_usd >= 0.01` |

İki farka dikkat:

- **Python'da `==`, SQL'de tek `=`.** SQL'de atama yok, bu yüzden karışıklık da yok.
- **Ondalık ayırıcı nokta:** `0.01`. Türkçe klavye alışkanlığıyla `0,01` yazarsan virgül sütun ayırıcı sayılır ve hata alırsın.

## 9. AND, OR, NOT ve parantez tuzağı

```sql
-- AND: iki koşul da doğru olmalı
SELECT name, model, battery_level FROM robots
WHERE model = 'DRN-X1' AND battery_level > 50;
--> Kartal-02 (64), Kartal-03 (91)

-- OR: en az biri doğru olsun yeter
SELECT id, task_type FROM llm_calls
WHERE task_type = 'code' OR task_type = 'translate';
--> 4 satır

-- NOT: koşulun tersi
SELECT name, status FROM robots WHERE NOT status = 'active';
--> Atlas-02, Kartal-02, Atlas-03, Kartal-04
```

### Şimdi dersin en önemli tuzağı

Soru: *aktif ya da şarjda olan* **ve** *bataryası %20'nin altındaki* robotlar.

```sql
-- YANLIŞ
SELECT name, status, battery_level FROM robots
WHERE status = 'active' OR status = 'charging' AND battery_level < 20;
```

```
   name    |  status  | battery_level
-----------+----------+---------------
 Atlas-01  | active   |            82     <-- %82?! Burada ne arıyor?
 Atlas-02  | charging |            15
 Kartal-01 | active   |            18
 Mars-01   | active   |            47
 Mars-02   | active   |             9
 Kartal-03 | active   |            91
 Mars-03   | active   |            55
(7 rows)
```

Atlas-01'in bataryası %82, ama listede. Neden? Çünkü PostgreSQL sorguyu şöyle okudu:

```
status = 'active'  OR  (status = 'charging' AND battery_level < 20)
```

**`AND`, `OR`'dan önce çalışır.** Tıpkı matematikte çarpmanın toplamadan önce gelmesi gibi: `2 + 3 × 4 = 14`. SQL'de AND çarpma, OR toplama gibidir.

```sql
-- DOĞRU
SELECT name, status, battery_level FROM robots
WHERE (status = 'active' OR status = 'charging') AND battery_level < 20;
```

```
   name    |  status  | battery_level
-----------+----------+---------------
 Atlas-02  | charging |            15
 Kartal-01 | active   |            18
 Mars-02   | active   |             9
(3 rows)
```

> **Kural: bir sorguda hem AND hem OR varsa parantez koy.** Fazla parantezden kimse zarar görmez; eksik parantez sessizce yanlış rapor üretir.

## 10. BETWEEN, IN, LIKE

Bunların üçü de yeni yetenek değil, **kısa yazım**.

### BETWEEN (uçlar dahil)

```sql
SELECT name, battery_level FROM robots
WHERE battery_level BETWEEN 40 AND 85;
--> Atlas-01 (82), Kartal-02 (64), Mars-01 (47), Mars-03 (55)
```

`x BETWEEN 40 AND 85` ile `x >= 40 AND x <= 85` aynı şeydir. Küçük sayı önce yazılır; ters yazarsan boş sonuç alırsın ve hata da almazsın.

### IN (listedekilerden biri)

```sql
SELECT name, status FROM robots
WHERE status IN ('maintenance', 'offline');
--> Kartal-02, Atlas-03

SELECT name, zone FROM robots
WHERE zone NOT IN ('Depo A', 'Depo B');
--> Atlas-02, Kartal-01, Kartal-02, Kartal-03, Kartal-04
```

`x IN ('a','b')` ile `x = 'a' OR x = 'b'` aynı şeydir. Beş değerli bir listeyi OR ile yazmak hem uzun hem hataya açıktır.

### LIKE ve ILIKE (kalıp arama)

İki joker karakter:

- `%` → burada herhangi bir şey olabilir, hiç olmayabilir de
- `_` → burada tam olarak bir karakter olacak

```sql
SELECT name FROM robots WHERE name LIKE 'Atlas%';
--> Atlas-01, Atlas-02, Atlas-03

SELECT name FROM robots WHERE name LIKE 'Mars-0_';
--> Mars-01, Mars-02, Mars-03

SELECT name FROM robots WHERE name LIKE 'kartal%';
--> 0 satır!  LIKE büyük/küçük harfe duyarlıdır

SELECT name FROM robots WHERE name ILIKE 'kartal%';
--> Kartal-01, Kartal-02, Kartal-03, Kartal-04
```

`ILIKE` PostgreSQL'e özeldir, harf büyüklüğünü umursamaz (I = insensitive). Kullanıcının yazdığı bir aramayı filtreliyorsan `ILIKE` daha güvenlidir: kullanıcı "kartal" da yazabilir "KARTAL" da.

## 11. ORDER BY: sıralama

```sql
SELECT name, battery_level FROM robots
ORDER BY battery_level DESC;
```

En dolu robot başta, en boş sonda. `DESC` büyükten küçüğe, `ASC` küçükten büyüğe (varsayılan, yazmasan da olur).

Çoklu sıralama telefon rehberi gibidir: önce soyada, aynıysa ada göre.

```sql
SELECT model, name, battery_level FROM robots
ORDER BY model ASC, battery_level DESC;
```

Her model grubunun içinde batarya büyükten küçüğe iner.

## 12. LIMIT ve OFFSET

```sql
SELECT id, model_name, cost_usd FROM llm_calls
ORDER BY cost_usd DESC
LIMIT 3;
```

```
 id |  model_name   | cost_usd
----+---------------+----------
  7 | claude-sonnet |   0.0243
  2 | claude-sonnet |   0.0141
  4 | gpt-4o        |   0.0114
```

> **Uyarı: `ORDER BY` olmadan `LIMIT` anlamsızdır.** "İlk 3" demek için önce neye göre sıralandığını söylemen gerekir. Sıralamazsan PostgreSQL eline hangi üç satır geçerse onu verir.

`OFFSET` baştan N satır atlar, sayfalama için kullanılır:

```sql
SELECT id, model_name FROM llm_calls ORDER BY id LIMIT 4 OFFSET 4;
--> id 5, 6, 7, 8  (ikinci sayfa)
```

Formül: `OFFSET = (sayfa numarası - 1) × sayfa boyutu`

## 13. DISTINCT: tekrarları atmak

```sql
SELECT model FROM robots;          --> 10 satır, tekrarlı
SELECT DISTINCT model FROM robots; --> 3 satır: AMR-200, DRN-X1, AMR-300
```

Soru "filomuzda hangi modeller var?" ise cevap on satırlık listeden okunmaz, `DISTINCT` gerekir.

`DISTINCT` sıralamaz; sıra istiyorsan `ORDER BY` ekle. Birden çok sütunda ise kombinasyonlara bakar:

```sql
SELECT DISTINCT zone, status FROM robots ORDER BY zone;
--> 7 satır: "Depo A" iki kez çıkar, çünkü orada hem active hem offline robot var
```

## 14. Yazdığın sıra, çalışan sıra değil

Şu sorgu mantıklı görünüyor ama çalışmaz:

```sql
SELECT model_name,
       prompt_tokens + completion_tokens AS total_tokens
FROM llm_calls
WHERE total_tokens > 2000;
```

```
ERROR:  column "total_tokens" does not exist
```

Ama `total_tokens`'ı iki satır yukarıda tanımladık. Nasıl yok?

**Çünkü PostgreSQL sorguyu senin yazdığın sırada çalıştırmıyor:**

| Sıra | Adım | Ne olur |
|---|---|---|
| 1 | `FROM` | Hangi tablo |
| 2 | `WHERE` | Satırlar elenir |
| 3 | `SELECT` | Sütunlar hesaplanır ve **isimlendirilir** |
| 4 | `ORDER BY` | Sıralanır |
| 5 | `LIMIT` | Kesilir |

`WHERE` ikinci adımda çalışır; `total_tokens` ismi üçüncü adımda doğar. Henüz var olmayan bir isme referans veremezsin.

Çözüm: `WHERE`'de ifadenin kendisini yaz.

```sql
SELECT model_name,
       prompt_tokens + completion_tokens AS total_tokens
FROM llm_calls
WHERE prompt_tokens + completion_tokens > 2000;
--> claude-sonnet 2140, claude-sonnet 3300
```

İlginç olan şu: **`ORDER BY total_tokens` çalışır**, çünkü ORDER BY SELECT'ten *sonra* gelir ve isim artık mevcuttur.

## 15. "Çağla neden listenin sonunda?"

Türkçe isimleri alfabetik sıralayalım:

```sql
SELECT operator_name FROM robots
WHERE operator_name IS NOT NULL
ORDER BY operator_name;
```

Sunucunun varsayılan ayarına bağlı olarak şunu görebilirsin:

```
 Ahmet
 Büşra
 Can
 Deniz
 Emre
 Zeynep
 Çağla      <-- neden burada?
 İsmail
 Şule
```

**Sebep:** bilgisayar harfleri sayı koduyla saklar. A'nın kodu küçük, Z'nin büyük. Türkçeye özel harfler (Ç, İ, Ş, Ğ, Ü, Ö) bu tabloya sonradan eklendiği için kodları Z'den de büyüktür. Kodlara göre sıralanınca sona düşerler.

Çözüm: hangi dilin kuralıyla sıralanacağını söylemek. Buna **harmanlama (collation)** denir.

```sql
SELECT operator_name FROM robots
WHERE operator_name IS NOT NULL
ORDER BY operator_name COLLATE "tr-TR-x-icu";
```

```
 Ahmet
 Büşra
 Can
 Çağla      <-- doğru yer: C'den sonra
 Deniz
 Emre
 İsmail
 Şule
 Zeynep
```

Karşılaştırma için üç kural:

| Kural | Çağla nereye gider |
|---|---|
| `COLLATE "C"` | Sona (bayt sırası) |
| `COLLATE "en-US-x-icu"` | Can'dan **önce** (İngilizce Ç'yi C sayar) |
| `COLLATE "tr-TR-x-icu"` | Can'dan **sonra** (doğru Türkçe sıra) |

> **Tırnak farkına dikkat:** `"tr-TR-x-icu"` **çift** tırnak içinde, çünkü bu bir metin değeri değil, bir **isim**. SQL'de tek tırnak değer, çift tırnak isimdir. Bu ayrım birazdan sık hatalar bölümünde geri gelecek.

## 16. Soruyu sorguya çevirmenin dört adımı

Boş ekrana bakıp donmanın ilacı:

| Adım | Soru | SQL parçası |
|---|---|---|
| 1 | Hangi tablo? | `FROM` |
| 2 | Hangi sütunlar? | `SELECT` |
| 3 | Hangi koşul? | `WHERE` |
| 4 | Hangi sıra, kaç tane? | `ORDER BY`, `LIMIT` |

Dikkat: yazarken `SELECT` önce gelir, ama **düşünürken `FROM` önce gelir.** Önce hangi tabloda çalışacağına karar ver.

### Örnek: "Depo B'deki aktif robotların adlarını ve bataryalarını, en düşükten başlayarak listele."

```sql
SELECT name, battery_level            -- 2: adlarını ve bataryalarını
FROM robots                           -- 1: robotların
WHERE zone = 'Depo B'                 -- 3: Depo B'deki
  AND status = 'active'               -- 3: aktif
ORDER BY battery_level;               -- 4: en düşükten başlayarak
```

```
  name   | battery_level
---------+---------------
 Mars-02 |             9
 Mars-01 |            47
```

### YZO örneği: "Son 7 günde gecikmesi 2 saniyeyi aşan çağrılar, en yavaştan başla."

```sql
SELECT id, model_name, user_name, latency_ms, created_at
FROM llm_calls
WHERE latency_ms > 2000
  AND created_at >= '2026-10-09'
ORDER BY latency_ms DESC;
```

İki çeviri noktası var:

- "2 saniye" → `2000`, çünkü sütun milisaniye
- "son 7 gün" → bugünden 7 gün öncesinin tarihi

Tarihi elle yazdık; bu sorgu yarın yanlış sonuç verir. Hafta 5'te `now() - interval '7 days'` ile bunu kendi kendini güncelleyen hale getireceğiz.

### Robotik örneği: "Bataryası %20'nin altına düşmüş aktif robotlar, en kritikten başla."

```sql
SELECT name, zone, battery_level
FROM robots
WHERE status = 'active' AND battery_level < 20
ORDER BY battery_level;
```

```
   name    |   zone   | battery_level
-----------+----------+---------------
 Mars-02   | Depo B   |             9
 Kartal-01 | Dış Alan |            18
```

> **Soru:** tabloda bataryası 20'nin altında dört robot var (Atlas-02 %15, Kartal-01 %18, Mars-02 %9, Atlas-03 %0). Neden sadece ikisi geldi?
> **Cevap:** Atlas-02 zaten şarjda, Atlas-03 kapalı. İkisi de `active` değil. Koşulun her parçası bir şey eler; sonuçta eksik gördüğün her satırın elenme sebebini açıklayabilmelisin.

## 17. En sık yapılan beş hata

| # | Hata | Örnek | Ne olur |
|---|---|---|---|
| 1 | Metni çift tırnakla yazmak | `WHERE status = "active"` | `ERROR: column "active" does not exist` |
| 2 | Büyük/küçük harf | `WHERE status = 'Active'` | **Hata yok**, 0 satır |
| 3 | Sütunlar arası virgülü unutmak | `SELECT name battery_level` | **Hata yok**, name sütunu yanlış başlıkla gelir |
| 4 | Yazım hatası | `SELEC name FROM robots;` | `ERROR: syntax error at or near "SELEC"` |
| 5 | Boş değere `=` ile bakmak | `WHERE zone = NULL` | **Hata yok**, her zaman 0 satır |

**1. hata neden böyle:** SQL'de çift tırnak **isim** demektir, bu yüzden PostgreSQL `active` adında bir sütun arar. COLLATE'te çift tırnak kullanmamızın sebebi de buydu.

**3. hata en sinsisi:** araya virgül konmazsa ikinci kelime takma ad sayılır, yani `SELECT name AS battery_level` olarak okunur.

**5. hata:** NULL "bilinmiyor" demektir ve hiçbir şeye eşit değildir, kendine bile. Doğrusu `IS NULL` yazmaktır, ayrıntısı Hafta 5'te.

> En tehlikeli hatalar 2, 3 ve 5: sorgu çalışır, ekranda tablo vardır, her şey normal görünür ama sonuç yanlıştır. **Her sorgudan sonra bir satırı gözünle kontrol et.**

## 18. Hile kâğıdı

```sql
SELECT DISTINCT sutun1, sutun2 AS takma_ad
FROM tablo
WHERE kosul
ORDER BY sutun1 DESC
LIMIT n OFFSET m;
```

| İş | Yazım |
|---|---|
| Karşılaştır | `=` `<>` `<` `>` `<=` `>=` |
| Birleştir | `AND` `OR` `NOT` `( )` |
| Aralık (uçlar dahil) | `BETWEEN a AND b` |
| Liste | `IN ('a','b')`, `NOT IN (...)` |
| Kalıp (`%` çok, `_` bir) | `LIKE 'A%'`, `ILIKE` |
| Türkçe sıralama | `COLLATE "tr-TR-x-icu"` |
| Tırnaklar | `'değer'` tek, `"isim"` çift |
| psql | `\dt` `\d tablo` `\x` `\q` |

**Çalışma sırası:** FROM → WHERE → SELECT → ORDER BY → LIMIT

**Dört adım:** tablo → sütunlar → koşul → sıra ve sayı

## 19. Bu haftanın özeti

- `SELECT` sütun seçer, `WHERE` satır eler
- Metin tek tırnakta, isim çift tırnakta, ondalıkta nokta
- AND, OR'dan önce çalışır: parantez koy
- `BETWEEN`, `IN`, `LIKE` birer kısa yazımdır
- `ORDER BY` olmadan "ilk N" demenin anlamı yok
- Takma ad `WHERE`'de çalışmaz, `ORDER BY`'da çalışır
- Türkçe sıralama için `COLLATE "tr-TR-x-icu"`

**Gelecek hafta:** satırları getirmeyi öğrendik, şimdi onları özetleyeceğiz. `COUNT`, `SUM`, `AVG`, `GROUP BY` ve boş hücrelerin raporu nasıl bozduğu.

## Terim sözlüğü

| English | Türkçe | Bu haftaki anlamı |
|---|---|---|
| select | seçme | Hangi sütunlar gelsin |
| from | kaynak tablo | Hangi tablodan |
| where | koşul | Hangi satırlar gelsin |
| alias | takma ad | `AS` ile verilen yeni başlık |
| comparison operator | karşılaştırma operatörü | `=`, `<>`, `<`, `>` |
| logical operator | mantıksal operatör | `AND`, `OR`, `NOT` |
| operator precedence | işlem önceliği | AND'in OR'dan önce çalışması |
| pattern matching | kalıp eşleştirme | `LIKE`, `ILIKE`, `%`, `_` |
| wildcard | joker karakter | `%` ve `_` |
| case sensitive | büyük/küçük harfe duyarlı | `LIKE` duyarlı, `ILIKE` değil |
| order by / ascending / descending | sıralama / artan / azalan | `ASC`, `DESC` |
| limit / offset | sınırlama / atlama | Sayfalama |
| distinct | benzersiz | Tekrarları at |
| collation | harmanlama | Dile özel sıralama kuralı |
| logical processing order | mantıksal işlenme sırası | FROM → WHERE → SELECT → ORDER BY |
