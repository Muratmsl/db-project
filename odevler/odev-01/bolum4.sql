--1.SORU
SELECT COUNT(*) AS total_calls
FROM llm_calls;
--total_calls değikeni altında saydırıyoruz 



--2.SORU
SELECT COUNT(*) AS slow_calls
FROM llm_calls
WHERE latency_ms>2000;
--slow_calls değişkeni altında saydırıyoruz(2 saniye üstü)


--3.SORU
SELECT 
  SUM(cost_usd) AS total_cost,
  SUM(prompt_tokens + completion_tokens) AS total_tokens
FROM llm_calls;
--değişkende toplayıp kısalaştırıyoruz,sum toplama için

--4.SORU
SELECT ROUND(AVG(latency_ms)::numeric, 1) AS avg_latency
FROM llm_calls;
--avg komutu ortalama için,round yuvarlamak için kullanıyoruz.Numeric i küsürat için kullanıyoruz


--5.SORU
SELECT 
  MIN(latency_ms) AS fastest_call_ms,
  MAX(latency_ms) AS slowest_call_ms
FROM llm_calls;
--min ve max komutlarıyla tespit edip isim veriyoruz.


--6.SORU
SELECT task_type, COUNT(*) AS cagri_sayisi 
FROM llm_calls
GROUP BY task_type;
--tasktype ı saydırıp isim evrip gruplara ayırıyoruz


--7.SORU
SELECT model_name, COUNT(*) AS cagri_sayisi, SUM(cost_usd) AS toplam_maliyet
FROM  llm_calls
GROUP BY model_name
ORDER BY toplam_maliyet DESC;


--8.SORU
SELECT id, task_type, COUNT(*) AS cagri_sayisi 
FROM llm_calls
GROUP BY id, task_type;
--iki parametreyi tek başlıkta toplayıp saydırıyoruz


--9.SORU
SELECT model_name, COUNT(*) AS cagri_sayisi 
FROM llm_calls
GROUP BY model_name 
HAVING COUNT(*) > 2;
--modelname i ikiden büyük olacak şekilde gruplandırıyoruz


--10.SORU
SELECT model_name, COUNT(*) AS cagri_sayisi, AVG(latency_ms) AS ortalama_gecikme 
FROM llm_calls
WHERE latency_ms > 500 
GROUP BY model_name
HAVING COUNT(*) >= 2;
--count ile saydırdık,avg ile ortalama aldık,ms i yarım saniyeden yüksek olanları,sonra grupladık,çağrı sayısı 2 veya daha fazlaysa işleme aldık


--11.SORU
SELECT 
    COUNT(*) AS toplam_satir,
    COUNT(cost_usd) AS cost_full,
    COUNT(*) - COUNT(cost_usd) AS cost_eksik,
    COUNT(latency_ms) AS latency_full,
    COUNT(*) - COUNT(latency_ms) AS latency_eksik
FROM llm_calls;



--12.SORU
SELECT * 
FROM llm_calls 
WHERE cost_usd IS NULL;
--null ile satır gelmedi,is null ile tek satır geldi

--13.SORU
SELECT 
    AVG(cost_usd) AS emptypass,
    AVG(COALESCE(cost_usd, 0)) AS zerocount
FROM llm_calls;
--aboneliğini iptal etmiş olabilir o yüzden boş geçmek daha mantıklı


--14.SORU
SELECT 
    DATE(created_at) AS days, 
    COUNT(*) AS calls_number, 
    SUM(cost_usd) AS total_money 
FROM llm_calls 
GROUP BY DATE(created_at)
ORDER BY days;
--2026-10-16 günü 5 çağrı var fakat çağrıya göre az çünkü kullananların hepsi o gün az kullanmış


--15.SORU
SELECT 
    CASE 
        WHEN latency_ms < 1000 THEN 'fast'
        WHEN latency_ms BETWEEN 1000 AND 2499 THEN 'medium'
        WHEN latency_ms >= 2500 THEN 'slow'
        ELSE 'Bilinmiyor'
    END AS ms_categories,
    COUNT(*) AS calls_number,
    AVG(latency_ms) AS average_ms
FROM llm_calls
GROUP BY 1;
