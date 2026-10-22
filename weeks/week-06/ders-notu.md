# Hafta 6 ders notu: Çoklu tablo sorguları (JOIN)

> Haftanın ders notu ve metin sürümü. Buradaki bütün sorgular `robot_fleet` ve `llm_ops` veritabanlarında çalışır ve gösterilen sonuçlar gerçek çıktılardır. Kurulum: [data/README.md](../../data/README.md)

## 1. Duvarı yıkıyoruz

İki haftadır tek tablonun içindeyiz. Hafta 5'in sonunda bir soru bırakmıştım:

> `robots` tablosunda operatör adı var: Zeynep, Can, Çağla. Peki **Zeynep'in telefon numarası nerede?**

Tabloya bakalım. Yok. Peki olmalı mıydı?

Hayır. Çünkü Zeynep'in telefonu robotun bir özelliği değil, operatörün bir özelliği. `robots` tablosuna `operator_phone` diye bir sütun eklersek, Zeynep'in üç robotu olduğunda numarası üç yerde yazar. Numarası değişince üç yeri birden güncellemen gerekir, birini unutursun ve Hafta 3'te konuştuğumuz **tutarsızlık** problemi geri gelir.

Doğru çözüm: operatörlerin kendi tablosu olur. Bu hafta o iki tabloyu nasıl buluşturacağımızı öğreniyoruz.

## 2. Bu haftanın tabloları

`robot_fleet` içinde artık üç tablo var:

```
operators (10 satır)        robots (10 satır)          missions (14 satır)
├─ operator_name  PK        ├─ id              PK       ├─ id            PK
├─ phone                    ├─ name                     ├─ robot_id      FK → robots.id
├─ shift                    ├─ model                    ├─ mission_type
└─ hired_at                 ├─ status                   ├─ status
                            ├─ battery_level            ├─ started_at
                            ├─ zone                     └─ duration_min
                            └─ operator_name   FK → operators.operator_name
```

İki yeni terim:

| Terim | Ne demek | Örnek |
|---|---|---|
| **Birincil anahtar (primary key, PK)** | Satırı benzersiz tanımlayan sütun | `robots.id` |
| **Yabancı anahtar (foreign key, FK)** | Başka tablonun birincil anahtarına işaret eden sütun | `missions.robot_id` |

`missions.robot_id` sütunundaki `3` değeri şu demek: "bu görev, id'si 3 olan robota ait."

`llm_ops` tarafında da iki tablo var: `model_catalog` (7 model, fiyat ve bağlam penceresiyle) ve tanıdığın `llm_calls`.

> **Tasarım notu:** `operators` tablosunun birincil anahtarı doğrudan isim. Buna *natural key* denir ve bu hafta işimizi kolaylaştırıyor. Hafta 7'de bunun neden riskli olduğunu tartışacağız: aynı isimde ikinci bir operatör işe alınırsa bu tasarım çöker.

## 3. INNER JOIN: iki tabloyu buluşturmak

```sql
SELECT r.name, r.zone, o.phone, o.shift
FROM robots r
INNER JOIN operators o ON r.operator_name = o.operator_name
ORDER BY r.id;
```

```
   name    |   zone   |     phone     | shift
-----------+----------+---------------+--------
 Atlas-01  | Depo A   | 0532 000 0001 | gündüz
 Atlas-02  | Şarj     | 0532 000 0002 | gece
 Kartal-01 | Dış Alan | 0532 000 0003 | gündüz
 Kartal-02 | Atölye   | 0532 000 0004 | gündüz
 Mars-01   | Depo B   | 0532 000 0005 | gece
 Mars-02   | Depo B   | 0532 000 0006 | gündüz
 Atlas-03  | Depo A   | 0532 000 0007 | gece
 Kartal-03 | Dış Alan | 0532 000 0008 | gündüz
 Kartal-04 | Şarj     | 0532 000 0009 | gece
(9 rows)
```

