# Hafta 5 ders notu: Özetleme, gruplama ve NULL

> Haftanın ders notu ve metin sürümü. Buradaki bütün sorgular `robot_fleet` ve `llm_ops` veritabanlarında çalışır ve gösterilen sonuçlar gerçek çıktılardır. Kurulum: [data/README.md](../../data/README.md)

## 1. Geçen haftadan köprü

Hafta 4'ün sonunda bir soru bırakmıştım: **her modelin toplam maliyeti ne kadar?**

Geçen haftanın araçlarıyla bu şöyle yapılırdı: `gpt-4o` için bir sorgu, çıkan satırları elle topla. `claude-sonnet` için bir sorgu, topla. Yedi model var, yedi sorgu, sonra hesap makinesi.

Bu yöntem üç açıdan kötü: yorucu, hataya açık ve yarın sekizinci bir model eklenirse sorgu listen eksik kalır, üstelik bunu fark etmezsin.

Bu haftanın sonunda aynı iş dört satır olacak:

```sql
SELECT model_name, sum(cost_usd)
FROM llm_calls
GROUP BY model_name;
```

Bu haftanın tek cümlesi: **satırları getirmeyi öğrendik, şimdi onları özetleyeceğiz.**

## 2. Çok satır girer, tek satır çıkar

Şimdiye kadar yazdığın her sorguda sessiz bir kural vardı: kaç satır girerse o kadar satır çıkardı. Toplama fonksiyonları bu kuralı bozar.

```sql
SELECT count(*) AS robot_sayisi FROM robots;
```

```
 robot_sayisi
--------------
           10
```

On satır girdi, bir satır çıktı. Buna **toplulaştırma (aggregation)** denir: birçok değeri tek değere indirgemek.

`WHERE` ile birlikte çalışır:

```sql
SELECT count(*) AS aktif_robot FROM robots WHERE status = 'active';
--> 6
```

Çalışma sırasını hatırla: önce `FROM`, sonra `WHERE`, **sonra** sayma. Eleme bitmeden sayım başlamaz.

> `AS` kullanmayı alışkanlık yap. Yazmazsan sütun başlığı sadece `count` olur ve raporda çirkin durur.

## 3. count(*) ile count(sütun) aynı şey değil

Bu farkı erken öğren, çünkü sürekli karşına çıkacak.

```sql
SELECT count(*)              AS tum_satir,
       count(battery_level)  AS batarya_dolu,
       count(zone)           AS bolge_dolu
FROM robots;
```

```
 tum_satir | batarya_dolu | bolge_dolu
-----------+--------------+------------
        10 |            9 |          9
```

| Yazım | Ne sayar |
|---|---|
| `count(*)` | **Satırları.** İçi boş olsun olmasın, satır varsa sayar |
| `count(sutun)` | O sütunda **dolu olan** hücreleri. Boşları atlar |

Aradaki fark sana bedava bir bilgi verir: **eksik veri sayısı.** 10 eksi 9 eşittir 1, yani bir robotun bataryası bilinmiyor.

> **Alışkanlık edin:** yeni bir tabloyla tanıştığında `count(*)` ile her sütunun `count`'unu yan yana koy. Verinin ne kadar eksik olduğunu bir bakışta görürsün. Profesyoneller her işe bununla başlar.

YZO tarafında:

```sql
SELECT count(*) AS tum_cagri, count(cost_usd) AS maliyet_dolu, count(user_name) AS kullanici_dolu
FROM llm_calls;
--> 12 | 11 | 11
```

## 4. count(DISTINCT …)

Hafta 4'te `DISTINCT` tekrarları atıyordu ama saymıyordu. Şimdi ikisini birleştiriyoruz.

```sql
SELECT count(DISTINCT model) AS farkli_model FROM robots;
--> 3

SELECT count(DISTINCT model_name) AS model,
       count(DISTINCT user_name)  AS kullanici
FROM llm_calls;
--> 7 | 5
```

Yazıma dikkat: `DISTINCT`, `count`'un parantezinin **içinde**.

12 çağrıda beş kullanıcı adı geçiyor (Ece, Oğuz, Mert, Selin, Deniz) ve bir satırda kullanıcı adı boş. `DISTINCT` boşu ayrı bir değer saymaz, o yüzden cevap 6 değil 5.

## 5. SUM, AVG, MIN, MAX, ROUND

