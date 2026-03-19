-- =====================================
-- PROCEDURE: CRIAR NOVO ATENDIMENTO
-- =====================================

CREATE OR REPLACE PROCEDURE sp_criar_atendimento(
    p_id_cliente INT,
    p_id_atendente INT,
    p_id_prioridade INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO atendimento (
        id_cliente,
        id_atendente,
        id_prioridade,
        id_status,
        data_chegada
    )
    VALUES (
        p_id_cliente,
        p_id_atendente,
        p_id_prioridade,
        1, -- Aguardando atendimento
        CURRENT_TIMESTAMP
    );
END;
$$;

-- =====================================
-- PROCEDURE: FINALIZAR ATENDIMENTO
-- =====================================

CREATE OR REPLACE PROCEDURE sp_finalizar_atendimento(
    p_id_atendimento INT,
    p_resolvido BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE atendimento
    SET 
        id_status = 2, -- Finalizado
        data_fim = CURRENT_TIMESTAMP,
        resolvido_primeiro_contato = p_resolvido
    WHERE id = p_id_atendimento;
END;
$$;

-- =====================================
-- PROCEDURE: REGISTRAR AVALIAÇÃO
-- =====================================

CREATE OR REPLACE PROCEDURE sp_avaliar_atendimento(
    p_id_atendimento INT,
    p_nota INT,
    p_comentario TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO avaliacao (
        id_atendimento,
        nota,
        comentario,
        data_avaliacao
    )
    VALUES (
        p_id_atendimento,
        p_nota,
        p_comentario,
        CURRENT_TIMESTAMP
    );
END;
$$;

-- =====================================
-- PROCEDURE: RESGATAR RECOMPENSA
-- =====================================

CREATE OR REPLACE PROCEDURE sp_resgatar_recompensa(
    p_id_usuario INT,
    p_id_recompensa INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_pontos INT;
    v_custo INT;
    v_estoque INT;
BEGIN
    -- Busca dados
    SELECT pontos_total INTO v_pontos
    FROM pontuacao
    WHERE id_usuario = p_id_usuario;

    SELECT custo_pontos, estoque INTO v_custo, v_estoque
    FROM recompensa
    WHERE id = p_id_recompensa;

    -- Valida saldo
    IF v_pontos < v_custo THEN
        RAISE EXCEPTION 'Pontos insuficientes';
    END IF;

    -- Valida estoque
    IF v_estoque <= 0 THEN
        RAISE EXCEPTION 'Recompensa sem estoque';
    END IF;

    -- Debita pontos
    UPDATE pontuacao
    SET pontos_total = pontos_total - v_custo
    WHERE id_usuario = p_id_usuario;

    -- Atualiza estoque
    UPDATE recompensa
    SET estoque = estoque - 1
    WHERE id = p_id_recompensa;

    -- Registra resgate
    INSERT INTO resgate_recompensa (
        id_usuario,
        id_recompensa,
        pontos_gastos,
        data_resgate,
        status_resgate
    )
    VALUES (
        p_id_usuario,
        p_id_recompensa,
        v_custo,
        CURRENT_TIMESTAMP,
        'APROVADO'
    );
END;
$$;

-- =====================================
-- PROCEDURE: ATUALIZAR RANKING MENSAL
-- =====================================

CREATE OR REPLACE PROCEDURE sp_atualizar_ranking_mensal(
    p_referencia_mes VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Limpa ranking do mês
    DELETE FROM ranking_mensal
    WHERE referencia_mes = p_referencia_mes;

    -- Insere novo ranking baseado na pontuação atual
    INSERT INTO ranking_mensal (id_usuario, posicao, pontuacao_mes, referencia_mes)
    SELECT 
        id_usuario,
        RANK() OVER (ORDER BY pontos_total DESC),
        pontos_total,
        p_referencia_mes
    FROM pontuacao;
END;
$$;
