# Hafta 1 ders notu: Algoritmik düşünme

> Bu belge slaytların metin sürümüdür. Ekran okuyucuyla okunabilir, tarayıcıda büyütülebilir.

## 1. Neden algoritmayla başlıyoruz?

Bu ders bir veritabanı dersi. Peki neden ilk iki hafta Python ve algoritma yapıyoruz?

Çünkü SQL öğrenirken yapacağın iş aslında şu: **bir soruyu, bilgisayarın anlayacağı kesin adımlara çevirmek.** Hafta 4'te "bataryası %20'nin altındaki robotları bul" diyeceğiz. O cümleyi sorguya çevirebilmen için önce "bir listeyi gez, her elemana bak, koşulu sağlıyorsa ayır" fikrini kurmuş olman gerekiyor.

İlk iki hafta o zihinsel kası çalıştırıyoruz. Hafta 2'nin sonunda şunu göreceksin: Python'da 5 satır süren bir iş, SQL'de tek satır. Ama o tek satırın ne yaptığını ancak 5 satırı yazmış biri anlar.

## 2. Algoritma nedir?

**Algoritma:** bir problemi bitiren, sıralı ve kesin adımlar dizisi.

Üç kelimenin altını çizelim:

- **Sıralı:** adımların sırası vardır ve değişirse sonuç değişir. Çay demlemede önce suyu kaynatırsın, sonra çayı atarsın.
- **Kesin:** her adım tek bir anlama gelmeli. "Biraz tuz at" algoritma değildir, "1 çay kaşığı tuz at" algoritmadır.
- **Bitiren:** sonsuza kadar sürmez, bir noktada durur ve bir sonuç verir.

### Günlük hayattan bir örnek

Problem: "Sabah hangi kıyafeti giyeceğim?"

```
1. Hava durumuna bak
2. Sıcaklık 15 dereceden düşükse
       mont al
   değilse
       mont alma
3. Yağmur bekleniyorsa
       şemsiye al
4. Dışarı çık
```

Bu bir algoritma: sıralı, kesin, bitiyor. İçinde iki tane de koşul var.

## 3. Problem çözmenin beş adımı

Boş ekrana bakıp donmanın ilacı bu sırayı takip etmek:

| Adım | Ne yaparsın |
|---|---|
| 1. Problemi anla | Girdi ne, çıktı ne? Tek cümleyle yaz |
| 2. Örneklerle dene | 2-3 somut örneği elle çöz |
| 3. Adımlara böl | Yaptığın işi sözde kodla yaz |
| 4. Kodla | Sözde kodu Python'a çevir |
| 5. Test et | Adım 2'deki örnekleri koda ver, aynı sonucu veriyor mu? |

Öğrencilerin çoğu 1, 2 ve 3'ü atlayıp doğrudan 4'ten başlar. Sonra da neden çalışmadığını anlamaz. **Elle çözemediğin bir problemi kodlayamazsın.**

## 4. Sözde kod (pseudocode)

Sözde kod, algoritmayı herhangi bir programlama diline bağlı kalmadan yazmaktır. Ne Python'dur ne Türkçe, ikisinin arası.

Problem: Bir sayının tek mi çift mi olduğunu bul.

```
BAŞLA
  sayı AL
  EĞER sayı mod 2 eşittir 0 İSE
      YAZ "çift"
  DEĞİLSE
      YAZ "tek"
BİTİR
```

Avantajı: dil detaylarıyla (noktalı virgül, parantez) uğraşmadan mantığa odaklanırsın. Sınavda ve iş görüşmelerinde de böyle düşünmen beklenir.

## 5. Akış şeması (flowchart)

Aynı algoritmanın görsel hali. Dört temel şekil:

| Şekil | Anlamı |
|---|---|
| Oval | Başla / Bitir |
| Paralelkenar | Girdi / Çıktı (`input`, `print`) |
| Dikdörtgen | İşlem (hesap, atama) |
| Eşkenar dörtgen | Karar (koşul, iki çıkışı vardır: evet / hayır) |

Tek/çift probleminin akışı: Başla → sayıyı al → "sayı mod 2 = 0 mu?" kararı → evet ise "çift" yaz, hayır ise "tek" yaz → Bitir.

## 6. Python temelleri

### Değişken

Değişken, bir değeri sakladığın isimli bir kutudur.

```python
battery_level = 18
robot_name = "Kartal-01"
is_active = True
```

Değişken adlarını **İngilizce ve snake_case** yazıyoruz. Bu dersin kuralı ve sektör standardı; aynı kuralı Hafta 4'ten itibaren tablo ve sütun adlarında da kullanacağız.

### Veri tipleri

| Tip | Ne tutar | Örnek |
|---|---|---|
| `int` | Tam sayı | `18`, `-5`, `0` |
| `float` | Ondalıklı sayı | `3.14`, `42.3` |
| `str` | Metin | `"Kartal-01"` |
| `bool` | Doğru/yanlış | `True`, `False` |

Ondalık ayırıcı **nokta**dır: `3.14`, `3,14` değil. Türkçe klavye alışkanlığıyla virgül yazmak en sık hatalardan biri ve aynı hata SQL'de de seni bekliyor.