```sql
SELECT sum(cost_usd) AS toplam, avg(cost_usd) AS ortalama FROM llm_calls;
```

```
 toplam |        ortalama
--------+------------------------
 0.0631 | 0.00573636363636363636
```

Ortalamanın kuyruğuna bak: on altı basamak. Raporda bu okunmaz, `round` ile kısalt:

```sql
SELECT round(avg(latency_ms), 1) AS ort_gecikme FROM llm_calls;
--> 1848.3
```

`round`'un ikinci parametresi kaç ondalık basamak istediğindir. Burada iki fonksiyon iç içe: önce `avg` çalışır, sonra `round` onun sonucunu kısaltır.

Fonksiyonun içine sadece sütun adı değil, hesap da yazabilirsin:

```sql
SELECT sum(prompt_tokens + completion_tokens) AS toplam_token FROM llm_calls;
--> 14340
```

Önce her satırda iki sütun toplanır, sonra çıkan on iki sayı toplanır.

```sql
SELECT min(battery_level) AS en_dusuk, max(battery_level) AS en_yuksek FROM robots;
--> 0 | 91
```

| Fonksiyon | Hangi tipte çalışır |
|---|---|
| `count` | Her tipte |
| `sum`, `avg` | Sadece sayı. `sum(name)` hata verir |
| `min`, `max` | Sayı, metin (alfabetik) ve tarih (en eski/en yeni) |

## 6. GROUP BY: önce kovalara ayır

Şimdiye kadar bütün tablo için **tek** bir özet ürettik. Ama müdür "kaç robotumuz var" diye sormaz, "kaçı çalışıyor, kaçı bakımda" diye sorar.

**Çamaşır benzetmesi:** çamaşırları renklerine göre ayırırsın (beyazlar, renkliler, siyahlar), sonra her yığını ayrı yıkarsın. `GROUP BY` ayırma işini yapar, toplama fonksiyonu her yığını ayrı ayrı işler.

```sql
SELECT status, count(*) AS adet
FROM robots
GROUP BY status
ORDER BY adet DESC;
```

```
   status    | adet
-------------+------
 active      |    6
 charging    |    2
 offline     |    1
 maintenance |    1
```

> **Kural: kaç farklı değer varsa o kadar satır döner.** Dört farklı durum var, dört satır geldi. `GROUP BY model` deseydin üç satır dönerdi.

### Söz verdiğim sorgu

```sql
SELECT model_name,
       count(*)       AS cagri,
       sum(cost_usd)  AS toplam_maliyet
FROM llm_calls
GROUP BY model_name
ORDER BY toplam_maliyet DESC;
```

```
  model_name   | cagri | toplam_maliyet
---------------+-------+----------------
 claude-sonnet |     2 |         0.0384
 gpt-4o        |     3 |         0.0179
 gemini-pro    |     1 |         0.0042
 claude-haiku  |     2 |         0.0018
 llama-3-8b    |     2 |         0.0004
 gemini-flash  |     1 |         0.0003
 gpt-4o-mini   |     1 |         0.0001
```

Yedi sorguluk iş, altı satırda bitti. Bu bir karar tablosudur: `claude-sonnet` sadece iki çağrı almış ama en pahalı model.

Robotik tarafı, üç kavram tek sorguda (`round`, `avg`, `GROUP BY`):

```sql
SELECT model, count(*) AS adet, round(avg(battery_level), 1) AS ort_batarya
FROM robots
GROUP BY model
ORDER BY model;
```

```
  model  | adet | ort_batarya
---------+------+-------------
 AMR-200 |    3 |        32.3
 AMR-300 |    3 |        37.0
 DRN-X1  |    4 |        57.7
```

> `ORDER BY` içinde takma adı kullanabildik. Hafta 4'teki kuralı hatırla: `ORDER BY`, `SELECT`'ten sonra çalışır, bu yüzden isim artık mevcuttur.

## 7. Altın kural

```sql
SELECT model, name, count(*) FROM robots GROUP BY model;
```

```
ERROR:  column "robots.name" must appear in the GROUP BY clause
        or be used in an aggregate function
```

**Neden?** AMR-200 kovasında üç robot var: Atlas-01, Atlas-02, Atlas-03. Bu kova tek bir satır dönecek. O satırın `name` hücresine hangisi yazılsın?

