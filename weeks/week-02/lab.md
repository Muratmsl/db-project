# Hafta 2 laboratuvar föyü

Ad soyad: ______________________  Öğrenci no: ______________  Tarih: __________

Süre: 2 saat. Takılırsan 5 dakikadan fazla uğraşma, el kaldır.

## Başlarken

Yeni bir dosya aç: `hafta02_lab.py`. Bütün soruların başına şu veriyi kopyala:

```python
robots = [
    {"name": "Atlas-01",  "model": "AMR-200", "status": "active",      "battery_level": 82, "zone": "Depo A"},
    {"name": "Atlas-02",  "model": "AMR-200", "status": "charging",    "battery_level": 15, "zone": "Şarj"},
    {"name": "Kartal-01", "model": "DRN-X1",  "status": "active",      "battery_level": 18, "zone": "Dış Alan"},
    {"name": "Kartal-02", "model": "DRN-X1",  "status": "maintenance", "battery_level": 64, "zone": "Atölye"},
    {"name": "Mars-01",   "model": "AMR-300", "status": "active",      "battery_level": 47, "zone": "Depo B"},
    {"name": "Mars-02",   "model": "AMR-300", "status": "active",      "battery_level":  9, "zone": "Depo B"},
    {"name": "Atlas-03",  "model": "AMR-200", "status": "offline",     "battery_level":  0, "zone": "Depo A"},
    {"name": "Kartal-03", "model": "DRN-X1",  "status": "active",      "battery_level": 91, "zone": "Dış Alan"},
]
```

Bu veriyi tanı: Hafta 4'ten itibaren aynı robotları gerçek bir veritabanı tablosunda göreceksin.

## Bölüm A: Isınma (20 dk)

**A1.** Döngüyle bütün robotların adını alt alta yazdır.

**A2.** Döngüyle her robotun adını ve bataryasını şu biçimde yazdır:
`Atlas-01 - 82%`

**A3.** `range()` kullanarak 1'den 10'a kadar olan sayıların karesini yazdır.

**A4.** Aşağıdaki kod kaç satır yazdırır? Önce **tahmin et**, sonra çalıştır.

```python
for i in range(3):
    for j in range(2):
        print(i, j)
```

Tahminim: ______  Gerçek: ______

## Bölüm B: Dört temel algoritma (40 dk)

Bu bölümde `sum()`, `len()`, `max()`, `min()` gibi hazır fonksiyonları **kullanma**. Hepsini döngüyle elle yaz. Amaç bu fonksiyonların içinde ne olduğunu görmek.

**B1. Sayma.** Kaç robot `active` durumda? (Beklenen cevap: 5)

**B2. Toplama.** Bütün bataryaların toplamı kaç? (Beklenen cevap: 326)

**B3. Ortalama.** Ortalama batarya seviyesi kaç? Sonucu bir ondalık basamağa yuvarla.
İpucu: `round(sayi, 1)`

**B4. En büyük.** En yüksek bataryalı robotun **adını** yazdır. (Sadece sayıyı değil, adını.)

**B5. En küçük.** En düşük bataryalı robotun adını yazdır.

## Bölüm C: Filtreleme (40 dk)

**C1.** Bataryası 20'nin altındaki robotların adlarını bir listeye topla ve yazdır.

**C2.** `DRN-X1` modelindeki robotların adlarını yazdır.

**C3.** Hem `active` olan **hem de** bataryası 50'nin altındaki robotları yazdır.

**C4.** `Depo A` veya `Depo B` bölgesindeki robotları yazdır.

**C5.** Her model için kaç robot olduğunu yazdır. Beklenen çıktı:

```
AMR-200: 3
DRN-X1: 3
AMR-300: 2
```

İpucu: bir sözlük kullan, `counts = {}`, her modeli gördükçe sayacı artır.
Bu soru zor. Hafta 5'te aynı işi SQL'de **tek satırda** yapacağız: `GROUP BY model`.

## Bölüm D: Düşünme sorusu (10 dk)

C1'de yazdığın kodu aşağıya kopyala:

```python



```

Şimdi şu SQL sorgusuna bak (Hafta 4'te öğreneceğiz):

```sql
SELECT name FROM robots WHERE battery_level < 20;
```

İkisi aynı işi yapıyor. Sence SQL versiyonunda **kaybolan** bilgi ne? Yani Python kodunda açıkça yazdığın ama SQL'de yazmadığın şey nedir?

______________________________________________________________

______________________________________________________________

## Bölüm E: Kontrol listesi

- [ ] A1-A4 çalışıyor
- [ ] B1-B5 hazır fonksiyon kullanmadan çalışıyor
- [ ] C1-C4 çalışıyor
- [ ] C5'i denedim
- [ ] D bölümünü cevapladım

## YZ kullanım beyanı

| Soru | Araç | Ne sordun |
|---|---|---|
| | | |

## Takıldığın yer

______________________________________________________________
