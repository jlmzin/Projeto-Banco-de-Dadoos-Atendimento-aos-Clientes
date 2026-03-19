-- =====================================
-- VIEW: RANKING GERAL DE USUÁRIOS
-- =====================================

CREATE OR REPLACE VIEW view_ranking_geral AS
SELECT 
    u.id AS usuario_id,
    u.email,
    p.pontos_total,
    p.nivel_atual,
    RANK() OVER (ORDER BY p.pontos_total DESC) AS posicao
FROM usuario u
JOIN pontuacao p ON u.id = p.id_usuario;

-- =====================================
-- VIEW: RANKING DE ATENDENTES
-- =====================================

CREATE OR REPLACE VIEW view_ranking_atendentes AS
SELECT 
    a.id AS atendente_id,
    a.nome,
    a.setor,
    p.pontos_total,
    p.nivel_atual,
    RANK() OVER (ORDER BY p.pontos_total DESC) AS posicao
FROM atendente a
JOIN usuario u ON a.id_usuario = u.id
JOIN pontuacao p ON u.id = p.id_usuario;

-- =====================================
-- VIEW: RANKING MENSAL (BASEADO NA TABELA)
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