Üç isim var, bir hücre var. PostgreSQL rastgele birini seçip sana yanlış bilgi vermek yerine duruyor ve soruyor.

Sayılarda bu sorun yok, çünkü `avg` veya `sum` üç değeri tek değere indirger.

> **Altın kural: `SELECT`'teki her sütun ya `GROUP BY`'da olacak, ya da bir fonksiyonun içinde.**

İki çözüm: sütunu `GROUP BY`'a ekle (kovalar küçülür), ya da bir fonksiyona sok (`min(name)` alfabetik ilkini verir).

Hata mesajını okumayı alışkanlık yap: sana hem sorunlu sütunun adını, hem de iki çözümü söylüyor.

## 8. İki sütuna göre gruplama

```sql
SELECT model, status, count(*) AS adet
FROM robots
GROUP BY model, status
ORDER BY model, status;
```

```
  model  |   status    | adet
---------+-------------+------
 AMR-200 | active      |    1
 AMR-200 | charging    |    1
 AMR-200 | offline     |    1
 AMR-300 | active      |    3
 DRN-X1  | active      |    2
 DRN-X1  | charging    |    1
 DRN-X1  | maintenance |    1
```

Artık kova tek bir değer değil, bir **ikili**. "AMR-200 ve active" ayrı bir kova, "AMR-200 ve charging" bambaşka bir kova. Excel'de pivot tablo kullandıysan, bu tam olarak odur.

Adet sütununu topla: 1+1+1+3+2+1+1 = 10, yani bütün robotlar. **Gruplama hiçbir satırı kaybetmez, sadece paketler.**

Genel kural: ne kadar çok sütuna göre gruplarsan kovalar o kadar küçülür, satır sayısı o kadar artar.

## 9. HAVING: grupları filtrele

Soru: **birden fazla kez çağrılan modeller hangileri?**

Bu koşul tek bir çağrı hakkında değil, bir modelin bütün çağrıları hakkında. Böyle koşullar `HAVING` ile yazılır.

```sql
SELECT model_name, count(*) AS cagri
FROM llm_calls
GROUP BY model_name
HAVING count(*) > 1
ORDER BY cagri DESC;
```

```
  model_name   | cagri
---------------+-------
 gpt-4o        |     3
 claude-haiku  |     2
 claude-sonnet |     2
 llama-3-8b    |     2
```

Yedi grup oluştu, `HAVING` üçünü eledi (`gemini-pro`, `gemini-flash`, `gpt-4o-mini`; her biri tek çağrı). Dikkat: **satır değil, grup eleniyor.**

### WHERE ile HAVING farkı

```sql
SELECT model_name, count(*) FROM llm_calls WHERE count(*) > 1 GROUP BY model_name;
```

```
ERROR:  aggregate functions are not allowed in WHERE
```

Çünkü `WHERE` çalıştığı anda gruplar henüz yok. `WHERE` tek tek satırlara bakar; o aşamada sayılacak bir grup yoktur.

Zaman çizgisi:

```
satırlar → WHERE eler → gruplar oluşur → HAVING eler → sonuç
```

İkisi birlikte, dersin en kapsamlı örneği:

```sql
SELECT model_name,
       count(*) AS cagri,
       round(avg(latency_ms)) AS ort
FROM llm_calls
WHERE latency_ms > 500
GROUP BY model_name
HAVING count(*) >= 2
ORDER BY ort DESC;
```

```
  model_name   | cagri | ort
---------------+-------+------
 claude-sonnet |     2 | 3650
 gpt-4o        |     3 | 2383
 claude-haiku  |     2 |  800
```

Adım adım: 12 çağrıyla başladık → `WHERE` 500 ms'den hızlıları attı → kalanlar modele göre gruplandı → `HAVING` en az iki çağrısı olmayan grupları attı → üç grup kaldı.

| | Ne zaman | Neye bakar | Örnek |
|---|---|---|---|
| `WHERE` | Gruplamadan **önce** | Tek tek satırlara | "500 ms'den yavaş çağrıları al" |
| `HAVING` | Gruplamadan **sonra** | Gruplara | "En az 2 çağrısı olan modelleri al" |

## 10. Güncellenmiş çalışma sırası

Hafta 4'te beş adımlık bir sıra öğrenmiştik. Araya iki adım girdi:

