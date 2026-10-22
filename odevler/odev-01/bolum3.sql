--1.SORU
SELECT id,model_name 
FROM ll_calls;
--id ve modelname i bul

--2.SORU
SELECT 
    model_name AS model, 
    (prompt_tokens + completion_tokens) AS total_tokens
FROM llm_calls;
--türkçe isimlendirilmiş ve llm callstan almış


--3.SORU
SELECT *
FROM llm_calls
WHERE latency_ms > 2000;
--2 saniyeyi aşan çağrıları bul

--4.SORU4 
SELECT * 
FROM llm_calls
WHERE user_name ='Ece';
--ecenin çağrıları

--5.SORU
SELECT *
FROM llm_calls
WHERE task_type != 'chat';
--chat olmayan çağrılar


--6.SORU
SELECT *
FROM llm_calls
WHERE model_name LIKE 'claude%' AND latency_ms > 1000;
--Claude ile başlayan ve 1 saniyeden uzun olanlar(% işareti ne yazarsa yazsın demek)


--7.SORU
SELECT *
FROM llm_calls
WHERE (task_type = 'code' OR task_type = 'translate') 
  AND cost_usd > 0.01;
--OR ikisinden biri olack veya ikisi de an ve demek

--8.SORU
SELECT *
FROM llm_calls
WHERE latency_ms BETWEEN 500 AND 1500;
--500 ila 1500 arsında gecikenler

--9.SORU
SELECT *
FROM llm_calls
WHERE model_name IN('gpt-4o','gpt-4o-mini');
--seçili parametre getirme


--10.SORU
SELECT *
FROM llm_calls
WHERE model_name LIKE '%mini%';
--herhangi yerde mini yazıyorsa getir(model_name)


--11.SORU
SELECT *
FROM llm_calls
ORDER BY user_name ASC, cost_usd DESC;
--her isme ayrı olarak sıralama

--12.SORU
SELECT *
FROM llm_calls
WHERE cost_usd IS NOT NULL
ORDER BY cost_usd DESC
LIMIT 3;
--null olanlar dahil edilmeden sıralanıyor


--13.SORU
SELECT DISTINCT task_type
FROM llm_calls;
--task_type türleri


--14.SORU
SELECT DISTINCT user_name COLLATE "tr-TR-x-icu" AS user_name
FROM llm_calls
ORDER BY user_name;
--Varsayılan karakter kümesi UTF-8(türkçe) olduğu için birşey fark etmedi


--15.SORU
SELECT id,model_name,latency_ms
FROM llm_calls
WHERE created_at > '2026-10-14' AND latency_ms > 1000
ORDER BY latency_ms DESC;
--14ünden sonra ve 1 saniyeden yavaş