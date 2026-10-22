# Şablonlar

Bu klasördeki dosyalar öğrenciler içindir. Kendi reponuza kopyalayıp doldurursunuz.

| Dosya | Nereye kopyalanır | Ne zaman |
|---|---|---|
| [odev-rapor-sablonu.md](odev-rapor-sablonu.md) | `odevler/odev-NN/rapor.md` | Her ödevde |
| [pull_request_template.md](pull_request_template.md) | `.github/pull_request_template.md` | Bir kez, Hafta 3'te |
| [proje-readme-sablonu.md](proje-readme-sablonu.md) | `README.md` | Bir kez, dönem boyunca doldurulur |

## Rapor şablonunu yazdırma

`odev-rapor-sablonu.md` markdown dosyasıdır. Yazdırmak için iki yol:

1. **VS Code:** dosyayı aç, `Ctrl/Cmd + Shift + V` ile önizleme, sağ tık → Print.
2. **GitHub:** dosyayı repoda aç, tarayıcıdan `Ctrl/Cmd + P`.

Elle doldurmak istersen boş haliyle yazdır, bilgisayarda doldurmak istersen önce doldur sonra yazdır. İkisi de olur.

## PR şablonu nasıl çalışır

`.github/pull_request_template.md` dosyasını reponun kök dizininde `.github` klasörüne koyarsan, her PR açtığında GitHub bu formu açıklama alanına kendiliğinden doldurur. Bir kere kurarsın, dönem boyunca işini kolaylaştırır.

```bash
mkdir -p .github
# şablonu indir veya kopyala
git add .github/pull_request_template.md
git commit -m "PR sablonu eklendi"
```
