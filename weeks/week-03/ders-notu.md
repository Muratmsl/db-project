# Hafta 3 ders notu: Veritabanı temel kavramları ve mimari

> Bu belge haftanın ders notudur. Slaytların slayt sırasına göre metin sürümü ayrıca var: [slides-text.md](slides-text.md).

## 1. Bir soruyla başlayalım

Diyelim ki 500 robotluk bir depo filosunu yönetiyorsun. Robotların durumunu, bataryasını, hangi bölgede olduğunu takip etmen gerek.

İlk aklına gelen: bir Excel dosyası.

Birkaç hafta gider. Sonra şunlar olur.

## 2. Dosya tabanlı sistemin dört sorunu

### 2.1 Veri tekrarı (redundancy)

Aynı robotu üç ayrı dosyaya yazdın: biri bakım listesi, biri envanter, biri sigorta dosyası. Aynı bilgi üç yerde duruyor.

### 2.2 Tutarsızlık (inconsistency)

Bakım dosyasında Kartal-01'in bataryası %18 yazıyor, envanterde %81. Parmak kaymış. Hangisi doğru? Bilemezsin. Veri tekrarı varsa, tutarsızlık kaçınılmazdır: bir yeri güncelleyip ötekini unutursun.

### 2.3 Eşzamanlı erişim (concurrent access)

Kırk kişi aynı dosyayı aynı anda açıp düzenlerse ne olur? Son kaydeden kazanır, diğerlerinin yazdığı uçar. Dosyalar aynı anda birden fazla yazara göre tasarlanmamıştır.

### 2.4 Güvenlik (security)

Dosyayı açan herkes her şeyi görür. Maaş sütununu stajyerden nasıl saklarsın? Dosya düzeyinde ya hep ya hiç.

### Bir de ölçek sorunu

Yapay zeka uygulamaları bu sorunları büyütür. Bir LLM uygulaması günde binlerce çağrı kaydeder. Bir robot filosu saniyede sensör verisi üretir. Bu hacim ve bu eşzamanlılık dosyayla yönetilemez.

## 3. VTYS ne yapar?

**VTYS (veritabanı yönetim sistemi, DBMS):** veriyi tek yerde, tutarlı ve güvenli tutan, aynı anda yüzlerce kişiye açan yazılım.

| Sorun | VTYS'nin çözümü |
|---|---|
| Veri tekrarı | Her bilgi tek bir yerde durur (normalizasyon, Hafta 7) |
| Tutarsızlık | Kısıtlar veriyi bozulmadan korur (Hafta 9) |
| Eşzamanlı erişim | Transaction ile herkes aynı anda güvenle çalışır (Hafta 10) |
| Güvenlik | Rol ve yetkiler, satır düzeyinde bile (Hafta 11) |

Bizim seçimimiz **PostgreSQL**: açık kaynak, ücretsiz, sektörde çok yaygın ve mezun olduğunda iş ilanlarında adını göreceksin.

## 4. İlişkisel model

Veritabanının içinde ne var? **Tablolar.**

| Terim | Ne demek | Örnek |
|---|---|---|
| Tablo (table) | Aynı türden kayıtların listesi | `robots` |
| Satır (row, record) | Tek bir varlığın bütün bilgileri | Kartal-01'in kaydı |
| Sütun (column, field) | Her kaydın bir özelliği | `battery_level` |
| Hücre | Bir satırla bir sütunun kesişimi | 18 |
| Şema (schema) | Tabloların yapısının tanımı | Hangi sütun hangi tipte |

### Excel'den farkı

Excel'de bir hücreye ne istersen yazarsın. Veritabanında yazamazsın: `battery_level` sayı tutmak üzere tanımlanmıştır, oraya "yüksek" yazmaya kalkarsan veritabanı kabul etmez, hata verir.

Bu bir kısıtlama değil, **koruma**. Verinin bozulmasını daha girerken engeller.

### Hafta 2'deki liste, aslında bir tabloydu

