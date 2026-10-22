# Ödev 1: İlk beş haftanın tamamı

**Son teslim: 23 Ekim 2026 Cuma, ders saatinden önce GitHub'da.**
**Kâğıt rapor: aynı gün derste elden.**

100 puan. Dönemin ilk notlu ödevi.

## Bu ödev neyi ölçüyor

İlk beş haftada üç şey öğrendik: bir problemi adımlara bölmeyi, bir veritabanının neden tablolardan kurulduğunu ve tek bir tablodan doğru satırları çekip özetlemeyi. Bu ödev üçünü de tek seferde soruyor.

Yeni bir konu yok. Hepsini derste gördük, lab föylerinde çözdük. Burada tek fark, bu kez yalnız çalışıyor olman.

Dört bölüm var, hepsi zorunlu. Tahmini süre altı saat. Tek oturuşta bitirmeye çalışma.

## Bölüm 1: Algoritma ve izleme (20 puan)

Hafta 1 ve 2'nin konusu. Üç soruya da kâğıt üstünde başla, kod sonra gelsin.

**Soru 1.1. İz sürme.** Aşağıdaki kodu çalıştırmadan, satır satır izle. Her döngü adımında `i`, `total` ve `result` değişkenlerinin değerlerini bir tabloya yaz.

```python
numbers = [4, 7, 2, 9, 5, 1, 8]
total = 0
result = []

for i in range(len(numbers)):
    if numbers[i] % 2 == 0:
        total = total + numbers[i]
    else:
        result.append(numbers[i])

print(total)
print(result)
```

Tabloyu tamamladıktan sonra kodu çalıştır. Tahminin tuttu mu? Tutmadıysa hangi adımda yanıldığını bir cümleyle yaz.

**Soru 1.2. En uzun seri.** Bir sensörün art arda okuduğu değerler var:

```python
readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]
threshold = 22
```

Eşik değerin üzerinde art arda kaç okuma geldiğini bulan bir algoritma yaz. En uzun kesintisiz seriyi arıyoruz. Hazır fonksiyon yok, sadece `for`, `if`, değişken ve sayaç.

Örnek: `[18, 25, 26, 27, 19]` listesinde eşik 22 ise cevap 3'tür.

Önce sözde kodunu yaz, sonra Python karşılığını.

**Soru 1.3. Elle gruplama.** Her kayıt bir öğrencinin aldığı dersi gösteriyor:

```python
records = [
    {"student": "Ece", "course": "VTYS"},
    {"student": "Ali", "course": "Yapay Zeka"},
    {"student": "Ece", "course": "Yapay Zeka"},
    {"student": "Can", "course": "VTYS"},
    {"student": "Ali", "course": "VTYS"},
    {"student": "Ece", "course": "Robotik"},
]
```

Her dersi kaç öğrencinin aldığını say. `Counter`, `groupby` gibi hazır gruplama araçları yasak; sadece `for`, `if` ve bir sözlük kullan. Beklenen çıktı: `{"VTYS": 3, "Yapay Zeka": 2, "Robotik": 1}`.

Bu soruyu bitirdiğinde Bölüm 4'te yazacağın `GROUP BY` sorgusunun elle yapılmış halini yazmış olacaksın. İkisi arasındaki benzerliği raporunda bir cümleyle anlat.

Dosya: `odevler/odev-01/bolum1.py`

## Bölüm 2: Veritabanı kavramları (10 puan)

Hafta 3'ün konusu. Her sorunun cevabı iki ila dört cümle. Ezber istemiyorum, kendi cümlelerinle yaz.

1. Bir kurum verilerini Excel dosyalarında tutuyor. Hangi üç somut sorunla karşılaşır? Her sorunu bir veritabanının nasıl çözdüğünü de yaz.
2. Birincil anahtar (primary key) ne işe yarar? Öğrenci numarası iyi bir birincil anahtar mıdır, ad soyad neden değildir?
3. Veritabanı yönetim sistemi (DBMS) ile veritabanının farkı nedir? PostgreSQL bunlardan hangisi?
4. Aynı anda iki kişi aynı kaydı değiştirmeye kalkarsa ne olur? Bunu bir cümleyle anlat, bu konuyu Hafta 10'da açacağız.

