--1.SORU
SELECT id,model_name 
FROM ll_calls;


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