İşte Zeynep'in telefonu. Sorguyu parça parça okuyalım:

| Parça | Ne yapıyor |
|---|---|
| `FROM robots r` | Sol tablo, `r` takma adıyla |
| `INNER JOIN operators o` | Sağ tablo, `o` takma adıyla |
| `ON r.operator_name = o.operator_name` | **Birleştirme koşulu:** hangi satır hangisiyle eşleşiyor |
| `SELECT r.name, o.phone` | Hangi tablodan hangi sütun |

### Takma adlar neden şart

İki tabloda da `operator_name` adlı sütun var. `SELECT operator_name` yazarsan PostgreSQL hangisini istediğini bilemez ve hata verir. `r.` ve `o.` önekleri bu belirsizliği çözer.

Takma ad vermesen de olur (`robots.operator_name` yazarsın) ama sorgu uzadıkça okunmaz hale gelir. Kısa ve anlamlı takma adlar kullan.

### ON ile WHERE farkı

`ON`, iki tablonun **nasıl eşleşeceğini** söyler. `WHERE`, eşleşme bittikten sonra **hangi satırların kalacağını** söyler. İkisi birlikte kullanılır:

```sql
SELECT r.name, o.phone
FROM robots r
INNER JOIN operators o ON r.operator_name = o.operator_name
WHERE r.status = 'active';
```

## 4. Kayıp robot

Dikkatini bir şeye çekmek istiyorum. Üstteki sonuç **9 satır** döndürdü. Ama `robots` tablosunda **10 robot** var.

```sql
SELECT count(*) FROM robots;                                              --> 10
SELECT count(*) FROM robots r
  JOIN operators o ON r.operator_name = o.operator_name;                  -->  9
```

Kim eksik? Mars-03. Çünkü Mars-03'ün operatörü henüz atanmamış, `operator_name` sütunu boş.

**`INNER JOIN` sadece iki tarafta da eşleşen satırları getirir.** Bir tarafta karşılığı olmayan satır sessizce düşer.

Bu Hafta 5'teki "kayıp robot" probleminin aynısı, sadece başka bir kılıkta. Yine hata yok, yine sessiz kayıp.

## 5. LEFT JOIN: kimseyi kaybetme

```sql
SELECT r.name, r.operator_name, o.phone
FROM robots r
LEFT JOIN operators o ON r.operator_name = o.operator_name
ORDER BY r.id;
```

Bu sorgu **10 satır** döndürür. Mars-03 de listede, ama `operator_name` ve `phone` sütunları boş:

```
   name    | operator_name |     phone
-----------+---------------+---------------
 ...
 Mars-03   |               |
 Kartal-04 | Emre          | 0532 000 0009
```

**`LEFT JOIN`, soldaki tablonun bütün satırlarını korur.** Sağda karşılığı yoksa, sağ tablodan gelen sütunlar NULL olur.

| | Ne getirir | Satır sayısı |
|---|---|---|
| `INNER JOIN` | Sadece eşleşenler | 9 |
| `LEFT JOIN` | Soldakilerin hepsi | 10 |

### Hangisini ne zaman?

Kendine şunu sor: **"Sol tablodaki bir satırın karşılığı olmasa da onu görmek istiyor muyum?"**

- "Robotların telefon listesi" → `INNER JOIN` yeter
- "Bütün robotlar, operatörü atanmamış olanlar dahil" → `LEFT JOIN`
- "Operatörü atanmamış robotları bul" → `LEFT JOIN` + bir hile (sonraki bölüm)

## 6. Eşleşmeyeni bulma hilesi

Bu desen çok sık işine yarayacak:

```sql
SELECT r.name, r.operator_name, o.phone
FROM robots r
LEFT JOIN operators o ON r.operator_name = o.operator_name
WHERE o.operator_name IS NULL;
```

```
  name   | operator_name | phone
---------+---------------+-------
 Mars-03 |               |
```