Dosya: `odevler/odev-01/bolum2.md`

## Bölüm 3: SELECT ve WHERE (35 puan)

Hafta 4'ün lab föyündeki **15 soru**: [../week-04/lab.md](../week-04/lab.md)

Kendi programının veritabanında çöz.

- Robotik ve Yapay Zeka (BLP 105): `robot_fleet`
- Yapay Zeka Operatörlüğü (BLP 1005): `llm_ops`

Yazım biçimi şu, aynen uygula:

```sql
-- Soru 1: Bütün robotların adı ve modeli
SELECT name, model
FROM robots;
-- 10 satır döndü.
```

Sorgunun üstünde soru numarası, altında kaç satır döndüğü. Satır sayısını yazmak zahmetli görünür ama hata yakalamanın en ucuz yolu budur. Beklediğin sayı ile gelen sayı tutmuyorsa sorguda bir şey var demektir ve bunu daha fazla soru yazmadan fark edersin.

Veritabanı kurulu değilse [data/README.md](../../data/README.md) ve [SETUP.md](../../SETUP.md) dosyalarına bak. Kurulum sorunu yaşıyorsan **bu hafta içinde** haber ver, ödev gecesi değil.

Dosya: `odevler/odev-01/bolum3.sql`

## Bölüm 4: Gruplama ve NULL (35 puan)

Hafta 5'in lab föyündeki **15 soru**: [lab.md](lab.md)

Bu bölümde fazladan bir kural var: **her sorgunun altına sonucu yorumlayan bir cümle yaz.** Sayıyı değil, sayının ne anlama geldiğini.

```sql
-- Soru 11: NULL avı
SELECT count(*) AS satir_sayisi,
       count(battery_level) AS batarya_dolu
FROM robots;
-- 10 | 9, yani bir robotun bataryası bilinmiyor (Kartal-04, sensör arızası).
-- Bu tek boşluk ortalamayı 4 puan kaydırıyor.
```

Yorumsuz teslim edilen bölümden 20 puana kadar kırarım. Sorguyu çalıştırmak kolay, asıl iş çıkan sayının doğru olup olmadığını anlamakta.

Dosya: `odevler/odev-01/bolum4.sql`

## Nasıl göndereceksin

Çalışmanı kendi GitHub reponda `odev-01` adlı bir branch'te topla, sonra main'e pull request aç. Reviewer olarak **gizemturker** ekle. PR'ı kendin merge etme, ben inceleyeceğim.

Reponu henüz kurmadıysan adımlar [ODEVLER.md](../../ODEVLER.md) bölüm 2'de. Kurulum bu ödevin puanına dahil değil, sadece teslim yolu.

```
odevler/odev-01/
├── bolum1.py
├── bolum2.md
├── bolum3.sql
├── bolum4.sql
└── rapor.md
```

PR başlığı: `Ödev 1 / Ad Soyad / Öğrenci No`

Son commit'in **23 Ekim 2026 Cuma günü ders saatinden önce** gönderilmiş olmalı. GitHub her commit'in saatini kaydediyor, bakacağım.

## Kâğıt rapor

Aynı gün derse **tek sayfalık** bir rapor getir, elle ya da bilgisayarda yazılmış olabilir. İçinde şunlar olsun:

1. Ad soyad, öğrenci no, PR bağlantısı
2. Ne yaptın: her bölümü bir iki cümleyle anlat
3. Beklemediğin bir sonuç: çalıştırdığında seni şaşırtan bir çıktı ve neden şaşırdığın
4. Bir hata ve çözümü: aldığın bir hata mesajı, nedeni, nasıl çözdüğün
5. Yapay zeka beyanı: hangi aracı, hangi soruda, ne sorarak kullandın ve cevabı nasıl doğruladın
6. Bana sorun: anlamadığın, üstünden bir kez daha geçmemi istediğin konu

