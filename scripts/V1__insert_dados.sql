-- =====================================
-- USUARIOS
-- =====================================

INSERT INTO usuario (id, email, senha, tipo) VALUES
(1, 'cliente@email.com', '123', 'cliente'),
(2, 'atendente@email.com', '123', 'atendente')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- CLIENTE
-- =====================================

INSERT INTO cliente (id, id_usuario, nome, cpf, telefone) VALUES
(1, 1, 'João Silva', '123.456.789-00', '11999999999')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- ATENDENTE
-- =====================================

INSERT INTO atendente (id, id_usuario, nome, setor, matricula) VALUES
(1, 2, 'Maria Souza', 'Suporte', 'MAT001')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- STATUS
-- =====================================

INSERT INTO status (id, descricao) VALUES
(1, 'Aguardando atendimento'),
(2, 'Finalizado'),
(3, 'Em atendimento')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- PRIORIDADE
-- =====================================

INSERT INTO prioridade (id, descricao) VALUES
(1, 'Baixa'),
(2, 'Média'),
(3, 'Alta')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- ATENDIMENTO
-- =====================================

INSERT INTO atendimento 
(id, id_cliente, id_atendente, id_prioridade, id_status, data_chegada)
VALUES
(1, 1, 1, 2, 1, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- AVALIACAO
-- =====================================

INSERT INTO avaliacao (id, id_atendimento, nota, comentario)
VALUES
(1, 1, 5, 'Ótimo atendimento')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- PONTUACAO
-- =====================================

INSERT INTO pontuacao (id, id_usuario, pontos_total, nivel_atual)
VALUES
(1, 2, 100, 1)
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- BADGES
-- =====================================

INSERT INTO badge (id, nome, descricao, pontos_necessarios)
VALUES
(1, 'Iniciante', 'Primeiros passos', 50)
ON CONFLICT (id) DO NOTHING;

INSERT INTO usuario_badge (id_usuario, id_badge)
VALUES
(2, 1)
ON CONFLICT DO NOTHING;

-- =====================================
-- RECOMPENSAS
-- =====================================

INSERT INTO recompensa (id, nome, descricao, custo_pontos, estoque)
VALUES
(1, 'Vale R$100', 'Vale alimentação', 100, 10)
ON CONFLICT (id) DO NOTHING;
