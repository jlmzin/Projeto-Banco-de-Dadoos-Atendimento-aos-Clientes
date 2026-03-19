-- =====================================
-- TESTES DE DELETE (INTEGRIDADE E CASCATA)
-- =====================================

-- 1. DELETAR AVALIAÇÃO (DEPENDENTE DE ATENDIMENTO)
-- Deve funcionar normalmente
DELETE FROM avaliacao
WHERE id = 1;

-- =====================================
-- 2. DELETAR ATENDIMENTO
-- Deve apagar normalmente, pois avaliação já foi removida
DELETE FROM atendimento
WHERE id = 1;

-- =====================================
-- 3. DELETAR RESGATE DE RECOMPENSA
DELETE FROM resgate_recompensa
WHERE id = 1;

-- =====================================
-- 4. DELETAR RECOMPENSA (SE NÃO ESTIVER EM USO)
DELETE FROM recompensa
WHERE id = 1;

-- =====================================
-- 5. TESTE DE CASCADE (USUARIO → CLIENTE / ATENDENTE)
-- Ao deletar usuário, cliente/atendente relacionado será removido automaticamente
DELETE FROM usuario
WHERE id = 1;

-- =====================================
-- 6. DELETAR BADGE DE USUÁRIO
DELETE FROM usuario_badge
WHERE id = 1;

-- =====================================
-- 7. DELETAR REGISTRO DE PONTUAÇÃO
DELETE FROM pontuacao
WHERE id_usuario = 2;

-- =====================================
-- 8. DELETAR RANKING MENSAL
DELETE FROM ranking_mensal
WHERE referencia_mes = '2024-03';

-- =====================================
-- 9. DELETAR META DO ATENDENTE
DELETE FROM meta_atendente
WHERE id_atendente = 1;

-- =====================================
-- 10. TESTE CONTROLADO (EVITAR ERRO DE FK)
-- Primeiro remove dependências, depois o atendente

DELETE FROM atendimento
WHERE id_atendente = 2;

DELETE FROM meta_atendente
WHERE id_atendente = 2;

DELETE FROM atendente
WHERE id = 2;

-- =====================================
-- 11. TESTE FINAL - LIMPEZA DE CLIENTE
DELETE FROM cliente
WHERE id = 1;