| Sıra | Adım |
|---|---|
| 1 | `FROM` |
| 2 | `WHERE` |
| 3 | `GROUP BY` |
| 4 | `HAVING` |
| 5 | `SELECT` |
| 6 | `ORDER BY` |
| 7 | `LIMIT` |

Bu tek şema üç sorunun da cevabı:

- **`count` neden `WHERE`'de olmaz?** `WHERE` 2. adımda, gruplar 3. adımda doğuyor.
- **Takma ad neden `HAVING`'de çalışmaz?** `HAVING` 4. adımda, isimler 5. adımda doğuyor.
- **Neden `ORDER BY`'da çalışır?** `ORDER BY` 6. adımda, isimler çoktan doğmuş.

Hiçbirini ezberlemene gerek yok; sırayı bilirsen üçünü de kendin çıkarırsın.

---

# NULL

## 11. NULL "sıfır" değil, "bilmiyorum" demek

Tablolarımızda boş hücreler var. Bunlar hata değil, gerçek hayatın normali: bir robot henüz atanmamıştır, bir sensör bozulmuştur, bir fatura gecikmiştir.

| | Değer | Anlamı |
|---|---|---|
| **Sıfır** | Atlas-03, batarya `0` | Ölçtük, sıfır çıktı. Robotun şarjı bitmiş. Bu bir bilgi |
| **NULL** | Kartal-04, batarya boş | Ölçemedik, sensör bozuk. Belki %90, belki %5. Bilmiyoruz |
| **Boş metin** | `''` | Sıfır karakterlik bir metin. Bu da bir değer, NULL değil |

Farkı eyleme bağla: Atlas-03 için şarja gönderirsin, Kartal-04 için teknisyen çağırırsın. Aynı görünen iki hücre, iki farklı karar.

> **NULL bir değer değildir, değerin yokluğudur.** Bu yüzden normal kurallar ona işlemez.

Günlük örnek: bir ankette yaş hanesi boşsa, o kişinin yaşı sıfır değildir, cevaplamamıştır. Eksik veriyi sıfırla doldurmak dünyanın en yaygın veri hatalarından biridir ve bütün ortalamaları bozar.

## 12. Üç değerli mantık

Şimdiye kadar her koşulun iki cevabı vardı: doğru veya yanlış. NULL üçüncü bir cevap getiriyor: **bilinmiyor**.

Kartal-04'ün bataryasını bilmiyoruz. "Bu robotun bataryası 20'den büyük mü?" Evet diyemezsin, hayır da diyemezsin.

| İfade | Sonuç |
|---|---|
| `NULL = NULL` | bilinmiyor |
| `NULL <> NULL` | bilinmiyor |
| `NULL > 5` | bilinmiyor |
| `NULL IS NULL` | **doğru** |
| `doğru AND bilinmiyor` | bilinmiyor |
| `yanlış AND bilinmiyor` | **yanlış** |
| `doğru OR bilinmiyor` | **doğru** |

Son iki satır ilginç: `yanlış AND bilinmiyor` yanlış verir, çünkü AND'de bir taraf yanlışsa öteki ne olursa olsun sonuç yanlıştır.

> **Bu bölümün en önemli cümlesi: `WHERE` yalnızca kesin doğruları geçirir. "Bilinmiyor" da "yanlış" gibi elenir. Ve hiçbir hata mesajı görmezsin.**

Buna sessiz eleme denir ve bu dersin tehlikeli kısmıdır.

## 13. Doğru soru: IS NULL

```sql
SELECT name, zone FROM robots WHERE zone = NULL;
--> 0 satır
```

Hata yok. Ama bölgesi boş bir robot olduğunu biliyoruz: Mars-03. Sorgu onu bulamadı, çünkü `zone = NULL` her satır için "bilinmiyor" döndürdü.

```sql
SELECT id, name, zone, operator_name FROM robots WHERE zone IS NULL;
```

```
 id |  name   | zone | operator_name
----+---------+------+---------------
  9 | Mars-03 |      |
```

`IS NULL` özel bir sözdizimidir: eşitlik sormaz, doğrudan "bu hücre boş mu" diye sorar ve kesin bir doğru/yanlış üretir.

| Yazım | Ne yapar |
|---|---|
| `IS NULL` | Boş olanları bulur |
| `IS NOT NULL` | Dolu olanları bulur |
| `= NULL`, `<> NULL` | **Hiçbir zaman kullanma** |