Şablon: [templates/odev-rapor-sablonu.md](../../templates/odev-rapor-sablonu.md)

Raporu neden kâğıt istiyorum: sorguyu yazdıktan sonra "bu sonuç ne anlama geliyor" sorusunu bir kez de kalemle cevaplamanı istiyorum. Ekranda düşünmekle kâğıtta düşünmek aynı şey değil. Ayrıca derste elden teslim, hepinizle o gün tek tek konuşabilmem demek.

**Kâğıt rapor gelmezse toplam puandan %25 kesilir.**

## Bu ödevde özellikle merak ettiklerim

Raporunda bu dört soruya da değin:

1. **Parantez tuzağı** (Hafta 4, Soru 7): parantezli ve parantezsiz hallerini çalıştırdın. Kaç satır fark etti, neden?
2. **Türkçe sıralama** (Hafta 4, Soru 14): `COLLATE` olmadan ve `COLLATE` ile sıraladın. Hangi isimler yer değiştirdi?
3. **Kayıp kayıtlar** (Hafta 5): `WHERE x < 50` ve `WHERE x >= 50` sonuçlarını topladığında toplam satır sayısını bulamıyorsun. Kaç kayıt kayboldu, nereye gitti?
4. **İki ortalama** (Hafta 5): `avg(sutun)` ile `avg(coalesce(sutun, 0))` farklı çıktı. Fark kaç puan, hangisi bu veri için daha dürüst bir rapor? Gerekçelendir. Gerekçesiz seçim, yanlış seçimle aynı puanı alır.

## Puan dağılımı

| Bölüm | Konu | Puan |
|---|---|---|
| 1 | Algoritma ve izleme | 20 |
| 2 | Veritabanı kavramları | 10 |
| 3 | SELECT ve WHERE | 35 |
| 4 | Gruplama ve NULL | 35 |

Her bölüm içinde doğruluk, kod kalitesi ve yorumun ayrı ayrı değerlendirilir. Ayrıntılı ölçütler: [RUBRIK.md](../../RUBRIK.md)

Bu ilk ödev olduğu için Git ve PR disiplininden puan kırmayacağım. Branch adını yanlış yazdıysan, commit mesajların dağınıksa yorum bırakırım, geçerim. Ödev 2'den itibaren bu ölçüt işlemeye başlar.

## Geç teslim

| Gecikme | Kesinti |
|---|---|
| 24 saate kadar | %20 |
| 24 ile 72 saat arası | %40 |
| 72 saatten fazla | Kabul edilmez |

Geçerli bir mazeretin varsa önceden yaz. Sonradan gelen mazeret kesintiyi kaldırmıyor.

## Yapay zeka kullanımı

Serbest, beyan zorunlu. ChatGPT, Claude, Copilot, hangisini istersen kullan. Ama raporunda hangi araçta ne sorduğunu ve çıkan cevabı nasıl doğruladığını yazacaksın.

Beyan edilmemiş kullanım ödevi sıfırlar. Bunu yakalamak sandığından kolay: bir modelin yazdığı sorgu ile senin bu hafta öğrendiğin SQL arasındaki fark bariz oluyor. Üstüne PR'a yorum olarak "bu satırı açıklar mısın" diye sorabiliyorum.

Ayrıntılı kural: [ODEVLER.md](../../ODEVLER.md) bölüm 6.

## Takıldığında

1. Önce hata mesajını oku. PostgreSQL genelde sorunu doğrudan söyler, hatta hangi karakterde olduğunu gösterir.
2. Sorgun hata vermiyor ama sonuç tuhafsa büyük küçük harfe, tırnak tipine, birime (saniye mi milisaniye mi) ve koşul önceliğine bak.
3. Her sorgunun sonucunu tek bir satır üzerinden gözünle doğrula.
4. Beş dakikadan fazla aynı yerde dönme. Ders reposundaki [soru şablonuyla](../../.github/ISSUE_TEMPLATE/question.md) issue aç ya da bana yaz.

