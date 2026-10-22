# BLP 105 / BLP 1005 Veritabanı Yönetim Sistemleri

Doğuş Üniversitesi MYO · Güz 2026-2027 · Öğretim görevlisi: Gizem Türker (GitHub: [gizemturker](https://github.com/gizemturker))

Bu repo dersin ortak kaynak reposu: ders amacı, haftalık konular, ders notları, örnek veritabanları, kaynak kitaplar, kurulum rehberi ve sözlük burada durur. Haftalık içerik her hafta buraya eklenir. Ödevlerini bu repoya değil, kendi proje reponuza koyacaksınız.

## Bu repoyu nasıl kullanırsın

1. Repoyu bir kez clone'la: `git clone https://github.com/gizemturker/blp105-course.git`
2. Her hafta ders öncesi `git pull` ile yeni içeriği çek.
3. İlgili haftanın klasörünü (`weeks/week-NN`) aç ve oradaki README'yi oku.
4. SQL haftalarında örnek veritabanlarını bir kez kur: [data/README.md](data/README.md)

Her hafta klasöründe şunları bulursun:

| Dosya | Ne işe yarar |
|---|---|
| `README.md` | Haftanın özeti: konular, kazanımlar, terimler, okuma, ödev |
| `ders-notu.md` | Haftanın ders notu, örneklerle ve çalıştırılabilir sorgularla |
| `lab.md` | Laboratuvar föyü, kolaydan zora sorular |
| `odev.md` | O haftanın ödev yönergesi, varsa |
| `slides-text.md` | Slaytların metin sürümü, varsa (ekran okuyucu ve büyütme dostu) |

## Hızlı bağlantılar

- [Ders amacı, çıktılar, değerlendirme: SYLLABUS.md](SYLLABUS.md)
- [Ödevler ve teslim kuralları: ODEVLER.md](ODEVLER.md)
- [Notlandırma rubrikleri: RUBRIK.md](RUBRIK.md)
- [Şablonlar (rapor, PR, proje README): templates/](templates/README.md)
- [Örnek veritabanları ve kurulumu: data/README.md](data/README.md)
- [Kaynak kitaplar ve bağlantılar: RESOURCES.md](RESOURCES.md)
- [Kurulum rehberi: SETUP.md](SETUP.md)
- [Sözlük (English-Türkçe): GLOSSARY.md](GLOSSARY.md)

## Hafta hafta

Bu dönem ders **12 hafta** işlenir.

| Hafta | Konu | Kilometre taşı | Durum |
|---|---|---|---|
| 1 | [Algoritmik düşünme: problemden adıma](weeks/week-01/README.md) | GitHub hesabı | Yayında |
| 2 | [Döngüler ve temel algoritmalar](weeks/week-02/README.md) | - | Yayında |
| 3 | [Veritabanı temel kavramları ve mimari](weeks/week-03/README.md) | Kura ve proje reposu | Yayında |
| 4 | [Ortam kurulumu, SELECT ve WHERE](weeks/week-04/README.md) | İlk sorgular | Yayında |
| 5 | [SQL fonksiyonları ve gruplama (GROUP BY)](weeks/week-05/README.md) | **Ödev 1** | Yayında |
| 6 | [Çoklu tablo sorguları (JOIN)](weeks/week-06/README.md) | JOIN sorguları | Yayında |
| 7 | [E-R modeli ve normalizasyon](weeks/week-07/README.md) | ERD ve normalizasyon planı | Yakında |
| 8 | [Ara sınav, mini proje sunumu](weeks/week-08/README.md) | Veri hikayesi, ERD, plan | Yakında |
| 9 | [DDL: tablolar, anahtarlar ve kısıtlar](weeks/week-09/README.md) | Şema (`CREATE TABLE`) | Yakında |
| 10 | [DML, transaction ve alt sorgular](weeks/week-10/README.md) | Veriyi şemaya taşıma | Yakında |
| 11 | [Görünümler, güvenlik ve YZ bileşeni](weeks/week-11/README.md) | Görünümler, roller, YZ bileşeni | Yakında |
| 12 | [Final: jüri önünde sunumlar](weeks/week-12/README.md) | Ana proje teslimi | Yakında |

## Ödevler

Dönem boyunca **6 notlu ödev** var. Her ödev iki parça halinde teslim edilir:

1. **GitHub'da PR:** kendi reponda `odev-NN` branch'ini açar, çalışır, PR açar ve beni reviewer eklersin
2. **Kâğıt rapor:** tek sayfalık raporu teslim günündeki derste elden verirsin

**Sıradaki: [Ödev 1, ilk beş haftanın tamamı](weeks/week-05/odev.md). Son teslim 23 Ekim 2026 Cuma, ders saatinden önce.**

Ayrıntı: [ODEVLER.md](ODEVLER.md), notlandırma: [RUBRIK.md](RUBRIK.md), şablonlar: [templates/](templates/README.md)

## Sıralamanın mantığı

**Önce sorgula, sonra tasarla.** Hafta 4-6 boyunca hazır bir veritabanına soru sorarsın. Ne sorduğunu gördükten sonra, Hafta 7'de kendi modelini kurar, Hafta 9'da onu gerçek bir şemaya dönüştürürsün.

## Dil

Anlatım Türkçe, teknik terimlerin İngilizcesi parantez içinde ve her haftanın "Anahtar terimler" tablosunda. Tüm terimler [GLOSSARY.md](GLOSSARY.md) içinde toplu halde. Haftalık okuma listeleri İngilizce resmi dokümantasyona yönlendirir: sektörde çalışırken başvuracağın kaynaklar bunlar.

Kod, tablo ve sütun adları İngilizce yazılır: sektördeki repoların çoğu böyle, sen de projende böyle yap. Veri değerleri Türkçe olabilir.

## Erişilebilirlik

Her haftanın slaytları, o haftanın klasöründe **metin sürümü** olarak da yayımlanır (`slides-text.md`). Ekran okuyucuyla okunabilir, tarayıcıda büyütülebilir. Görme, işitme ya da başka bir nedenle farklı bir düzenlemeye ihtiyacın varsa derse gelmeden bana yazman yeterli, birlikte planlarız.