Gerçek kullanım: ay sonu raporunu kapatmadan önce `WHERE cost_usd IS NULL` çalıştırırsın, faturası gelmemiş çağrıları gösterir.

## 14. NULL bulaşıcıdır

```sql
SELECT id, battery_level, battery_level + 10 AS artirilmis
FROM robots WHERE id IN (9, 10);
```

```
 id | battery_level | artirilmis
----+---------------+------------
  9 |            55 |         65
 10 |               |
```

Cebinde kaç para olduğunu bilmiyorsan, üstüne on lira koyunca ne kadar olduğunu yine bilmiyorsundur. Kural dört işlemin hepsinde geçerli.

Metinde de aynısı olur: `'Robot: ' || NULL` sonucu NULL'dır, `'Robot: '` kısmı bile kalmaz.

Tehlikesi şu: yirmi sütunluk bir hesapta tek bir NULL bütün sonucu NULL yapar ve nereden geldiğini bulmak saatler alır.

## 15. Kayıp robot

Üç sorgu çalıştıralım:

```sql
SELECT count(*) FROM robots;                              --> 10
SELECT count(*) FROM robots WHERE battery_level < 50;     -->  5
SELECT count(*) FROM robots WHERE battery_level >= 50;    -->  4
```

**5 + 4 = 9. Ama 10 robotumuz var. Biri nerede?**

Kartal-04. Bataryası bilinmiyor. "Elliden küçük mü" sorusunun cevabı bilinmiyor, "elliden büyük eşit mi" sorusunun cevabı da bilinmiyor. İkisinde de elendi. İki sorgu da hatasız çalıştı, ikisi de bir robotu kaybetti.

> Düşün: yöneticine "bataryası düşük 5, yüksek 4 robot var" diye rapor veriyorsun. Filoda 10 robot olduğunu bilen yönetici toplamı yapar, dokuz çıkar ve sana bir daha güvenmez.

Üç çözüm var: `IS NULL` ile üçüncü bir grup ekle, `COALESCE` kullan, ya da raporun altına "bir robotun verisi eksik" notunu düş. Hangisini seçtiğin önemli değil, **fark etmiş olman** önemli.

## 16. AVG hangi sayıya böler?

```sql
SELECT sum(battery_level)            AS toplam,
       count(*)                      AS satir,
       count(battery_level)          AS dolu,
       round(avg(battery_level), 1)  AS ortalama
FROM robots;
```

```
 toplam | satir | dolu | ortalama
--------+-------+------+----------
    381 |    10 |    9 |     42.3
```

381 bölü 10 = 38.1. Ama ortalama 42.3 çıktı. Çünkü **AVG 10'a değil, 9'a böldü.** Boş hücreyi hiç hesaba katmadı.

| Hesap | Sonuç | Anlamı |
|---|---|---|
| `avg` ne yapar: 381 ÷ 9 | 42.3 | "Bilinen robotların ortalaması" |
| Çoğu insanın beklediği: 381 ÷ 10 | 38.1 | "Boşu sıfır sayarsak" |

Dört puanlık fark. Hangisi doğru? **İkisi de olabilir, karar senin.**

Bu örnekte `avg`'nin davranışı daha dürüst: Kartal-04'ün bataryası sıfır değil, bilinmiyor; onu sıfır saymak veriyi uydurmak olur. Ama satış tablosunda kaydı olmayan bir gün için sıfır satış demek mantıklı olabilir.

> Mesaj: hangi yorumu seçtiğini bil ve raporda yaz. AVG'nin NULL'ları atlaması bir hata değil, bilinçli bir tasarımdır.

Not: `SUM` da NULL'ları atlar, ama orada fark görünmez, çünkü toplama sıfır eklemek sonucu değiştirmez. Asıl tuzak bölmede.

## 17. COALESCE: boşsa şunu kullan

`coalesce(sütun, yedek_değer)`: sütun doluysa onu, boşsa yedek değeri döndürür. Soldan sağa bakar, ilk dolu değeri verir.

**Kozmetik kullanım:** raporda boşluk görünmesin:

```sql
SELECT name,
       coalesce(zone, 'Bilinmiyor')          AS bolge,
       coalesce(operator_name, 'Atanmamış')  AS operator
FROM robots WHERE id IN (8, 9, 10);
```