Geçen hafta şunu yazmıştık:

```python
robots = [
    {"name": "Atlas-01",  "battery_level": 82, "status": "active"},
    {"name": "Atlas-02",  "battery_level": 15, "status": "charging"},
]
```

Her sözlük bir **satır**, her anahtar bir **sütun**. Aynı veri bir veritabanı tablosunda şöyle durur:

| id | name | battery_level | status |
|---|---|---|---|
| 1 | Atlas-01 | 82 | active |
| 2 | Atlas-02 | 15 | charging |

Tek fark: tabloda tipler sabittir ve bir de `id` sütunu var, her satırı benzersiz tanımlayan birincil anahtar (Hafta 9).

## 5. Adlandırma kuralı

Tablo ve sütun adları: **İngilizce, küçük harf, kelimeler arasında alt çizgi.** Buna `snake_case` denir.

| İyi | Kötü | Neden |
|---|---|---|
| `battery_level` | `BatteryLevel` | Büyük harf tırnak gerektirir |
| `sensor_readings` | `sensör_okumaları` | Türkçe karakter sorun çıkarır |
| `created_at` | `tarih` | İngilizce, sektör standardı |
| `robots` | `robot_tablosu` | "tablo" kelimesi gereksiz |

Veri değerleri Türkçe olabilir: bölge adı "Depo A" olarak durur. Kural sadece **isimler** için.

## 6. PostgreSQL mimarisi

PostgreSQL bilgisayarında açtığın bir program değil, arka planda sürekli çalışan bir **hizmet**. Sen ona soru gönderirsin, o cevabı döndürür.

### Lokanta benzetmesi

| Lokantada | Veritabanında |
|---|---|
| Sen, müşteri | İstemci (client) |
| Sipariş | SQL sorgusu |
| Mutfak | Sunucu (server) |
| Gelen tabak | Sonuç tablosu |

Mutfağa girip tencereyi karıştırmazsın. Veriye de doğrudan dokunmazsın; her şey sorgu üzerinden olur.

### İstemci ne olabilir?

- `psql`: terminal programı, derste bunu kullanacağız
- Bir Python programı: projende bunu kullanabilirsin
- pgAdmin ve DBeaver: arayüzlü programlar

Üçü de aynı sunucuya aynı dili konuşur.

### Hiyerarşi

```
Küme (cluster)           bir sunucudaki her şey
  └─ Veritabanı          robot_fleet, llm_ops
       └─ Şema           public (varsayılan klasör)
            └─ Tablo     robots, missions, operators
```

Şema kısmını şimdilik derinleştirme: `public` diye bir varsayılan klasör var, tablolarımız orada duruyor.

### Eşzamanlılık

PostgreSQL her bağlanan için ayrı bir süreç açar. Bu yüzden kırk kişi aynı anda sorgu çalıştırabilir, kimse kimseyi beklemez. Dosyada çözemediğimiz sorun burada mimarinin kendisinde çözülmüş.

## 7. SQL'in alt dilleri

SQL tek bir dil gibi görünür ama beş gruba ayrılır. Hangi komutun ne yaptığını bu gruplar söyler.

| Kısaltma | Açılımı | Ne yapar | Komutlar | Hangi hafta |
|---|---|---|---|---|
| **DQL** | Data Query Language | Veriyi okur | `SELECT` | 4, 5, 6 |
| **DDL** | Data Definition Language | Yapıyı tanımlar | `CREATE`, `ALTER`, `DROP` | 9 |
| **DML** | Data Manipulation Language | Veriyi değiştirir | `INSERT`, `UPDATE`, `DELETE` | 10 |
| **DCL** | Data Control Language | Yetki verir | `GRANT`, `REVOKE` | 11 |
| **TCL** | Transaction Control Language | İşlemi yönetir | `COMMIT`, `ROLLBACK` | 10 |

Dönem boyunca beşini de göreceksin. Haftaya DQL ile başlıyoruz, çünkü en çok kullanacağın o.

