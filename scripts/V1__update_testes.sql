-- =====================================
-- TESTES DE UPDATE (REGRAS DE NEGÓCIO)
-- =====================================

-- 1. ATUALIZAR STATUS DO ATENDIMENTO (Simula progresso)
UPDATE atendimento
SET id_status = 3, -- Em atendimento
    data_inicio = CURRENT_TIMESTAMP
WHERE id = 1;

-- Finalizando atendimento
UPDATE atendimento
SET id_status = 2, -- Finalizado
    data_fim = CURRENT_TIMESTAMP,
    resolvido_primeiro_contato = TRUE
WHERE id = 1;

-- =====================================
-- 2. ATUALIZAR PONTUAÇÃO (GAMIFICAÇÃO)
-- =====================================

-- Adiciona pontos para o atendente após atendimento finalizado
UPDATE pontuacao
SET pontos_total = pontos_total + 50,
    ultima_atualizacao = CURRENT_TIMESTAMP
WHERE id_usuario = 2;

-- Atualiza nível baseado em pontos
UPDATE pontuacao
SET nivel_atual = 2
WHERE pontos_total >= 100;

-- =====================================
-- 3. ATUALIZAR DADOS DO CLIENTE
-- =====================================

UPDATE cliente
SET telefone = '11999990000'
WHERE id = 1;

-- =====================================
-- 4. ATUALIZAR SETOR DO ATENDENTE
-- =====================================

UPDATE atendente
SET setor = 'Suporte Avançado'
WHERE id = 1;

-- =====================================
-- 5. ATUALIZAR ESTOQUE DE RECOMPENSA
-- =====================================

UPDATE recompensa
SET estoque = estoque - 1
WHERE id = 1;

-- =====================================
-- 6. ATUALIZAR STATUS DE RESGATE
-- =====================================

UPDATE resgate_recompensa
SET status_resgate = 'APROVADO'
WHERE id = 1;

-- =====================================
-- 7. ATUALIZAR RANKING MENSAL
-- =====================================

UPDATE ranking_mensal
SET posicao = 1
WHERE id_usuario = 2
AND referencia_mes = '2024-03';

-- =====================================
-- 8. SIMULAÇÃO DE CORREÇÃO DE AVALIAÇÃO
-- =====================================

UPDATE avaliacao
SET nota = 5,
    comentario = 'Atendimento corrigido e excelente'
WHERE id = 1;
