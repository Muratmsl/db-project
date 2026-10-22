# Hafta 5 laboratuvar föyü: Gruplama ve NULL

Ad soyad: ______________________  Öğrenci no: ______________  Tarih: __________

Program (işaretle):  ☐ Yapay Zeka Operatörlüğü (`llm_ops`)  ☐ Robotik ve Yapay Zeka (`robot_fleet`)

Süre: 2 saat.

## Bu haftanın farkı

Geçen hafta sorgu yazdık, bu hafta **sorgunun cevabını yorumlayacağız.** Her sorunun altında bir yorum satırı var; orayı boş bırakma. Bu haftanın konusu sayı üretmek değil, **sayının ne anlama geldiğini bilmek.**

```bash
psql -d robot_fleet     # Robotik
psql -d llm_ops         # YZO
```

Teslim: bu föyün 15 sorusu **Ödev 1'in 4. bölümü**. Sorgular `odevler/odev-01/bolum4.sql` dosyasına, her sorgunun altına sonucu yorumlayan bir cümle. Ödevin tamamı: [odev.md](odev.md)

---

## Isınma (1-5)

**1.** Toplam kaç kayıt var?
- **R:** Filoda kaç robot var?
- **Y:** Kaç çağrı kaydedilmiş?

Cevap: ______

**2.** Koşullu sayma.
- **R:** Kaç robot görevde (`active`)?
- **Y:** Kaç çağrı 2 saniyeden yavaş?

Cevap: ______

**3.** Toplama.
- **R:** Bütün bataryaların toplamı.
- **Y:** Toplam maliyet ve toplam token sayısı.

**4.** Ortalama, bir ondalık basamağa yuvarlanmış.
- **R:** Ortalama batarya seviyesi.
- **Y:** Ortalama gecikme.

Cevap: ______ *(Bu sayıyı not et, 13. soruda geri döneceğiz.)*

**5.** En küçük ve en büyük.
- **R:** En düşük ve en yüksek batarya.
- **Y:** En hızlı ve en yavaş çağrı.

---

## Orta (6-10)

**6.** İlk gruplaman.
- **R:** Her durumda (`status`) kaç robot var?
- **Y:** Her iş türünde (`task_type`) kaç çağrı var?

Kaç satır döndü? ______ Neden o kadar?

______________________________________________________________

**7.** Grup başına iki özet.
- **R:** Her model için robot sayısı **ve** ortalama batarya.
- **Y:** Her model için çağrı sayısı **ve** toplam maliyet, pahalıdan ucuza.

**8.** İki sütuna göre gruplama.
- **R:** Her bölgede, her durumdan kaç robot var?
- **Y:** Her kullanıcının her iş türünden kaç çağrısı var?

Sonuçta beklemediğin bir satır var mı? Hangisi ve neden?

______________________________________________________________

**9.** `HAVING`.
- **R:** Birden fazla robotu olan modeller.
- **Y:** İkiden fazla çağrı almış modeller.

Dikkat: "ikiden fazla" kaçtan büyük demek? ______

**10.** `WHERE` ve `HAVING` birlikte.
- **R:** Sadece görevdeki robotları hesaba kat; en az 2 robotu olan modelleri ortalama bataryasıyla göster.
- **Y:** Sadece 500 ms'den yavaş çağrıları hesaba kat; en az 2 çağrısı olan modelleri ortalama gecikmesiyle göster.

Bu sorguda `WHERE` neyi eledi, `HAVING` neyi eledi?

______________________________________________________________

---

## Zor (11-15)

**11.** NULL avı. Tek bir sorguda `count(*)` ile her sütunun `count`'unu yan yana koy.
- **R:** `robots` tablosunda hangi sütunda kaç eksik veri var?
- **Y:** `llm_calls` tablosunda hangi sütunda kaç eksik veri var?

| Sütun | Dolu | Eksik |
|---|---|---|
| | | |
| | | |

**12.** Eksik kayıtları bul.
- **R:** Bilgisi eksik olan robotları listele (bataryası, bölgesi veya operatörü boş olanlar).
- **Y:** Faturası gelmemiş çağrıları listele.

Önce `= NULL` ile dene. Kaç satır geldi? ______ Sonra `IS NULL` ile dene. Kaç satır geldi? ______

**13.** İki ortalama. Ortalamayı iki şekilde hesapla ve yan yana göster: boşları atlayarak ve boşları sıfır sayarak (`COALESCE`).

Boşu atlayarak: ______  Boşu sıfır sayarak: ______

Hangisi bu veri için daha dürüst bir rapor olur? Neden?

______________________________________________________________

______________________________________________________________

**14.** Zaman.
- **R:** Operatörleri işe giriş yılına göre say. *(`operators` tablosunu kullan.)*
- **Y:** Günlük kullanım raporu: gün, çağrı sayısı, toplam maliyet.

**Y için ek soru:** En çok çağrı alan gün hangisi? O günün maliyeti neden beklediğinden düşük?

______________________________________________________________

**15.** Kendi kategorini yarat (`CASE WHEN`) ve ona göre grupla.
- **R:** Bataryaya göre: Kritik (20'nin altı), Düşük (20-59), Normal (60 ve üstü), Bilinmiyor. Her kategoride kaç robot var?
- **Y:** Gecikmeye göre: Hızlı (1000 ms altı), Orta (1000-2499), Yavaş (2500 ve üstü). Her kategoride kaç çağrı var ve ortalama gecikme ne?

**R için ek soru:** `WHEN battery_level IS NULL` satırını en sona taşı ve tekrar çalıştır. Kartal-04 hangi kategoriye düştü? ______ Neden?

______________________________________________________________

---

## Bonus (isteğe bağlı)

**B1.** Diğer programın sorularını da çöz.

**B2.** Hafta 4'te indirdiğin **kendi** ham verine bak (CSV olarak açabilirsin). Üç soruyu cevapla:

- Kaç satır var? ______
- Hangi sütunlarda eksik veri var? ______________________
- Hangi sütuna göre gruplamak anlamlı olur? ______________________

Bu üç cevap Hafta 7'de şemanı tasarlarken başlangıç noktan olacak.

---

## Kontrol listesi

- [ ] 1-5 çalışıyor
- [ ] 6-10 çalışıyor
- [ ] 11-15 çalışıyor
- [ ] Her sorgunun yanına yorum cümlemi yazdım
- [ ] Eksik verinin sonucu etkilediği en az bir yer buldum
- [ ] Commit attım

## YZ kullanım beyanı

| Soru | Araç | Ne sordun | Çıkan cevabı doğruladın mı |
|---|---|---|---|
| | | | |

## Takıldığın yer

Bu haftanın en şaşırtıcı sonucu neydi?

______________________________________________________________
