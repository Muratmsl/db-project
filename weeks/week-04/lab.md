# Hafta 4 laboratuvar föyü: SELECT ve WHERE

Ad soyad: ______________________  Öğrenci no: ______________  Tarih: __________

Program (işaretle):  ☐ Yapay Zeka Operatörlüğü (`llm_ops`)  ☐ Robotik ve Yapay Zeka (`robot_fleet`)

Süre: 2 saat. Takılırsan 5 dakikadan fazla uğraşma, el kaldır.

## Başlarken

```bash
psql -d robot_fleet     # Robotik
psql -d llm_ops         # YZO
```

Veritabanı kurulu değilse: [data/README.md](../../data/README.md)

Tanışma komutları: `\dt` tabloları listeler, `\d robots` bir tablonun sütunlarını gösterir.

**Nasıl çalışacaksın:** 15 sorunun her birinin iki sürümü var. Kendi programının sürümünü çöz. Bitirirsen diğerine geç, bu bonus.

**Nasıl teslim edeceksin:** bu föyün 15 sorusu **Ödev 1'in 3. bölümü**. Sorguları `odevler/odev-01/bolum3.sql` dosyasına yaz, her sorgunun üstüne `-- Soru 3` gibi bir yorum satırı ekle, altına kaç satır döndüğünü. Ödevin tamamı: [../week-05/odev.md](../week-05/odev.md)

---

## Isınma (1-5)

**1.** Tabloyu tanı.
- **R:** Bütün robotların adını ve modelini listele.
- **Y:** Bütün çağrıların id'sini ve model adını listele.

Kaç satır döndü? ______

**2.** Takma ad ve hesaplanmış sütun.
- **R:** Robot adını `robot`, eksik şarj miktarını (100 eksi batarya) `missing` başlığıyla göster.
- **Y:** Model adını `model`, toplam token sayısını (prompt + completion) `total_tokens` başlığıyla göster.

**3.** Sayısal koşul.
- **R:** Bataryası 50'nin üstündeki robotlar.
- **Y:** Gecikmesi 2 saniyeyi aşan çağrılar. *(Dikkat: sütun milisaniye cinsinden.)*

**4.** Metin koşulu.
- **R:** Bakımdaki (`maintenance`) robotlar.
- **Y:** Ece'nin yaptığı çağrılar.

**5.** Eşit değil.
- **R:** Görevde **olmayan** robotlar.
- **Y:** Sohbet (`chat`) **dışındaki** çağrılar.

---

## Orta (6-10)

**6.** İki koşul, `AND`.
- **R:** AMR-300 modelinde olup bataryası 40'ın üstündeki robotlar.
- **Y:** Adı `claude` ile başlayan modellere yapılan, 1 saniyeden yavaş çağrılar.

**7.** Parantez. *Bu soruda bir tuzak var.*
- **R:** Şarjda **veya** bakımda olan, bataryası 50'nin altındaki robotlar.
- **Y:** Kod **veya** çeviri işi olan, maliyeti 0.01 doları aşan çağrılar.

Parantez koymadan da dene. Kaç satır fark etti? ______ Neden?

______________________________________________________________

**8.** `BETWEEN`.
- **R:** Bataryası 15 ile 50 arasındaki robotlar (uçlar dahil).
- **Y:** Gecikmesi 500 ile 1500 ms arasındaki çağrılar.

**9.** `IN` / `NOT IN`.
- **R:** Depo A veya Depo B'de **olmayan** robotlar.
- **Y:** gpt ailesine (`gpt-4o`, `gpt-4o-mini`) yapılan çağrılar.

**10.** Kalıp arama.
- **R:** Adı "kartal" ile başlayan robotlar, büyük/küçük harf fark etmeksizin.
- **Y:** Model adında "mini" geçen çağrılar.

Kaç satır bekliyordun? ______ Kaç geldi? ______ Fark varsa neden?

______________________________________________________________

---

## Zor (11-15)

**11.** Çoklu sıralama.
- **R:** Önce modele (A'dan Z'ye), model içinde bataryaya (yüksekten düşüğe) göre sırala.
- **Y:** Önce kullanıcıya, kullanıcı içinde maliyete (pahalıdan ucuza) göre sırala.

**12.** Sıralama ve sınırlama.
- **R:** En dolu 3 robot.
- **Y:** En pahalı 3 çağrı.

**13.** Tekrarsız liste.
- **R:** Filoda hangi bölgeler var?
- **Y:** Hangi iş türleri (`task_type`) var?

**14.** Türkçe sıralama.
- **R:** Operatör adlarını doğru Türkçe alfabe sırasıyla listele.
- **Y:** Kullanıcı adlarını doğru Türkçe alfabe sırasıyla, tekrarsız listele.

Önce `COLLATE` kullanmadan dene, sonra `COLLATE "tr-TR-x-icu"` ile. Hangi isimler yer değiştirdi?

______________________________________________________________

**15.** Soruyu sorguya çevir. *Dört adımı uygula: tablo, sütunlar, koşul, sıra.*
- **R:** "Dış Alan veya Depo B'deki, görevdeki robotların adını, bölgesini ve bataryasını, en düşük bataryadan başlayarak listele."
- **Y:** "14 Ekim'den sonra yapılan, 1 saniyeden yavaş çağrıların id'sini, modelini ve gecikmesini, en yavaştan başlayarak listele."

---

## Bonus (isteğe bağlı)

**B1.** Diğer programın 15 sorusunu da çöz.

**B2.** Kendi proje senaryon için üç soru yaz (henüz veritabanın yok, sadece Türkçe cümle olarak). Hangi tabloya, hangi koşulla soracağını da belirt. Bu sorular Hafta 7'de şemanı tasarlarken işine yarayacak.

1. ______________________________________________________________
2. ______________________________________________________________
3. ______________________________________________________________

---

## Kontrol listesi

- [ ] 1-5 çalışıyor
- [ ] 6-10 çalışıyor
- [ ] 11-15 çalışıyor
- [ ] Her sorgunun sonucunu gözümle bir satır üzerinden kontrol ettim
- [ ] `.sql` dosyamda her sorgunun üstünde soru numarası var
- [ ] Commit attım

## YZ kullanım beyanı

YZ aracı kullanmak serbest, beyan zorunlu.

| Soru | Araç | Ne sordun | Çıkan cevabı doğruladın mı |
|---|---|---|---|
| | | | |

## Takıldığın yer

Bu hafta en çok nerede zorlandın?

______________________________________________________________

Hangi hata mesajını aldın ve nasıl çözdün?

______________________________________________________________