Bir değerin tipini `type()` ile görebilirsin:

```python
print(type(18))        # <class 'int'>
print(type("18"))      # <class 'str'>
```

Dikkat: `18` ile `"18"` aynı şey değil. Biri sayı, öteki metin. `"18" + 1` hata verir.

### Girdi ve çıktı

```python
name = input("Robot adı: ")      # her zaman metin (str) döndürür
level = int(input("Batarya: "))  # sayı istiyorsan int() ile çevir
print("Robot:", name, "Batarya:", level)
```

`input()` **her zaman metin döndürür.** Sayı olarak kullanacaksan `int()` veya `float()` ile çevirmen gerekir. Çevirmezsen karşılaştırma yanlış çalışır.

### Karşılaştırma operatörleri

| Operatör | Anlamı |
|---|---|
| `==` | eşit |
| `!=` | eşit değil |
| `<` `>` | küçük, büyük |
| `<=` `>=` | küçük eşit, büyük eşit |

**Çok önemli:** `=` atama, `==` karşılaştırmadır. `x = 5` "x'e 5 koy" demek, `x == 5` "x 5'e eşit mi?" demek.

(SQL'de bu farklı olacak: orada karşılaştırma için tek `=` kullanılır. Hafta 4'te hatırlatacağım.)

### Mantıksal operatörler

| Operatör | Ne zaman doğru |
|---|---|
| `and` | İki taraf da doğruysa |
| `or` | En az biri doğruysa |
| `not` | Tersini alır |

## 7. Koşullu ifadeler

```python
battery_level = 18

if battery_level < 20:
    print("Kritik")
elif battery_level < 60:
    print("Düşük")
else:
    print("Normal")
```

Üç kural:

1. Koşul satırı **iki nokta üst üste** ile biter.
2. İçerideki satırlar **girintili** yazılır (4 boşluk). Python'da girinti süstür değil, sözdizimidir.
3. Koşullar **yukarıdan aşağı** denenir ve **ilk tutan kazanır.** 18 hem 20'den hem 60'tan küçük, ama önce 20 kontrolü geldiği için "Kritik" yazar.

Bu "ilk tutan kazanır" kuralını not et: Hafta 5'te SQL'in `CASE WHEN` yapısında birebir aynısıyla karşılaşacaksın.

### İç içe koşul

```python
if is_active:
    if battery_level < 20:
        print("Şarja gönder")
    else:
        print("Göreve devam")
else:
    print("Robot zaten kapalı")
```

## 8. İz sürme tablosu (trace table)

Kodu çalıştırmadan, elle adım adım takip etmeye iz sürme denir. Hata bulmanın en güvenilir yolu.

```python
x = 10
y = 3
z = x + y
x = z - 5
```

| Adım | x | y | z |
|---|---|---|---|
| Başlangıç | - | - | - |
| `x = 10` | 10 | - | - |
| `y = 3` | 10 | 3 | - |
| `z = x + y` | 10 | 3 | 13 |
| `x = z - 5` | 8 | 3 | 13 |

Sonuç: `x` 8, `y` 3, `z` 13.

Sınavda bu tür sorular çıkar ve asıl faydası şu: kafanda kod çalıştırabilmek, yazdığın kodun ne yapacağını önceden görebilmek demek.

## 9. Sık yapılan hatalar

| Hata | Belirti | Çözüm |
|---|---|---|
| `=` yerine `==` | `SyntaxError` | Karşılaştırmada çift eşittir |
| İki nokta unutmak | `SyntaxError: expected ':'` | `if x > 5:` |
| Girinti karışıklığı | `IndentationError` | Her blokta tutarlı 4 boşluk |
| `input()` sonucunu çevirmemek | `"18" < 20` hatası | `int(input(...))` |
| Ondalıkta virgül | `SyntaxError` | `3.14` yaz, `3,14` değil |

## 10. Bu haftanın özeti

- Algoritma: sıralı, kesin, biten adımlar
- Önce elle çöz, sonra kodla
- Sözde kod ve akış şeması aynı şeyin iki anlatımı
- Python'da değişken, dört temel tip, `if/elif/else`
- İlk tutan koşul kazanır
- İz sürme tablosuyla kodu kafanda çalıştır

**Gelecek hafta:** döngüler. Bir listedeki *bütün* robotlara aynı soruyu soracağız. O da SQL'deki `SELECT`in tam karşılığı olacak.

## Terim sözlüğü

| English | Türkçe | Bu haftaki anlamı |
|---|---|---|
| algorithm | algoritma | Problemi bitiren sıralı kesin adımlar |
| pseudocode | sözde kod | Dilden bağımsız algoritma yazımı |
| flowchart | akış şeması | Algoritmanın görsel hali |
| variable | değişken | Değer sakladığın isimli kutu |
| data type | veri tipi | `int`, `float`, `str`, `bool` |
| conditional statement | koşullu ifade | `if`, `elif`, `else` |
| comparison operator | karşılaştırma operatörü | `==`, `!=`, `<`, `>` |
| logical operator | mantıksal operatör | `and`, `or`, `not` |
| indentation | girinti | Python'da bloğu belirler |
| trace table | iz sürme tablosu | Kodu elle adım adım çalıştırma |
