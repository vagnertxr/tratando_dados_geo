CREATE TABLE linhas_circulacao AS
WITH pontos_geom AS (
    SELECT
        sp.*,
        nb1.geom AS geom_p1,
        nb2.geom AS geom_p2,
        nb3.geom AS geom_p3,
        nb4.geom AS geom_p4,
        nb5.geom AS geom_p5
    FROM survey_pontos sp
    LEFT JOIN nomes_blocos nb1 ON sp.p1 = nb1.nome_p
    LEFT JOIN nomes_blocos nb2 ON sp.p2 = nb2.nome_p
    LEFT JOIN nomes_blocos nb3 ON sp.p3 = nb3.nome_p
    LEFT JOIN nomes_blocos nb4 ON sp.p4 = nb4.nome_p
    LEFT JOIN nomes_blocos nb5 ON sp.p5 = nb5.nome_p
)
SELECT
    sp.*,
    CASE
        WHEN geom_p1 IS NOT NULL AND geom_p2 IS NOT NULL THEN ST_MakeLine(ARRAY[geom_p1, geom_p2, geom_p3, geom_p4, geom_p5])
        ELSE NULL
    END AS linha_tracada
FROM pontos_geom sp
WHERE geom_p1 IS NOT NULL;
