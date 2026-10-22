# Hafta 1 laboratuvar föyü

Ad soyad: ______________________  Öğrenci no: ______________  Tarih: __________

Süre: 2 saat. Takılırsan 5 dakikadan fazla uğraşma, el kaldır.

## Bölüm A: GitHub hesabı (30 dk)

Adımlar [SETUP.md](../../SETUP.md) bölüm 1'de. Tamamladıklarını işaretle:

- [ ] github.com'da hesap açtım, kullanıcı adım: ______________________
- [ ] E-posta adresimi doğruladım
- [ ] İki adımlı doğrulamayı (2FA) açtım
- [ ] Kurtarma kodlarımı güvenli bir yere kaydettim
- [ ] Ders hesabını (gizemturker) takip ettim

> Şifreni kimseyle paylaşma, benimle de. Senden hiçbir zaman şifre istemeyeceğim.

## Bölüm B: Elle algoritma (20 dk)

**B1.** Aşağıdaki problemi önce **sözde kodla** yaz, sonra **akış şeması** çiz.

Problem: Bir robotun batarya seviyesi veriliyor. %20'nin altındaysa "Şarja gönder", değilse "Göreve devam" yazdır.

Sözde kod:

```
BAŞLA



BİTİR
```

**B2.** İz sürme tablosunu doldur.

```python
a = 7
b = 2
c = a * b
a = c - a
b = a + b
```

| Adım | a | b | c |
|---|---|---|---|
| Başlangıç | - | - | - |
| `a = 7` | | | |
| `b = 2` | | | |
| `c = a * b` | | | |
| `a = c - a` | | | |
| `b = a + b` | | | |

Son değerler: a = ______, b = ______, c = ______

## Bölüm C: Python alıştırmaları (60 dk)

Her soruyu ayrı bir dosyada ya da tek dosyada sırayla yazabilirsin. Dosya adı: `hafta01_lab.py`

**C1. Isınma.** Adını soran ve "Merhaba <ad>, veritabanı dersine hoş geldin!" yazan bir program yaz.

**C2. Tek mi çift mi.** Kullanıcıdan bir tam sayı al, tek mi çift mi yazdır.
İpucu: `%` operatörü kalanı verir. `10 % 2` sonucu `0`.

**C3. Batarya durumu.** Kullanıcıdan batarya seviyesi (0-100) al ve şunu yazdır:
- 20'nin altı → `Kritik`
- 20 ile 59 arası → `Düşük`
- 60 ve üstü → `Normal`

Not: Bu üç kategoriyi Hafta 5'te SQL ile tekrar kuracağız, kodunu sakla.

**C4. Not harfe çevirme.** 0-100 arası bir not al, harf karşılığını yazdır:
AA (90+), BA (80-89), BB (70-79), CB (60-69), CC (50-59), FF (50'nin altı).

**C5. Üç sayının en büyüğü.** Kullanıcıdan üç sayı al, en büyüğünü yazdır.
Kural: `max()` fonksiyonunu **kullanma**, sadece `if/elif/else` ile çöz.

**C6. Robot kontrolü (zor).** Kullanıcıdan robotun durumunu (`active`, `charging`, `offline`) ve batarya seviyesini al. Şu kurala göre karar yazdır:
- Durum `offline` ise → `Robot kapalı, işlem yok`
- Durum `charging` ise → `Şarjda, bekle`
- Durum `active` ve batarya 20'nin altındaysa → `Şarja gönder`
- Durum `active` ve batarya 20 ve üstündeyse → `Göreve devam`

## Bölüm D: Kontrol listesi

- [ ] C1-C5 çalışıyor
- [ ] C6'yı denedim
- [ ] Kodumu en az üç farklı girdiyle test ettim
- [ ] Değişken adlarım İngilizce ve snake_case

## YZ kullanım beyanı

YZ aracı kullandıysan yaz. Kullanmak serbest, beyan zorunlu.

| Soru | Araç | Ne sordun |
|---|---|---|
| | | |

## Takıldığın yer

Bu hafta en çok nerede zorlandın? Bir iki cümle:

______________________________________________________________
