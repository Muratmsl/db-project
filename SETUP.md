# Kurulum Rehberi

Hedef: GitHub hesabın hazır olsun, bilgisayarında (ya da Codespaces üzerinde) ilk SQL sorgunu çalıştırasın ve ilk commit'in GitHub'da olsun. Takılırsan 5 dakikadan fazla uğraşma, lab saatinde birlikte çözelim.

## 1. GitHub hesabı

1. github.com'da hesap aç. Özgeçmişe yazabileceğin bir kullanıcı adı seç.
2. E-postanı doğrula.
3. İki adımlı doğrulamayı (2FA) aç: Settings, Password and authentication. Kurtarma kodlarını güvenli bir yere kaydet.
4. Şifreni kimseyle paylaşma, benimle de. Senden hiçbir zaman şifre istemeyeceğim.

## 2. Çalışma ortamı

Ana ortamımız GitHub Codespaces: tarayıcıda açılır, kurulum gerektirmez, Hafta 4'te kullanmaya başlayacağız. Kendi bilgisayarında da çalışmak istersen aşağıdakileri kur.

| Program | Nereden | Not |
|---|---|---|
| Git | https://git-scm.com/downloads | |
| VS Code | https://code.visualstudio.com/ | |
| PostgreSQL | https://www.postgresql.org/download/ | Windows ve macOS paketi `psql` ve pgAdmin ile birlikte gelir. Kurulumda belirlediğin şifreyi unutma ve kimseyle paylaşma |
| VS Code PostgreSQL eklentisi | Extensions, "PostgreSQL" (Microsoft) | |
| VS Code Mermaid önizleme | Extensions, "Markdown Preview Mermaid Support" | ERD çizimleri için |
| Python 3 (isteğe bağlı) | https://www.python.org/downloads/ | |

## 3. İlk sorgu

Codespaces'te ya da kendi kurulumunda, `psql` ile bağlan ve dene:

```sql
SELECT version();
```

PostgreSQL sürümünü döndürmeli. SQL komutları `;` ile biter. `\` ile başlayan psql komutları `;` istemez:

| Komut | Ne yapar |
|---|---|
| `\l` | Veritabanlarını listeler |
| `\c veritabani_adi` | Veritabanına bağlanır |
| `\dt` | Tabloları listeler |
| `\d tablo_adi` | Bir tablonun yapısını gösterir |
| `\q` | psql'den çıkar |

## 4. Kendi proje reponu oluştur (Hafta 3)

Bu hafta hiçbir şey kurmuyoruz, her şey tarayıcıda, github.com üzerinde.

1. [Proje şablonunu](https://github.com/gizemturker/project-template) aç, sağ üstteki yeşil **Use this template**, **Create a new repository**.
2. Owner: kendi kullanıcı adın. Repository name: şimdilik `db-project` yaz, kuradan sonra değiştireceğiz. Public seç (portfolyo için herkese açık olması gerekir, gizli tutmak istersen Private seçip beni collaborator olarak ekle).
3. Repoda `SCENARIO.md` dosyasına tıkla, sağ üstteki kalem ikonu (Edit this file), kura sonucunu ve ilk cevaplarını yaz, Commit changes.
4. Repo adını Settings, Repository name üzerinden projeni anlatan İngilizce bir adla değiştir: `smart-farm-drone-db`, `hospital-chatbot-logs` gibi. Eski link otomatik yenisine yönlenir.
5. `lab-sheets/week-03.md` dosyasını doldur ve commit et.

İyi bir commit mesajı: `Week 3: scenario card`, kötü bir commit mesajı: `update` ya da `son hali`.

## Sorun giderme

| Belirti | Olası neden |
|---|---|
| `psql` bulunamadı | PATH eklenmemiş ya da terminal yeniden açılmamış |
| `connection refused` | PostgreSQL servisi çalışmıyor |
| `git push` şifre istiyor | GitHub kimlik doğrulaması tamamlanmamış, `gh auth login` dene |
| Commit'te "Please tell me who you are" | `git config user.name` ve `git config user.email` ayarlanmamış |
| Komut yanıt vermiyor, istem değişti | Noktalı virgül unutulmuş, `;` yazıp Enter'a bas |

Takıldığında önce hata mesajını oku, sonra ekran görüntüsüyle birlikte bu repoda bir Issue aç.