Mantık şu: `LEFT JOIN` eşleşmeyen satırlar için sağ tarafı NULL yapar. Biz de `WHERE ... IS NULL` ile **sadece o NULL'ları** seçeriz. Yani "sağda karşılığı olmayanları getir" demiş oluruz.

Bunu ters yönde de yapabilirsin. **Hiç robotu olmayan operatör var mı?**

```sql
SELECT o.operator_name, o.shift
FROM operators o
LEFT JOIN robots r ON o.operator_name = r.operator_name
WHERE r.id IS NULL;
```

```
 operator_name | shift
---------------+--------
 Kerem         | gündüz
```

Kerem yeni işe başlamış, henüz robot atanmamış. Sol tabloyu değiştirdik, soru da tersine döndü.

## 7. Bir robotun çok görevi: 1-N ilişkisi

`robots` ve `operators` arasındaki ilişki birebire yakındı. Şimdi bir robotun **birden çok** görevi olan duruma bakalım.

```sql
SELECT r.name, m.mission_type, m.status, m.duration_min
FROM robots r
JOIN missions m ON r.id = m.robot_id
ORDER BY r.id, m.id;
```

```
   name    | mission_type |   status    | duration_min
-----------+--------------+-------------+--------------
 Atlas-01  | taşıma       | completed   |           45
 Atlas-01  | sayım        | completed   |           90
 Atlas-01  | taşıma       | failed      |           12
 Atlas-02  | taşıma       | completed   |           60
 Kartal-01 | keşif        | completed   |           35
 Kartal-01 | keşif        | failed      |            8
 Kartal-01 | keşif        | in_progress |
 ...
(14 rows)
```

**Atlas-01 üç kere görünüyor.** Bu bir hata değil: üç görevi var, her görev bir satır. 10 robot ve 14 görevden 14 satır çıktı.

> `INNER JOIN` yerine sadece `JOIN` yazdım. İkisi aynı şey; `INNER` kelimesi isteğe bağlıdır. Ben derste açık yazmanı öneriyorum, niyetin belli olsun.

### Hiç görev almamış robotlar

```sql
SELECT r.id, r.name, r.status
FROM robots r
LEFT JOIN missions m ON r.id = m.robot_id
WHERE m.id IS NULL
ORDER BY r.id;
```

```
 id |   name    |   status
----+-----------+-------------
  4 | Kartal-02 | maintenance
  7 | Atlas-03  | offline
  9 | Mars-03   | active
 10 | Kartal-04 | charging
```

Dördü de mantıklı: ikisi çalışmıyor, biri yeni, biri şarjda. Aynı hile, yeni bir soru.

## 8. JOIN ve GROUP BY birlikte

```sql
SELECT r.name, count(m.id) AS gorev_sayisi
FROM robots r
LEFT JOIN missions m ON r.id = m.robot_id
GROUP BY r.name
ORDER BY gorev_sayisi DESC, r.name;
```

```
   name    | gorev_sayisi
-----------+--------------
 Atlas-01  |            3
 Kartal-01 |            3
 Kartal-03 |            3
 Mars-01   |            2
 Mars-02   |            2
 Atlas-02  |            1
 Atlas-03  |            0
 Kartal-02 |            0
 Kartal-04 |            0
 Mars-03   |            0
```

### Buradaki tuzağa dikkat

`count(m.id)` yazdım, `count(*)` değil. Neden?

```sql
SELECT r.name,
       count(*)     AS yanlis,
       count(m.id)  AS dogru
FROM robots r
LEFT JOIN missions m ON r.id = m.robot_id
WHERE r.id IN (1, 4, 7)
GROUP BY r.name ORDER BY r.name;
```

```
   name    | yanlis | dogru
-----------+--------+-------
 Atlas-01  |      3 |     3
 Atlas-03  |      1 |     0
 Kartal-02 |      1 |     0
```

