SELECT 
    sb.chegada,  
    p1.geom AS geom_chegada, 
    COUNT(sb.chegada) AS count
FROM 
    survey_bus sb
LEFT JOIN 
    paradas_unb p1 ON sb.chegada = p1.parada -- Conecta a parada de chegada
GROUP BY 
    sb.chegada, p1.geom; -- Agrupa pelo nome da chegada e pela geometria


-- depois, fazer o mesmo para saidas

CREATE TABLE saidas_bus AS 
SELECT 
    sb.saida,  
    p1.geom AS geom_saida, 
    COUNT(sb.chegada) AS count
FROM 
    survey_bus sb
LEFT JOIN 
    paradas_unb p1 ON sb.saida = p1.parada 
GROUP BY 
    sb.saida, p1.geom; 