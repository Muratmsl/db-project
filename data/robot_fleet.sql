-- =====================================================================
-- robot_fleet — Robotik ve Yapay Zeka programı için örnek veritabanı
-- BLP 105 / BLP 1005 Veritabanı Yönetim Sistemleri
--
-- Kurulum:  psql -d robot_fleet -f robot_fleet.sql
-- Bu dosya her çalıştırıldığında tabloları sıfırlar ve baştan doldurur.
-- Veriler kurgusaldır, gerçek bir filodan alınmamıştır.
--
-- Tablo ve sütun adları İngilizce ve snake_case (sektör standardı).
-- Veri değerleri Türkçedir: Hafta 4'teki sıralama (COLLATE) dersi
-- Türkçe karakterlere ihtiyaç duyar.
-- =====================================================================

DROP TABLE IF EXISTS missions;
DROP TABLE IF EXISTS robots;
DROP TABLE IF EXISTS operators;

-- Operatörler.
-- Birincil anahtar olarak doğrudan ismi kullanıyoruz (natural key).
-- Hafta 6'da JOIN öğrenirken bu basitlik işimizi kolaylaştırır.
-- Hafta 7'de bunun neden riskli olduğunu tartışacağız: aynı isimde ikinci
-- bir operatör işe alınırsa bu tasarım çöker, yapay bir id (surrogate key) gerekir.
CREATE TABLE operators (
  operator_name text PRIMARY KEY,
  phone         text,
  shift         text,
  hired_at      date
);

CREATE TABLE robots (
  id            integer PRIMARY KEY,
  name          text,
  model         text,
  status        text,
  battery_level integer,
  zone          text,
  operator_name text
);

CREATE TABLE missions (
  id           integer PRIMARY KEY,
  robot_id     integer REFERENCES robots(id),
  mission_type text,
  status       text,
  started_at   timestamptz,
  duration_min integer
);

INSERT INTO operators (operator_name, phone, shift, hired_at) VALUES
  ('Zeynep', '0532 000 0001', 'gündüz', '2024-03-11'),
  ('Can',    '0532 000 0002', 'gece',   '2024-09-02'),
  ('Çağla',  '0532 000 0003', 'gündüz', '2025-01-20'),
  ('Ahmet',  '0532 000 0004', 'gündüz', '2023-11-06'),
  ('Şule',   '0532 000 0005', 'gece',   '2025-04-14'),
  ('Büşra',  '0532 000 0006', 'gündüz', '2025-06-30'),
  ('İsmail', '0532 000 0007', 'gece',   '2024-02-19'),
  ('Deniz',  '0532 000 0008', 'gündüz', '2025-08-25'),
  ('Emre',   '0532 000 0009', 'gece',   '2026-01-12'),
  ('Kerem',  '0532 000 0010', 'gündüz', '2026-10-01');  -- yeni başladı, robotu yok

-- Dikkat: Mars-03'ün bölgesi ve operatörü boş (NULL), Kartal-04'ün bataryası boş.
-- Bu boşluklar Hafta 5'teki NULL konusunun örnekleridir, veri hatası değildir.
INSERT INTO robots (id, name, model, status, battery_level, zone, operator_name) VALUES
  (1,  'Atlas-01',  'AMR-200', 'active',      82,   'Depo A',   'Zeynep'),
  (2,  'Atlas-02',  'AMR-200', 'charging',    15,   'Şarj',     'Can'),
  (3,  'Kartal-01', 'DRN-X1',  'active',      18,   'Dış Alan', 'Çağla'),
  (4,  'Kartal-02', 'DRN-X1',  'maintenance', 64,   'Atölye',   'Ahmet'),
  (5,  'Mars-01',   'AMR-300', 'active',      47,   'Depo B',   'Şule'),
  (6,  'Mars-02',   'AMR-300', 'active',       9,   'Depo B',   'Büşra'),
  (7,  'Atlas-03',  'AMR-200', 'offline',      0,   'Depo A',   'İsmail'),
  (8,  'Kartal-03', 'DRN-X1',  'active',      91,   'Dış Alan', 'Deniz'),
  (9,  'Mars-03',   'AMR-300', 'active',      55,   NULL,       NULL),
  (10, 'Kartal-04', 'DRN-X1',  'charging',    NULL, 'Şarj',     'Emre');

-- Görevler. 4, 7, 9 ve 10 numaralı robotların hiç görevi yok:
-- Hafta 6'da "hiç görev almamış robotlar" sorusu için LEFT JOIN örneği.
INSERT INTO missions (id, robot_id, mission_type, status, started_at, duration_min) VALUES
  (1,  1, 'taşıma', 'completed',   '2026-10-12 08:30+03', 45),
  (2,  1, 'sayım',  'completed',   '2026-10-13 09:15+03', 90),
  (3,  1, 'taşıma', 'failed',      '2026-10-15 14:00+03', 12),
  (4,  2, 'taşıma', 'completed',   '2026-10-12 10:00+03', 60),
  (5,  3, 'keşif',  'completed',   '2026-10-13 07:45+03', 35),
  (6,  3, 'keşif',  'failed',      '2026-10-14 16:30+03', 8),
  (7,  3, 'keşif',  'in_progress', '2026-10-16 09:00+03', NULL),
  (8,  5, 'sayım',  'completed',   '2026-10-11 11:20+03', 120),
  (9,  5, 'taşıma', 'completed',   '2026-10-14 13:10+03', 55),
  (10, 6, 'taşıma', 'failed',      '2026-10-15 08:05+03', 20),
  (11, 6, 'taşıma', 'completed',   '2026-10-16 07:30+03', 40),
  (12, 8, 'keşif',  'completed',   '2026-10-10 06:50+03', 75),
  (13, 8, 'keşif',  'completed',   '2026-10-14 06:40+03', 80),
  (14, 8, 'sayım',  'in_progress', '2026-10-16 10:30+03', NULL);