Atlas-03'ün hiç görevi yok. Ama `LEFT JOIN` onu bir satır olarak koruyor (görev sütunları NULL). `count(*)` **satırı** sayar ve 1 der. `count(m.id)` ise **dolu hücreyi** sayar ve 0 der.

Doğru cevap 0. Hafta 5'teki `count(*)` ile `count(sütun)` farkı, burada doğrudan yanlış rapora dönüşüyor.

> **Kural: `LEFT JOIN` sonrası sayarken her zaman sağ tablodan bir sütunu say,** `count(*)` değil.

## 9. Fan-out: JOIN'in en sinsi tuzağı

Şu soruyu soralım: **görevi olan robotların toplam bataryası kaç?**

```sql
SELECT sum(r.battery_level) AS toplam
FROM robots r
JOIN missions m ON r.id = m.robot_id;
--> 700
```

700. Ama bir saniye. Bütün filonun toplam bataryası 381'di (Hafta 5). Alt kümesi nasıl 700 olur?

Sebebi şu:

```sql
SELECT r.name, r.battery_level, count(*) AS kac_kere_tekrarladi
FROM robots r JOIN missions m ON r.id = m.robot_id
GROUP BY r.name, r.battery_level ORDER BY r.name;
```

```
   name    | battery_level | kac_kere_tekrarladi
-----------+---------------+---------------------
 Atlas-01  |            82 |                   3
 Atlas-02  |            15 |                   1
 Kartal-01 |            18 |                   3
 Kartal-03 |            91 |                   3
 Mars-01   |            47 |                   2
 Mars-02   |             9 |                   2
```

Atlas-01'in üç görevi olduğu için, bataryası **üç kere** toplandı: 82 × 3 = 246. Hesabı yapalım:

```
82×3 + 15×1 + 18×3 + 91×3 + 47×2 + 9×2
= 246 + 15 + 54 + 273 + 94 + 18
= 700
```

Doğru cevap ise 262:

```
82 + 15 + 18 + 91 + 47 + 9 = 262
```

**Buna satır çoğalması (fan-out) denir.** 1-N bir JOIN yaptığında, "1" tarafındaki her satır, "N" tarafındaki eşleşme sayısı kadar tekrarlanır. O satırdaki değerleri toplarsan, hepsini birden çok kez toplamış olursun.

### Nasıl korunursun

İki işareti var:

1. **Toplam, mantıklı olandan büyük çıkıyor.** Alt küme ana kümeden büyük olamaz.
2. **JOIN sonrası satır sayısı, sol tablonun satır sayısından fazla.** 10 robot vardı, JOIN sonrası 14 satır oldu.

Çözüm: "1" tarafındaki bir değeri toplayacaksan JOIN'den önce topla, ya da önce tekilleştir.

```sql
SELECT sum(battery_level) AS dogru_toplam
FROM robots
WHERE id IN (SELECT DISTINCT robot_id FROM missions);
--> 262
```

