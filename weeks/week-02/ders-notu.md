# Hafta 2 ders notu: Döngüler ve temel algoritmalar

> Bu belge slaytların metin sürümüdür. Ekran okuyucuyla okunabilir, tarayıcıda büyütülebilir.

## 1. Bu haftanın tek cümlesi

Geçen hafta **bir** değer üzerinde karar verdik. Bu hafta **çok** değer üzerinde aynı işi tekrarlayacağız.

Ve bu haftanın asıl hedefi şu: dersin sonunda yazacağın beş satırlık Python kodu, iki hafta sonra SQL'de **tek satır** olacak. O farkı kendi gözünle görmeni istiyorum.

## 2. Liste (list)

Liste, birden çok değeri tek bir değişkende tutmanı sağlar.

```python
battery_levels = [82, 15, 18, 64, 47, 9, 0, 91]
robot_names = ["Atlas-01", "Atlas-02", "Kartal-01"]
```

| İşlem | Kod | Sonuç |
|---|---|---|
| Uzunluk | `len(battery_levels)` | `8` |
| İlk eleman | `battery_levels[0]` | `82` |
| Üçüncü eleman | `battery_levels[2]` | `18` |
| Son eleman | `battery_levels[-1]` | `91` |
| Eleman ekleme | `battery_levels.append(55)` | listeye eklenir |

**Sayma sıfırdan başlar.** İlk eleman `[0]`, ikinci eleman `[1]`. Bu, programlamada en sık hata kaynaklarından biri ("off by one" hatası).

### Sözlük listesi

Gerçek veri genelde sadece sayı değildir. Her robotun hem adı hem bataryası var:

```python
robots = [
    {"name": "Atlas-01",  "battery_level": 82, "status": "active"},
    {"name": "Atlas-02",  "battery_level": 15, "status": "charging"},
    {"name": "Kartal-01", "battery_level": 18, "status": "active"},
    {"name": "Kartal-02", "battery_level": 64, "status": "maintenance"},
]
```

Bir elemana erişim:

```python
print(robots[0]["name"])           # Atlas-01
print(robots[2]["battery_level"])  # 18
```

**Bu yapıya dikkatli bak.** Bu aslında bir tablo: her sözlük bir satır, her anahtar bir sütun. Hafta 3'te aynı veriyi gerçek bir veritabanı tablosu olarak göreceğiz. Şimdiden bağlantıyı kur.

## 3. for döngüsü

```python
for level in battery_levels:
    print(level)
```

Okunuşu: "battery_levels listesindeki her eleman için, o elemana `level` de ve şunu yap."

Üç kural geçen haftakiyle aynı: satır iki nokta ile biter, gövde girintilidir, değişken adı İngilizce.

### range() ile sayı üretmek

```python
for i in range(5):        # 0, 1, 2, 3, 4
    print(i)

for i in range(1, 6):     # 1, 2, 3, 4, 5
    print(i)
```

`range(5)` beş sayı üretir ama **5'i içermez**: 0'dan başlar, 5'e kadar gider. Bu da klasik bir karışıklık noktası.

### Sözlük listesinde gezinmek

```python
for robot in robots:
    print(robot["name"], robot["battery_level"])
```

## 4. while döngüsü

`for` "şu listedeki her eleman için" der. `while` ise "şu koşul doğru olduğu sürece" der.

```python
battery = 100
while battery > 20:
    print("Batarya:", battery)
    battery = battery - 15
print("Şarja gidiyor")
```

| Ne zaman hangisi |
|---|
| Kaç kere döneceğini biliyorsan → `for` |
| Bir koşul bozulana kadar dönecekse → `while` |

**Sonsuz döngü tuzağı:** `while` içinde koşulu değiştiren satırı unutursan program hiç durmaz. Yukarıdaki örnekte `battery = battery - 15` satırını silersen program sonsuza kadar çalışır. Takılırsan Ctrl+C ile durdur.

## 5. Dört temel algoritma

Bu dördü, bu dersin geri kalanının temeli. Hepsini elle yazacağız, sonra Hafta 5'te SQL'de hazır fonksiyonlarını göreceğiz.

### 5.1 Sayma (count)

```python
count = 0
for robot in robots:
    if robot["status"] == "active":
        count = count + 1
print("Aktif robot sayısı:", count)   # 2
```

Desen: sıfırdan başlayan bir sayaç, koşul tutunca bir artar.

### 5.2 Toplama (sum)

```python
total = 0
for robot in robots:
    total = total + robot["battery_level"]
print("Toplam:", total)   # 179
```

`total` değişkenine **biriktirici (accumulator)** denir. Döngüden önce sıfırlanır, döngü içinde büyür.

### 5.3 Ortalama (average)

```python
total = 0
count = 0
for robot in robots:
    total = total + robot["battery_level"]
    count = count + 1
average = total / count
print("Ortalama:", average)   # 44.75
```

