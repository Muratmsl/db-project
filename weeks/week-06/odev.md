# Ödev 2: JOIN

> **Bu ödev henüz açılmadı.** Konusu belli, tarihi değil. Şu an aktif olan tek ödev [Ödev 1](../week-05/odev.md), son teslim 23 Ekim 2026 Cuma. Buradaki yönergeyi şimdiden okuyabilirsin.

Hafta 6 konusu. 100 puan.

**Son teslim: tarih sonra duyurulacak, ders saatinden önce GitHub'da. Tek sayfalık kâğıt rapor aynı gün derste.**

## Amaç

İki tabloyu doğru JOIN türüyle birleştirebilmek ve bir toplamın JOIN yüzünden neden şiştiğini fark edebilmek.

## Yapılacaklar

### Bölüm 1: Lab soruları (zorunlu)

[lab.md](lab.md) dosyasındaki **15 soruyu** çöz, `odevler/odev-02/cozumler.sql` dosyasına yaz. Geçen haftaki gibi her sorgunun altına yorum cümlesi.

### Bölüm 2: Kendi verini ikiye böl (zorunlu)

Şimdiye kadar tek bir CSV ile çalıştın. Gerçek bir veritabanı tek tablo olmaz.

`SCENARIO.md` içine bir "Tablolara ayırma taslağı" bölümü ekle:

- [ ] Verini kaç tabloya bölersin? Her tablonun adını yaz (İngilizce, çoğul, snake_case)
- [ ] Her tablonun hangi sütunları olur?
- [ ] Tablolar hangi sütun üzerinden birleşir? (yabancı anahtar adayın)
- [ ] Hangi JOIN türüne ihtiyacın olacak ve neden?
- [ ] Bir tabloda karşılığı olmayan kayıtlar olabilir mi? (örnek: siparişi olmayan müşteri)

Son soru Hafta 7'de ERD çizerken işine yarayacak.

### Bölüm 3: Bonus (isteğe bağlı)

- Diğer programın sorularını da çöz
- [SQL Murder Mystery](https://mystery.knightlab.com/) oyununu bitir, çözüm sorgunu `odevler/odev-02/bonus-mystery.sql` içine koy

## Teslim

| Ne | Nerede |
|---|---|
| Sorgular (yorumlu) | `odevler/odev-02/cozumler.sql` |
| Rapor (dijital) | `odevler/odev-02/rapor.md` |
| Tablolara ayırma taslağı | `SCENARIO.md` içinde |
| PR | Branch `odev-02`, reviewer: gizemturker |
| **Rapor (kâğıt)** | **Hafta 7 dersinde elden** |

## Raporda özellikle cevaplamanı istediklerim

1. **INNER ve LEFT farkı:** aynı sorguyu iki JOIN türüyle çalıştırdın, satır sayısı değişti. Kaç satır fark etti ve o satırlar neden INNER JOIN'de yok?
2. **Fan-out:** bir toplamı JOIN'den önce ve sonra hesapladın, sonuç şişti. Kaçtan kaça çıktı ve neden?
3. **count(\*) tuzağı:** `LEFT JOIN` sonrası `count(*)` ile `count(sag_tablo.id)` farklı sonuç verdi. Hangisi doğru ve neden?

## Değerlendirme

[RUBRIK.md bölüm 1](../../RUBRIK.md).

**Kâğıt rapor gelmezse toplamdan %25 kesilir.**
