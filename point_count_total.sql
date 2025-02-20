SELECT 
    nb.nome_p AS ponto, 
    COUNT(*) AS count_ponto_total,
    nb.geom
FROM 
    nomes_blocos nb
LEFT JOIN 
    survey_pontos sp
ON 
    nb.nome_p IN (sp.p1, sp.p2, sp.p3, sp.p4, sp.p5)
GROUP BY 
    nb.nome_p, nb.geom;