```
   name    |   bolge    | operator
-----------+------------+-----------
 Kartal-03 | Dış Alan   | Deniz
 Mars-03   | Bilinmiyor | Atanmamış
 Kartal-04 | Şarj       | Emre
```

**Anlamlı kullanım:** bir önceki bölümdeki kararı sorguya yazmak:

```sql
SELECT round(avg(coalesce(battery_level, 0)), 1) AS sifir_sayarak,
       round(avg(battery_level), 1)              AS normal
FROM robots;
--> 38.1 | 42.3
```

`avg(coalesce(battery_level, 0))` demek, "bilinmeyeni sıfır kabul ediyorum" demektir. Artık bu bir tercih, kaza değil.

> **COALESCE tabloyu değiştirmez, sadece görüntüyü değiştirir.** Tablodaki NULL yerinde durur.

## 18. NULLIF: tersini yapar

`nullif(a, b)`: a ile b eşitse NULL döndürür, değilse a'yı döndürür. Tek yaygın kullanımı sıfıra bölmeyi önlemek.

```sql
SELECT 100 / 0;
--> ERROR: division by zero
```

Bu sadece bir satırı bozmaz, **bütün sorguyu durdurur.** Binlerce satırlık bir raporda tek bir sıfır raporun tamamını çökertir.

```sql
SELECT 100 / nullif(0, 0);                   --> (boş), hata yok
SELECT coalesce(100 / nullif(0, 0), 0);      --> 0
```

Mantık: sıfıra bölmek hata verir, ama NULL'a bölmek hata vermez, sadece NULL üretir. O zaman böleni, sıfırsa, NULL'a çeviririz.

Gerçek örnek: başarı oranını toplam deneme sayısına bölüyorsun; hiç denemesi olmayan bir robot raporu çökertir. `nullif(toplam_deneme, 0)` bunu önler.

| | Ne yapar |
|---|---|
| `COALESCE` | NULL'ı değere çevirir, boşluğu kapatır |
| `NULLIF` | Değeri NULL'a çevirir, zararlı değeri etkisizleştirir |

---

# Tarih, zaman ve sınıflandırma

## 19. now() ve interval

Hafta 4'te "son 7 gün" için tarihi elle yazmıştık: `'2026-10-09'`. O sorgu bugün yanlış sonuç verir.

```sql
SELECT now();                        --> 2026-10-16 10:04:40+03
SELECT now() - interval '7 days';    --> 2026-10-09 10:04:40+03
```

```sql
SELECT count(*) AS son_7_gun
FROM llm_calls
WHERE created_at >= now() - interval '7 days';
--> 11
```

12 çağrının 11'i son yedi günde; 8 Ekim'deki çağrı sınırın dışında kaldı.

Bu sorgu bugün de doğru, altı ay sonra da doğru. Bir panele veya programa koyduğunda her sabah elle güncellemen gerekmez.

`interval` ile yazabileceklerin: `'30 minutes'`, `'6 hours'`, `'7 days'`, `'2 weeks'`, `'3 months'`.

> Küçük not: `now()` saati de içerir. Sadece tarihle çalışmak istersen `current_date` var.

## 20. date_trunc: günlük rapor

Günlük rapor istiyoruz. Ama `created_at`'e göre gruplarsak 12 satır 12 grup olur, çünkü hiçbir zaman damgası aynı değil.

Önce zamanı **küçültmek** gerek. `date_trunc` zamanı aşağı yuvarlar:

| created_at | gün başı | saat başı |
|---|---|---|
| 10-08 09:12 | 10-08 00:00 | 10-08 09:00 |
| 10-15 13:10 | 10-15 00:00 | 10-15 13:00 |

Artık aynı günün bütün çağrıları aynı değere sahip, yani gruplanabilirler.

```sql
SELECT date_trunc('day', created_at)::date AS gun,
       count(*)      AS cagri,
       sum(cost_usd) AS maliyet
FROM llm_calls
GROUP BY gun
ORDER BY gun;
```

```
    gun     | cagri | maliyet
------------+-------+---------
 2026-10-08 |     1 |  0.0065
 2026-10-12 |     1 |  0.0141
 2026-10-13 |     1 |  0.0002
 2026-10-14 |     2 |  0.0124
 2026-10-15 |     2 |  0.0246
 2026-10-16 |     5 |  0.0053
```

