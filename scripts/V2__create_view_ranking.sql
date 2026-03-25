-- =====================================
-- VIEW: RANKING GERAL
-- =====================================

CREATE OR REPLACE VIEW view_ranking_geral AS
SELECT 
    u.id AS usuario_id,
    u.email,
    COALESCE(p.pontos_total, 0) AS pontos_total,
    COALESCE(p.nivel_atual, 1) AS nivel_atual,
    RANK() OVER (ORDER BY COALESCE(p.pontos_total, 0) DESC) AS posicao
FROM usuario u
LEFT JOIN pontuacao p ON u.id = p.id_usuario;

-- =====================================
-- VIEW: RANKING ATENDENTES
-- =====================================

CREATE OR REPLACE VIEW view_ranking_atendentes AS
SELECT 
    a.id AS atendente_id,
    a.nome,
    a.setor,
    COALESCE(p.pontos_total, 0) AS pontos_total,
    COALESCE(p.nivel_atual, 1) AS nivel_atual,
    RANK() OVER (ORDER BY COALESCE(p.pontos_total, 0) DESC) AS posicao
FROM atendente a
JOIN usuario u ON a.id_usuario = u.id
LEFT JOIN pontuacao p ON u.id = p.id_usuario;

-- =====================================
-- VIEW: RANKING MENSAL
-- =====================================

CREATE OR REPLACE VIEW view_ranking_mensal AS
SELECT 
    rm.referencia_mes,
    u.email,
    rm.pontuacao_mes,
    rm.posicao
FROM ranking_mensal rm
JOIN usuario u ON rm.id_usuario = u.id
ORDER BY rm.referencia_mes, rm.posicao;

-- =====================================
-- VIEW: TOP 5 ATENDENTES
-- =====================================

CREATE OR REPLACE VIEW view_top_5_atendentes AS
SELECT *
FROM view_ranking_atendentes
ORDER BY pontos_total DESC
LIMIT 5;