Hepinize kolay gelsin. Zorlandığınız yerleri bana yazın, bir sonraki dersin ilk yarım saatini oraya ayıracağım.

## Bu ödev için kaynaklar

Hepsi ücretsiz. Hiçbirini baştan sona okuman gerekmiyor, takıldığın bölüme bak.

**Bölüm 1, algoritma ve izleme**

- [Python Tutor](https://pythontutor.com/), kodunu yapıştır, satır satır çalıştır, her adımda değişkenlerin değerini gör. İz sürme sorusunu önce kâğıtta çöz, sonra buradan kontrol et. Soru 1.1 için birebir uygun.
- [Python resmi öğretici, 4. bölüm](https://docs.python.org/3/tutorial/controlflow.html), `if`, `for`, `range()`, `break` ve `continue`. Soru 1.2 bu bölümün içinde.
- [Python resmi öğretici, 5. bölüm](https://docs.python.org/3/tutorial/datastructures.html), listeler ve sözlükler. Soru 1.3'te sözlüğü buradan kullanacaksın.

**Bölüm 2, veritabanı kavramları**

- [Database System Concepts](https://www.db-book.com/), ders kitabımız. Sitede 1. bölümün slaytları ücretsiz, kavram soruları oradan.
- [PostgreSQL öğretici, giriş](https://www.postgresql.org/docs/current/tutorial-start.html), bir veritabanı sunucusunun ne olduğu, istemci ile sunucunun farkı.

**Bölüm 3, SELECT ve WHERE**

- [PostgreSQL, Querying a Table](https://www.postgresql.org/docs/current/tutorial-select.html), dersin ana referansı.
- [SELECT komut referansı](https://www.postgresql.org/docs/current/sql-select.html), sorgunun hangi sırayla çalıştığını anlatan bölüm burada: FROM, WHERE, GROUP BY, SELECT, ORDER BY, LIMIT. Yazdığın sıra ile çalışan sıranın farklı olduğunu hatırla.
- [SQLBolt](https://sqlbolt.com/), tarayıcıda 18 adımlık alıştırma, kurulum yok. 1'den 6'ya kadar olan dersler bu bölümle örtüşüyor.
- [PGExercises, Basic](https://pgexercises.com/questions/basic/), PostgreSQL sözdizimiyle alıştırma, cevapları gizli.

**Bölüm 4, gruplama ve NULL**

- [PostgreSQL, Aggregate Functions](https://www.postgresql.org/docs/current/tutorial-agg.html), öğretici anlatım.
- [Toplama fonksiyonlarının tam listesi](https://www.postgresql.org/docs/current/functions-aggregate.html), `count`, `sum`, `avg`, `min`, `max` ve ötesi.
- [Markus Winand, NULL](https://modern-sql.com/concept/null), bu haftanın en önemli okuması. NULL neden "bilinmiyor" demek, neden `= NULL` çalışmaz, toplama fonksiyonları onu neden atlar. İki ortalama sorusunu cevaplamadan önce oku.
- [Koşullu ifadeler](https://www.postgresql.org/docs/current/functions-conditional.html), `CASE`, `COALESCE`, `NULLIF`.
- [Select Star SQL](https://selectstarsql.com/), gerçek bir veri seti üzerinde yazarak öğreniyorsun. Gruplama bölümü bu haftayla birebir.

**Teslim ve Git**

- [GitHub Docs, pull request oluşturma](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request), resmi adımlar, ekran görüntüleriyle.
- [Learn Git Branching](https://learngitbranching.js.org/), branch açmayı ve merge etmeyi görselleştirerek öğreten interaktif bir oyun. Komutları ezberlemek yerine ne olduğunu görmek istiyorsan yarım saat ayır.

**Yazım kalitesi**

- [SQL Style Guide](https://www.sqlstyle.guide/), okunur SQL nasıl yazılır. Anahtar kelimeler büyük, sütun adları küçük, her yan tümce yeni satırda. Rubrikteki "SQL kalitesi" ölçütü buradan besleniyor.

Tam liste ve ileri okuma: [RESOURCES.md](../../RESOURCES.md)