Son satırı yorumla: 16 Ekim'de beş çağrı var ama toplam maliyet 14 Ekim'den düşük. Sebebi: bir çağrının maliyeti henüz boş ve `SUM` onu saymıyor. **NULL konusu burada tekrar karşımıza çıktı; gerçek raporlarda hep böyle olur.**

`'month'` ve `'week'` de kullanılabilir.

> Sondaki `::date` kozmetiktir: `date_trunc` sonucu aslında `2026-10-08 00:00:00+03` biçimindedir, `::date` onu `2026-10-08` olarak kısaltır. Gruplama ikisinde de aynı çalışır.

## 21. EXTRACT: tarihten bir parça

```sql
SELECT extract(hour FROM created_at) AS saat, count(*) AS cagri
FROM llm_calls
GROUP BY saat
ORDER BY saat;
```

```
 saat | cagri
------+-------
    8 |     1
    9 |     2
   10 |     2
   11 |     1
   12 |     1
   13 |     2
   14 |     2
   16 |     1
```

| | Ne üretir |
|---|---|
| `date_trunc` ile gruplama | **Zaman çizgisi:** 8 Ekim, 12 Ekim, 13 Ekim… |
| `EXTRACT` ile gruplama | **Döngü:** bütün günlerin saat 9'ları bir arada |

İkincisi davranış analizi içindir: ekip en çok hangi saatte çalışıyor, sunucuyu ne zaman güçlendirmeli.

> Tabloda saat 15 yok, çünkü o saatte hiç çağrı olmamış. **`GROUP BY` sadece var olan değerleri gösterir; sıfır olan gruplar satır olarak gelmez.**

Çekilebilen parçalar: `year`, `month`, `day`, `hour`, `minute`, `dow` (haftanın günü).

## 22. CASE WHEN: sayıyı etikete çevir

Programlamadaki `if/elif/else` zincirinin SQL hali.

```sql
SELECT name, battery_level,
  CASE
    WHEN battery_level IS NULL   THEN 'Bilinmiyor'
    WHEN battery_level < 20      THEN 'Kritik'
    WHEN battery_level < 60      THEN 'Düşük'
    ELSE                              'Normal'
  END AS durum
FROM robots
ORDER BY battery_level;
```

```
   name    | battery_level |   durum
-----------+---------------+------------
 Atlas-03  |             0 | Kritik
 Mars-02   |             9 | Kritik
 Atlas-02  |            15 | Kritik
 Kartal-01 |            18 | Kritik
 Mars-01   |            47 | Düşük
 Mars-03   |            55 | Düşük
 Kartal-02 |            64 | Normal
 Atlas-01  |            82 | Normal
 Kartal-03 |            91 | Normal
 Kartal-04 |               | Bilinmiyor
```

Sözdizimi: `CASE` ile başlar, her koşul `WHEN ... THEN`, hiçbiri tutmazsa `ELSE`, `END` ile biter.

