CREATE TABLE segmentos AS
WITH pontos AS (
    -- Desmembrando cada linha em seus pontos
    SELECT 
        id, -- Supondo que você tenha uma coluna 'id' identificando cada linha
        (ST_DumpPoints(linha_tracada)).geom AS ponto, -- Extraindo os pontos da linha
        row_number() OVER (PARTITION BY id ORDER BY (ST_DumpPoints(linha_tracada)).path) AS ponto_num -- Numerando os pontos
    FROM 
        linhas_circulacao
),
segmentos AS (
    -- Conectando cada par de pontos consecutivos em uma linha (segmento)
    SELECT 
        p1.id,
        ST_MakeLine(p1.ponto, p2.ponto) AS geom_segmento -- Criando o segmento de linha entre 2 pontos
    FROM 
        pontos p1
    JOIN 
        pontos p2
    ON 
        p1.id = p2.id
    AND 
        p1.ponto_num + 1 = p2.ponto_num -- Conecta pontos consecutivos
)
-- Criar uma nova tabela com os segmentos
SELECT 
    geom_segmento,
    COUNT(*) AS count_segmentos -- Contagem de quantas vezes cada segmento aparece
FROM 
    segmentos
GROUP BY 
    geom_segmento;