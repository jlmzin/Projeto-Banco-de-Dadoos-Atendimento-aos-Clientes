-- =====================================
-- SERVIDORES (SETORES / UNIDADES)
-- =====================================

INSERT INTO public.servidor (id, nome, meta) VALUES 
(1, 'Suporte Técnico', 1000),
(2, 'Financeiro', 800),
(3, 'Atendimento Geral (SAC)', 1200)
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- STATUS
-- =====================================

INSERT INTO public.status (id, descricao) VALUES 
(1, 'Aguardando atendimento'),
(2, 'Finalizado'),
(3, 'Em atendimento')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- PRIORIDADE
-- =====================================

INSERT INTO public.prioridade (id, descricao) VALUES 
(1, 'Baixa'),
(2, 'Média'),
(3, 'Alta')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- SEXO
-- =====================================

INSERT INTO public.sexo (id, sexo) VALUES 
(1, 'Masculino'),
(2, 'Feminino'),
(3, 'Não informado')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- PRÊMIOS (GAMIFICAÇÃO)
-- =====================================

INSERT INTO public.premio (id, premio) VALUES 
(1, 'Vale-refeição R$100'),
(2, 'Day Off'),
(3, 'Voucher Amazon R$200')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- PESSOAS (CLIENTES E ATENDENTES)
-- =====================================

INSERT INTO public.pessoa 
(id, nome, id_sexo, cpf, telefone, email, data_nascimento, id_servidor) 
VALUES 
(1, 'João Carlos Silva', 1, '12345678901', '11987654321', 'joao.silva@email.com', '1995-06-15', 3),
(2, 'Maria Fernanda Souza', 2, '23456789012', '11976543210', 'maria.souza@email.com', '1992-03-22', 3),
(3, 'Lucas Oliveira Santos', 1, '34567890123', '11965432109', 'lucas.santos@email.com', '2000-01-10', 3),
(4, 'Ana Paula Costa', 2, '45678901234', '11954321098', 'ana.costa@empresa.com', '1988-09-05', 1),
(5, 'Carlos Henrique Alves', 1, '56789012345', '11943210987', 'carlos.alves@empresa.com', '1985-12-11', 1),
(6, 'Fernanda Lima Rocha', 2, '67890123456', '11932109876', 'fernanda.rocha@empresa.com', '1990-07-30', 2)
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- ATENDENTES
-- =====================================

INSERT INTO public.atendentes 
(id, id_pessoa, cargo, data_inicio, data_fim) 
VALUES 
(1, 4, 'Analista de Suporte', '2021-02-01', NULL),
(2, 5, 'Especialista em TI', '2020-08-15', NULL),
(3, 6, 'Analista Financeiro', '2022-01-10', NULL)
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- ATENDIMENTOS
-- =====================================

INSERT INTO public.atendimento 
(id, id_pessoa, id_atendente, id_status, id_prioridade, data_chegada, data_inicio, data_fim) 
VALUES 
(1, 1, 1, 2, 3, '2024-03-10 09:00', '2024-03-10 09:05', '2024-03-10 09:30'),
(2, 2, 2, 3, 2, '2024-03-11 10:15', '2024-03-11 10:20', NULL),
(3, 3, 3, 1, 1, '2024-03-12 14:00', NULL, NULL)
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- AVALIAÇÕES
-- =====================================

INSERT INTO public.avaliacao 
(id, id_atendimento, nota, observacoes) 
VALUES 
(1, 1, 5, 'Atendimento rápido e resolveu meu problema.'),
(2, 2, 4, 'Bom atendimento, mas demorou um pouco.')
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- METAS BATIDAS
-- =====================================

INSERT INTO public.metas_batidas 
(id, meta_batida, data_batida, id_premio, id_atendente) 
VALUES 
(1, 'Meta mensal de atendimentos atingida', '2024-03-01', 2, 1),
(2, 'Maior pontuação do mês', '2024-03-01', 3, 2)
ON CONFLICT (id) DO NOTHING;

-- =====================================
-- LOJA DE RECOMPENSAS
-- =====================================

INSERT INTO public.loja 
(id, id_premio, preco_recompensa, quantidade, id_atendente, data_retirada, data_adicao) 
VALUES 
(1, 1, 500.0, 20, NULL, NULL, '2024-01-01'),
(2, 2, 1000.0, 10, 1, '2024-03-12', '2024-01-01'),
(3, 3, 1500.0, 5, NULL, NULL, '2024-01-01')
ON CONFLICT (id) DO NOTHING;