**Sıra önemlidir.** 15 değeri hem 20'den hem 60'tan küçük, ama koşullar yukarıdan aşağı denenir ve **ilk tutan kazanır**, bu yüzden "Kritik" yazdı. (Hafta 1'deki `if/elif/else` kuralının aynısı.)

> **NULL kontrolünü neden en başa koyduk?** En sona koysaydık: `NULL < 20` bilinmiyor döner, `NULL < 60` bilinmiyor döner, hiçbiri tutmaz ve `ELSE` çalışır. Yani sensörü bozuk robota "Normal" derdik. İşte bu yüzden `CASE`, NULL bölümünden sonra geliyor.

## 23. Kendi kategorine göre gruplamak

Günün en güçlü fikri: **gruplama sütununun tabloda var olması gerekmiyor.**

```sql
SELECT CASE
         WHEN battery_level IS NULL THEN 'Bilinmiyor'
         WHEN battery_level < 20    THEN 'Kritik'
         WHEN battery_level < 60    THEN 'Düşük'
         ELSE                            'Normal'
       END AS durum,
       count(*) AS adet
FROM robots
GROUP BY durum
ORDER BY adet DESC;
```

```
   durum    | adet
------------+------
 Kritik     |    4
 Normal     |    3
 Düşük      |    2
 Bilinmiyor |    1
```

`robots` tablosunda "durum" diye bir sütun yok. Onu biz yarattık, sonra ona göre grupladık.

Yöneticiye sunulan raporların çoğu böyle çalışır: kimse "bataryası 0, 9, 15, 18 olan robotlar var" duymak istemez, "dört robot kritik seviyede" duymak ister. **Ham veriyi karar verilebilir bilgiye çeviren şey budur.**

YZO tarafı:

```sql
SELECT CASE
         WHEN latency_ms < 1000 THEN 'Hızlı'
         WHEN latency_ms < 2500 THEN 'Orta'
         ELSE                        'Yavaş'
       END AS hiz,
       count(*) AS cagri,
       round(avg(latency_ms)) AS ort
FROM llm_calls
GROUP BY hiz
ORDER BY ort;
```

```
  hiz  | cagri | ort
-------+-------+------
 Hızlı |     4 |  608
 Orta  |     4 | 1775
 Yavaş |     4 | 3163
```

Dörder dörder dağılmış: eşikler iyi seçilmiş demektir.

## 24. Hile kâğıdı

```sql
SELECT grup_sutunu, count(*)
FROM tablo
WHERE satır_koşulu
GROUP BY grup_sutunu
HAVING count(*) > n
ORDER BY adet DESC;
```

**Çalışma sırası:** FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT

**Altın kural:** SELECT'teki her sütun ya GROUP BY'da olacak ya bir fonksiyonun içinde.

| İş | Yazım |
|---|---|
| Say | `count(*)`, `count(sutun)` |
| Hesapla | `sum`, `avg`, `min`, `max` |
| Benzersiz say | `count(DISTINCT s)` |
| Yuvarla | `round(sayı, 1)` |
| Boş mu | `IS NULL`, `IS NOT NULL` |
| Boşsa şunu kullan | `coalesce(s, 0)` |
| Sıfıra bölmeyi önle | `a / nullif(b, 0)` |
| Zamanı küçült | `date_trunc('day', t)` |
| Parça çek | `extract(hour FROM t)` |
| Son 7 gün | `now() - interval '7 days'` |
| Etiketle | `CASE WHEN … THEN … END` |

**Üç NULL kuralı:**

1. Hesaba girerse sonuç NULL olur.
2. `WHERE` onu sessizce eler.
3. `AVG` onu hiç saymaz.

## 25. Bu haftanın özeti

- Toplama fonksiyonları çok satırı tek satıra indirger
- `count(*)` satırları, `count(sütun)` dolu hücreleri sayar; aradaki fark eksik veri sayısıdır
- `GROUP BY` kovalara ayırır, fonksiyon her kovayı ayrı işler
- Altın kural: SELECT'teki her sütun ya gruplanır ya toplanır
- `WHERE` satır eler, `HAVING` grup eler
- NULL "bilinmiyor" demektir; hesaba girerse bulaşır, `WHERE`'de sessizce elenir, `AVG`'de sayılmaz
- `CASE WHEN` ile kendi kategorini yaratıp ona göre gruplayabilirsin

**Gelecek hafta:** iki haftadır tek tablonun içindeyiz. Hafta 6'da duvarı yıkıyoruz: `JOIN` ile iki tabloya aynı anda soru soracağız. Somut bir soru bırakayım: `robots` tablosunda operatör adı var, ama Zeynep'in telefon numarası nerede?

## Terim sözlüğü

| English | Türkçe | Bu haftaki anlamı |
|---|---|---|
| aggregate function | toplama fonksiyonu | `count`, `sum`, `avg`, `min`, `max` |
| aggregation | toplulaştırma | Çok satırı tek değere indirgemek |
| group by | gruplama | Satırları kovalara ayırmak |
| having | gruplanmış koşul | Gruplara uygulanan filtre |
| null | boş değer | "Bilinmiyor", sıfır değil |
| three-valued logic | üç değerli mantık | doğru / yanlış / bilinmiyor |
| is null / is not null | boş mu / dolu mu | NULL'ı sorgulamanın tek doğru yolu |
| coalesce | boşsa yerine koyma | İlk dolu değeri döndürür |
| nullif | eşitse boşa çevirme | Sıfıra bölmeyi önler |
| conditional expression | koşullu ifade | `CASE WHEN ... THEN ... ELSE ... END` |
| timestamp | zaman damgası | Tarih ve saat birlikte |
| interval | zaman aralığı | `interval '7 days'` |
| truncate (date_trunc) | kırpma | Zamanı aşağı yuvarlama |
| extract | parça çekme | Tarihten saat, ay, yıl almak |
