DROP TABLE IF EXISTS public.estatisticas_por_regiao

-- Criando a tabela com cada uma das colunas
CREATE TABLE public.estatisticas_por_regiao (
    moradia VARCHAR(50) PRIMARY KEY,
    total_ocorrencias INT,
    total_estudantes_graduacao INT,
    total_estudantes_pos_graduacao INT,
    total_servidor INT,
    total_professor INT,
    total_auto INT,
    total_moto INT,
    total_bicicleta INT,
    total_onibus INT,
    total_andando INT,
    total_carona INT
);

-- Inserindo dados na tabela por região, preenchendo cada uma das colunas criadas anteriormente
INSERT INTO public.estatisticas_por_regiao (
    moradia, 
    total_ocorrencias, 
    total_estudantes_graduacao, 
    total_estudantes_pos_graduacao, 
    total_servidor, 
    total_professor, 
    total_bicicleta, 
    total_onibus, 
    total_auto, 
    total_moto, 
    total_carona, 
    total_andando
)
SELECT
    COALESCE(ra, municipio) AS moradia,
    COUNT(*) AS total_ocorrencias,
    SUM(CASE WHEN situacao_unb = 'Estudante de Graduação' THEN 1 ELSE 0 END) AS total_estudantes_graduacao,
    SUM(CASE WHEN situacao_unb = 'Estudante de Pós-Graduação' THEN 1 ELSE 0 END) AS total_estudantes_pos_graduacao,
    SUM(CASE WHEN situacao_unb = 'Servidor' THEN 1 ELSE 0 END) AS total_servidor,
    SUM(CASE WHEN situacao_unb = 'Professor' THEN 1 ELSE 0 END) AS total_professor,
    SUM(CASE WHEN meio_transporte = 'Bicicleta' THEN 1 ELSE 0 END) AS total_bicicleta,
    SUM(CASE WHEN meio_transporte = 'Ônibus' THEN 1 ELSE 0 END) AS total_onibus,
    SUM(CASE WHEN meio_transporte = 'Automóvel' THEN 1 ELSE 0 END) AS total_auto,
    SUM(CASE WHEN meio_transporte = 'Motocicleta' THEN 1 ELSE 0 END) AS total_moto,
    SUM(CASE WHEN meio_transporte = 'Carona' THEN 1 ELSE 0 END) AS total_carona,
    SUM(CASE WHEN meio_transporte = 'A pé' THEN 1 ELSE 0 END) AS total_andando
FROM public.survey
GROUP BY COALESCE(ra, municipio);
