CREATE TABLE mobilidade AS
SELECT moradia, total_onibus, total_auto, total_moto, total_bicicleta, total_carona, total_andando FROM public.estatisticas_por_regiao
ORDER BY total_onibus DESC 

ALTER TABLE mobilidade 
ADD COLUMN percent_onibus numeric(5,2),
ADD COLUMN percent_auto numeric(5,2),
ADD COLUMN percent_moto numeric(5,2),
ADD COLUMN percent_bicicleta numeric(5,2),
ADD COLUMN percent_carona numeric(5,2),
ADD COLUMN percent_andando numeric(5,2);

UPDATE mobilidade
SET 
    percent_onibus = CASE WHEN (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando)=0 THEN 0
                           ELSE (total_onibus::numeric / (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando))*100 END,
    percent_auto = CASE WHEN (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando)=0 THEN 0
                           ELSE (total_auto::numeric / (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando))*100 END,
    percent_moto = CASE WHEN (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando)=0 THEN 0
                           ELSE (total_moto::numeric / (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando))*100 END,
    percent_bicicleta = CASE WHEN (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando)=0 THEN 0
                           ELSE (total_bicicleta::numeric / (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando))*100 END,
    percent_carona = CASE WHEN (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando)=0 THEN 0
                           ELSE (total_carona::numeric / (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando))*100 END,
    percent_andando = CASE WHEN (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando)=0 THEN 0
                           ELSE (total_andando::numeric / (total_onibus+total_auto+total_moto+total_bicicleta+total_carona+total_andando))*100 END;
