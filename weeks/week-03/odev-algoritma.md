# Hafta 3 alıştırmaları: algoritma tekrarı

Bu sayfadaki sorular **Ödev 1'in 1. bölümüne** taşındı. Notlu teslim oradan yapılıyor: [Ödev 1](../week-05/odev.md), son tarih 23 Ekim 2026 Cuma.

Burada ek alıştırma olarak duruyorlar. Bölüm 1'i bitirdiysen Soru 4'ü de dene, zor olan o.

## Neden bu ödev

İlk iki haftada `for` ve `if` ile yazdığın kod, bu hafta gördüğün SQL sorgularının temelini oluşturuyor. Bu ödev iki haftalık konuyu pekiştirmek için var ve zor seviyede. Bazı sorularda kodu baştan yazman değil, var olan bir kodun ne yaptığını elle çözmen isteniyor, bu da bir mühendislik becerisi.

## Soru 1: İz sürme (trace table)

Aşağıdaki kodu kâğıt üzerinde, hiç çalıştırmadan, satır satır izle. Her döngü adımında `i`, `total` ve `result` değişkenlerinin aldığı değerleri bir tabloya yaz.

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

Son olarak `total` ve `result` değişkenlerinin son değerlerini yaz.

## Soru 2: En uzun seri

Elinde bir sensörün art arda okuduğu sıcaklık değerleri var:

```python
readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]
threshold = 22
```

Hazır fonksiyon kullanmadan (sadece `for`, `if`, değişken ve sayaç ile), eşik değerin (`threshold`) üzerinde art arda kaç okuma geldiğini bulan ve bu en uzun seriyi (ardışık sayıda) döndüren bir algoritma yaz. Örnek: `[18, 25, 26, 27, 19]` listesinde eşik 22 ise en uzun seri 3'tür (25, 26, 27).

Hem sözde kodunu hem Python kodunu yaz.

## Soru 3: Elle gruplama

Aşağıdaki kayıtların her biri bir öğrencinin aldığı dersi gösteriyor:

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

Hazır bir gruplama fonksiyonu (`Counter`, `groupby` gibi) kullanmadan, sadece `for`, `if` ve bir sözlük (`dict`) ile her dersin kaç öğrenci tarafından alındığını say. Çıktın şuna benzemeli: `{"VTYS": 3, "Yapay Zeka": 2, "Robotik": 1}`.

Bu soru haftaya göreceğin `GROUP BY` ve `COUNT`'un elle yapılmış hali, bu yüzden adımlarını iyi anla.

## Soru 4 (bonus, zor): En küçük farkı bulan çift

Bir sayı listesinde, birbirine en yakın iki sayıyı (aralarındaki fark en küçük olan çifti) bulan bir algoritma yaz. İç içe iki döngü kullanabilirsin ama her çifti iki kez karşılaştırmaktan kaçınacak bir yol bul (örneğin ikinci döngüyü birinciden sonra başlat).

```python
values = [12, 4, 29, 7, 15, 3, 31]
```

## Teslim şekli

Her sorunun cevabını ayrı ayrı, soru numarasıyla başlık atarak yaz. Kod sorularında hem mantığını kısaca açıkla hem kodu ver. Elle çalıştırmadan önce tahmin yürüt, sonra gerçek sonuçla karşılaştır, tutmadıysa nerede yanıldığını bir iki cümleyle belirt. Bu son adım, hatanı fark etme alışkanlığı kazandırdığı için önemli, atlamayın.