Ortalama = toplam ÷ adet. İki biriktirici birden kullanıyoruz.

**Burayı aklında tut:** Hafta 5'te şu soruyu soracağız: eğer bir robotun bataryası *bilinmiyorsa*, onu adede katmalı mıyız? Bu küçük soru bütün raporu değiştirebiliyor.

### 5.4 En büyüğü bulma (max)

```python
largest = robots[0]["battery_level"]
for robot in robots:
    if robot["battery_level"] > largest:
        largest = robot["battery_level"]
print("En yüksek batarya:", largest)   # 82
```

Desen: ilk elemanı "şimdilik en büyük" kabul et, sonra daha büyüğünü gördükçe güncelle.

## 6. Filtreleme

En önemli desen bu, çünkü SQL'in `WHERE`inin tam karşılığı.

```python
low_battery = []
for robot in robots:
    if robot["battery_level"] < 20:
        low_battery.append(robot["name"])
print(low_battery)   # ['Atlas-02', 'Kartal-01']
```

Üç parça var ve bu üçünü aklında tut:

| Parça | Kod | SQL karşılığı (Hafta 4) |
|---|---|---|
| Hangi veri | `for robot in robots` | `FROM robots` |
| Hangi koşul | `if robot["battery_level"] < 20` | `WHERE battery_level < 20` |
| Ne alınacak | `robot["name"]` | `SELECT name` |

## 7. İşte o fark

Yukarıdaki filtreleme kodunu bir kez daha yazalım, sonra SQL karşılığını koyalım.

Python, 5 satır:

```python
low_battery = []
for robot in robots:
    if robot["battery_level"] < 20:
        low_battery.append(robot["name"])
print(low_battery)
```

SQL, 1 satır (Hafta 4'te öğreneceğiz):

```sql
SELECT name FROM robots WHERE battery_level < 20;
```

Fark sadece kısalık değil. Python'da **nasıl** bulacağını tarif ediyorsun: listeyi gez, her elemana bak, koşulu sağlıyorsa ekle. SQL'de sadece **ne** istediğini söylüyorsun; nasıl bulacağına veritabanı karar veriyor.

Bu ayrıma programlama dillerinde **imperative** (emir kipi) ve **declarative** (bildirimsel) denir. SQL bildirimsel bir dildir.

Bugün yazdığın kod boşa gitmiyor: SQL'in senin yerine ne yaptığını bilerek kullanacaksın. Bir sorgu beklenmedik sonuç verdiğinde, arka planda hangi döngünün çalıştığını hayal edebilmek seni kurtaracak.

## 8. Sık yapılan hatalar

| Hata | Belirti | Çözüm |
|---|---|---|
| Biriktiriciyi döngü içinde sıfırlamak | Toplam hep son elemana eşit | `total = 0` döngüden **önce** olmalı |
| Girinti hatası | Beklenmedik sonuç | Döngü gövdesi tutarlı girintili olmalı |
| `range(5)` 5'i içeriyor sanmak | Bir eksik/fazla sonuç | `range(5)` → 0,1,2,3,4 |
| `while` içinde koşulu değiştirmemek | Program donuyor | Ctrl+C, sonra koşulu güncelleyen satırı ekle |
| Boş listede ortalama | `ZeroDivisionError` | Bölmeden önce `count > 0` kontrolü |

Son satır önemli: sıfıra bölme hatası. Hafta 5'te SQL'de aynı sorunla karşılaşacağız ve `NULLIF` ile çözeceğiz.

## 9. Bu haftanın özeti

- Liste birden çok değeri tutar, sayma sıfırdan başlar
- `for` her eleman için, `while` koşul sürdükçe
- Dört temel desen: sayma, toplama, ortalama, en büyüğü bulma
- Filtreleme = hangi veri + hangi koşul + ne alınacak
- Aynı iş SQL'de tek satır olacak, çünkü SQL bildirimsel bir dil

**Gelecek hafta:** veritabanı nedir, neden dosya yetmez, PostgreSQL nasıl çalışır. Bu haftaki `robots` listesi gerçek bir tabloya dönüşecek.

## Terim sözlüğü

| English | Türkçe | Bu haftaki anlamı |
|---|---|---|
| list / array | liste / dizi | Birden çok değeri tutan yapı |
| index | indis | Listedeki sıra numarası, sıfırdan başlar |
| loop | döngü | Tekrar eden iş |
| for loop | for döngüsü | Her eleman için |
| while loop | while döngüsü | Koşul doğru olduğu sürece |
| iteration | yineleme | Döngünün tek bir adımı |
| accumulator | biriktirici | Toplamı veya sayacı tutan değişken |
| filter | filtreleme | Koşula uyanları seçme |
| imperative | emir kipi | Nasıl yapılacağını tarif eden dil (Python) |
| declarative | bildirimsel | Ne istendiğini söyleyen dil (SQL) |