(Buradaki `IN (SELECT ...)` yapısı bir **alt sorgu**. Hafta 10'da ayrıntısına gireceğiz, şimdilik "parantez içindeki sorgunun sonucunu liste gibi kullan" diye oku.)

> **Pratik kural: JOIN'den sonra `sum()` görürsen iki kere düşün.** `count()` genelde güvenlidir, `sum()` ve `avg()` fan-out'a açıktır.

## 10. YZO tarafı: katalogda olmayan model

`llm_calls` ile `model_catalog` arasında aynı desenler var, ama veri bir sürpriz saklıyor.

```sql
SELECT count(*) FROM llm_calls;                                              --> 12
SELECT count(*) FROM llm_calls c
  JOIN model_catalog mc ON c.model_name = mc.model_name;                     --> 11
SELECT count(*) FROM llm_calls c
  LEFT JOIN model_catalog mc ON c.model_name = mc.model_name;                --> 12
```

Bir çağrı INNER JOIN'de kayboluyor. Hangisi?

```sql
SELECT c.id, c.model_name, mc.provider
FROM llm_calls c
LEFT JOIN model_catalog mc ON c.model_name = mc.model_name
WHERE mc.model_name IS NULL;
```

```
 id | model_name | provider
----+------------+----------
 10 | gemini-pro |
```

`gemini-pro` kullanılmış ama katalogda yok. Gerçek hayatta bu tam olarak şu demek: biri yeni bir modeli kodda çağırmış ama katalog tablosuna eklemeyi unutmuş. **Eğer raporunu `INNER JOIN` ile yazarsan o çağrının maliyeti raporda hiç görünmez.**

Ters yönde de bakalım:

```sql
SELECT mc.model_name, mc.provider
FROM model_catalog mc
LEFT JOIN llm_calls c ON mc.model_name = c.model_name
WHERE c.id IS NULL;
```

```
  model_name   | provider
---------------+----------
 mistral-large | Mistral
```

Katalogda duruyor ama hiç çağrılmamış. Belki denenip bırakılmış, belki eklenmiş ama kullanılmamış.

### Sağlayıcı bazında rapor

```sql
SELECT mc.provider,
       count(*)                 AS cagri,
       round(avg(c.latency_ms)) AS ort_gecikme,
       sum(c.cost_usd)          AS maliyet
FROM llm_calls c
JOIN model_catalog mc ON c.model_name = mc.model_name
GROUP BY mc.provider
ORDER BY cagri DESC, mc.provider;
```

```
 provider  | cagri | ort_gecikme | maliyet
-----------+-------+-------------+---------
 Anthropic |     4 |        2225 |  0.0402
 OpenAI    |     4 |        1900 |  0.0180
 Meta      |     2 |        1340 |  0.0004
 Google    |     1 |        1100 |  0.0003
```

Toplam 11 çağrı: `gemini-pro` burada yok. Onu da dahil etmek istersen:

```sql
SELECT coalesce(mc.provider, 'Katalogda yok') AS saglayici, count(*) AS cagri
FROM llm_calls c
LEFT JOIN model_catalog mc ON c.model_name = mc.model_name
GROUP BY saglayici
ORDER BY cagri DESC, saglayici;
```

```
   saglayici   | cagri
---------------+-------
 Anthropic     |     4
 OpenAI        |     4
 Meta          |     2
 Google        |     1
 Katalogda yok |     1
```

Şimdi 12. `LEFT JOIN` ve `COALESCE` birlikte, eksiği gizlemek yerine **görünür** yaptı. İyi bir rapor budur.

## 11. Self join: bir tabloyu kendisiyle birleştirmek

Bazen ilişki aynı tablonun içindedir. Örnek: **aynı vardiyada çalışan operatör çiftleri.**

```sql
SELECT o1.operator_name AS operator_1,
       o2.operator_name AS operator_2,
       o1.shift
FROM operators o1
JOIN operators o2
  ON o1.shift = o2.shift
 AND o1.operator_name < o2.operator_name
WHERE o1.shift = 'gece'
ORDER BY o1.operator_name, o2.operator_name;
```

```
 operator_1 | operator_2 | shift
------------+------------+-------
 Can        | Emre       | gece
 Can        | İsmail     | gece
 Can        | Şule       | gece
 Emre       | İsmail     | gece
 Emre       | Şule       | gece
 İsmail     | Şule       | gece
```

Aynı tabloyu iki farklı takma adla (`o1`, `o2`) çağırdık. PostgreSQL için bunlar iki ayrı tablo gibi.

`o1.operator_name < o2.operator_name` koşulu olmasaydı ne olurdu? Herkes kendisiyle de eşleşirdi (Can-Can) ve her çift iki kere çıkardı (Can-Emre ve Emre-Can). Küçüktür koşulu ikisini birden çözüyor.

## 12. Üç tablo birden

JOIN zincirlenebilir. **Her operatörün robotu ve o robotun görev sayısı:**

```sql
SELECT o.operator_name, r.name AS robot, count(m.id) AS gorev
FROM operators o
LEFT JOIN robots r   ON o.operator_name = r.operator_name
LEFT JOIN missions m ON r.id = m.robot_id
GROUP BY o.operator_name, r.name
ORDER BY gorev DESC, o.operator_name;
```

```
 operator_name |   robot   | gorev
---------------+-----------+-------
 Deniz         | Kartal-03 |     3
 Zeynep        | Atlas-01  |     3
 Çağla         | Kartal-01 |     3
 Büşra         | Mars-02   |     2
 Şule          | Mars-01   |     2
 Can           | Atlas-02  |     1
 Ahmet         | Kartal-02 |     0
 Emre          | Kartal-04 |     0
 Kerem         |           |     0
 İsmail        | Atlas-03  |     0
```

Kerem listede, robotu olmadığı halde. İki `LEFT JOIN` zinciri onu koruyor.

> **Dikkat:** zincirde bir kere `INNER JOIN` kullanırsan, o noktadan sonra kayıplar başlar. `LEFT JOIN` zincirini `INNER JOIN` ile bozma.

## 13. Diğer JOIN türleri (kısaca)

| Tür | Ne yapar | Ne zaman |
|---|---|---|
| `INNER JOIN` | Sadece eşleşenler | En sık kullanılan |
| `LEFT JOIN` | Soldakilerin hepsi | Eksikleri de görmek istediğinde |
| `RIGHT JOIN` | Sağdakilerin hepsi | Nadir: tabloların yerini değiştirip `LEFT` yazmak daha okunur |
| `FULL OUTER JOIN` | İki tarafın hepsi | İki listeyi karşılaştırırken |
| `CROSS JOIN` | Her satır her satırla | Nadir: kombinasyon üretmek için |

`CROSS JOIN` tehlikelidir: 10 satır × 14 satır = 140 satır. Yanlışlıkla `ON` koşulunu unutursan PostgreSQL sana sessizce bir kartezyen çarpım verir. Büyük tablolarda bu makineyi kilitler.

`RIGHT JOIN` için pratik tavsiye: kullanma. `A RIGHT JOIN B` yerine `B LEFT JOIN A` yaz, aynı sonucu daha okunur biçimde alırsın.

## 14. JOIN yazmanın beş adımı

Hafta 4'teki dört adımın JOIN'li hali:

| Adım | Soru |
|---|---|
| 1 | **Hangi tablolar?** Bilgi nerede duruyor |
| 2 | **Nasıl birleşiyorlar?** Hangi sütun hangisine işaret ediyor (`ON`) |
| 3 | **Hangi JOIN türü?** Eşleşmeyenleri görmek istiyor muyum |
| 4 | **Hangi sütunlar?** Hangi tablodan ne alacağım |
| 5 | **Koşul, gruplama, sıra?** `WHERE`, `GROUP BY`, `ORDER BY` |

### Örnek: "Gece vardiyasındaki operatörlerin robotları toplam kaç görev yaptı?"

1. Tablolar: `operators`, `robots`, `missions`
2. Birleşim: `operators.operator_name = robots.operator_name`, `robots.id = missions.robot_id`
3. Tür: `INNER` (operatörü olmayan robot bu soruda ilgilendirmiyor)
4. Sütunlar: `o.shift`, görev sayısı
5. Koşul: vardiyaya göre grupla

```sql
SELECT o.shift, count(m.id) AS toplam_gorev
FROM operators o
JOIN robots r   ON o.operator_name = r.operator_name
JOIN missions m ON r.id = m.robot_id
GROUP BY o.shift
ORDER BY toplam_gorev DESC;
```

```
 shift  | toplam_gorev
--------+--------------
 gündüz |           11
 gece   |            3
```

## 15. Sık yapılan hatalar

| # | Hata | Belirti |
|---|---|---|
| 1 | `ON` koşulunu unutmak | Devasa sonuç (kartezyen çarpım) |
| 2 | Yanlış sütunları eşleştirmek | 0 satır veya anlamsız eşleşmeler |
| 3 | `LEFT JOIN` sonrası `count(*)` | Hiç kaydı olmayanlara 1 yazar |
| 4 | Fan-out'u fark etmemek | Toplamlar şişer |
| 5 | Takma ad kullanmamak | `column reference "id" is ambiguous` |
| 6 | `LEFT JOIN` zincirini `INNER` ile bozmak | Sessiz kayıp |

3., 4. ve 6. maddeler hata vermez. En tehlikelileri onlar.

## 16. Hile kâğıdı

```sql
SELECT sol.sutun, sag.sutun
FROM sol_tablo sol
LEFT JOIN sag_tablo sag ON sol.anahtar = sag.yabanci_anahtar
WHERE sag.anahtar IS NULL        -- eşleşmeyenleri bulmak için
GROUP BY sol.sutun
ORDER BY ...;
```

| İş | Yazım |
|---|---|
| Sadece eşleşenler | `INNER JOIN ... ON ...` |
| Soldakilerin hepsi | `LEFT JOIN ... ON ...` |
| Eşleşmeyeni bul | `LEFT JOIN` + `WHERE sag.pk IS NULL` |
| LEFT JOIN sonrası say | `count(sag.sutun)`, asla `count(*)` |
| Kendiyle birleştir | `FROM t a JOIN t b ON a.x = b.x AND a.pk < b.pk` |
| Boş yerine etiket | `coalesce(sag.sutun, 'Bilinmiyor')` |

**Beş adım:** tablolar → birleşim koşulu → JOIN türü → sütunlar → koşul ve gruplama

## 17. Bu haftanın özeti

- Veri tablolara bölünür, çünkü tekrar tutarsızlık doğurur
- `ON` nasıl eşleşeceğini, `WHERE` hangisinin kalacağını söyler
- `INNER JOIN` eşleşmeyeni sessizce düşürür, `LEFT JOIN` korur
- `LEFT JOIN` + `WHERE ... IS NULL` = "karşılığı olmayanları bul"
- `LEFT JOIN` sonrası `count(*)` yanlış, `count(sağ.sütun)` doğru
- Fan-out: 1-N JOIN'de "1" tarafı tekrarlanır, toplamlar şişer
- Takma adlar belirsizliği çözer, uzun sorguları okunur yapar

**Gelecek hafta:** artık iki tablonun nasıl buluştuğunu biliyorsun. Hafta 7'de kendi verinin kaç tabloya bölünmesi gerektiğine **sen** karar vereceksin: E-R modeli ve normalizasyon.

## Terim sözlüğü

| English | Türkçe | Bu haftaki anlamı |
|---|---|---|
| join | birleştirme | İki tabloyu tek sonuçta buluşturmak |
| inner join | iç birleştirme | Sadece iki tarafta da eşleşenler |
| left (outer) join | sol birleştirme | Soldakilerin hepsi, eşleşmeyenler NULL ile |
| right join / full outer join | sağ / tam birleştirme | Nadir kullanılır |
| cross join | çapraz birleştirme | Her satır her satırla (kartezyen çarpım) |
| self join | kendiyle birleştirme | Bir tabloyu kendisiyle |
| join condition (`ON`) | birleştirme koşulu | Hangi satır hangisiyle eşleşir |
| primary key | birincil anahtar | Satırı benzersiz tanımlar |
| foreign key | yabancı anahtar | Başka tablonun anahtarına işaret eder |
| alias | takma ad | `robots r` içindeki `r` |
| ambiguous column | belirsiz sütun | İki tabloda da aynı adlı sütun |
| fan-out / row multiplication | satır çoğalması | 1-N JOIN'de tekrarlanan satırlar |
| cartesian product | kartezyen çarpım | `ON` unutulunca çıkan devasa sonuç |