## 8. SQL bildirimsel bir dildir

Geçen hafta şu karşılaştırmayı yapmıştık:

Python, 5 satır:

```python
low_battery = []
for robot in robots:
    if robot["battery_level"] < 20:
        low_battery.append(robot["name"])
print(low_battery)
```

SQL, 1 satır:

```sql
SELECT name FROM robots WHERE battery_level < 20;
```

Python'da **nasıl** bulacağını tarif ediyorsun. SQL'de sadece **ne** istediğini söylüyorsun. Döngü yok, if yok; tabloyu tarama işini PostgreSQL yapıyor.

Buna **bildirimsel (declarative)** dil denir ve SQL'in 1970'lerden beri ayakta kalmasının sebebi bu: ne istediğini söylemek, nasıl yapılacağını söylemekten daha uzun ömürlü.

## 9. Yapay zekada veritabanının yeri

Bu ders neden sizin programınızda var?

**LLM uygulamalarında (Yapay Zeka Operatörlüğü):** bir yapay zeka ürünü işletirken her çağrıyı kaydedersin: hangi model, kim çağırdı, kaç token, kaç milisaniye, kaça mal oldu. Ay sonunda biri sana "bu ay yapay zekaya kaç para verdik, kullanıcılar neden yavaş diye şikâyet ediyor?" diye sorar. Cevabı o tablodan çıkarırsın.

**Robotik sistemlerde:** filodaki her robot sürekli telemetri üretir. Batarya, konum, görev durumu, sensör okumaları. Bu veri olmadan ne arıza tahmini yapabilirsin ne de filo optimizasyonu.

**Ve bir de yeni bir kullanım var:** modern yapay zeka uygulamaları veritabanını *bilgi kaynağı* olarak kullanıyor. Bir chatbot'a şirket dokümanlarını bağlamak (RAG), metni sayısal vektöre çevirip anlamsal arama yapmak (pgvector). Hafta 11'de bunlara gireceğiz.

## 10. Bu haftanın özeti

- Dosya tabanlı sistemin dört sorunu: tekrar, tutarsızlık, eşzamanlı erişim, güvenlik
- VTYS bu dördünü çözmek için var
- Tablo, satır, sütun, şema: ilişkisel modelin dört terimi
- Adlar İngilizce ve snake_case, değerler Türkçe olabilir
- İstemci-sunucu: sen sorarsın, sunucu cevaplar
- SQL'in beş alt dili, biz DQL ile başlıyoruz
- SQL bildirimseldir: ne istediğini söylersin, nasıl yapılacağını değil

**Gelecek hafta:** ilk sorgunu yazacaksın. `SELECT`, `FROM`, `WHERE` ve Türkçe bir soruyu sorguya çevirmenin dört adımı.

## Terim sözlüğü

| English | Türkçe | Bu haftaki anlamı |
|---|---|---|
| database | veritabanı | Düzenli saklanan veri topluluğu |
| DBMS | VTYS | Veritabanını yöneten yazılım |
| relational model | ilişkisel model | Veriyi tablolarda tutma yaklaşımı |
| table / row / column | tablo / satır / sütun | |
| record / field | kayıt / alan | Satır ve sütunun diğer adları |
| schema | şema | Tabloların yapısı; ayrıca veritabanı içi klasör |
| cluster | küme | Bir sunucudaki tüm veritabanları |
| client / server | istemci / sunucu | Soran taraf / cevaplayan taraf |
| redundancy | veri tekrarı | Aynı bilginin birden çok yerde durması |
| inconsistency | tutarsızlık | Aynı bilginin farklı yerlerde farklı olması |
| concurrent access | eşzamanlı erişim | Aynı anda birden çok kullanıcı |
| DQL / DDL / DML / DCL / TCL | SQL'in alt dilleri | Sorgu / tanım / işleme / kontrol / işlem |
| declarative | bildirimsel | Ne istendiğini söyleyen dil |
