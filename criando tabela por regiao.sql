-- Criando a tabela com cada uma das colunas
CREATE TABLE arcgis.estatisticas_por_regiao (
    localmoradia VARCHAR(50) PRIMARY KEY,
    total_ocorrencias INT,
    total_estudantes_graduacao INT,
    total_estudantes_pos_graduacao INT,
    total_auto INT,
    total_moto INT,
    total_bicicleta INT,
    total_onibus INT,
    total_andando INT,
    total_carona INT
);

-- Inserindo dados na tabela por região, preenchendo cada uma das colunas criadas anteriormente
INSERT INTO arcgis.estatisticas_por_regiao (localmoradia, total_ocorrencias, total_estudantes_graduacao, total_estudantes_pos_graduacao, total_bicicleta, total_onibus, total_auto, total_moto, total_carona, total_andando)
SELECT
    COALESCE(ra_moradia, mun_moradia) AS localmoradia,
    COUNT(*) AS total_ocorrencias,
    SUM(CASE WHEN situacao_unb = 'Estudante de Graduacao' THEN 1 ELSE 0 END) AS total_estudantes_graduacao,
    SUM(CASE WHEN situacao_unb = 'Estudante de Pos-Graduacao' THEN 1 ELSE 0 END) AS total_estudantes_pos_graduacao,
    SUM(CASE WHEN meio_transporte = 'Bicicleta' THEN 1 ELSE 0 END) AS total_bicicleta,
    SUM(CASE WHEN meio_transporte = 'Onibus' THEN 1 ELSE 0 END) AS total_onibus,
    SUM(CASE WHEN meio_transporte = 'Automovel' THEN 1 ELSE 0 END) AS total_auto,
    SUM(CASE WHEN meio_transporte = 'Motocicleta' THEN 1 ELSE 0 END) AS total_moto,
    SUM(CASE WHEN outro_meio = 'Carona' THEN 1 ELSE 0 END) AS total_carona,
    SUM(CASE WHEN outro_meio = 'Andando' THEN 1 ELSE 0 END) AS total_andando

FROM arcgis.dadospreliminares
GROUP BY COALESCE(ra_moradia, mun_moradia);