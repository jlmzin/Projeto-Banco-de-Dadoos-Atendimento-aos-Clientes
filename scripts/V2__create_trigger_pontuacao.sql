-- =====================================
-- FUNÇÃO: ADICIONAR PONTOS AO FINALIZAR ATENDIMENTO
-- =====================================

CREATE OR REPLACE FUNCTION fn_adicionar_pontos_atendimento()
RETURNS TRIGGER AS $$
DECLARE
    v_usuario_id INT;
    v_pontos INT;
BEGIN
    -- Só executa quando finaliza
    IF NEW.id_status = 2 AND OLD.id_status <> 2 THEN

        -- Busca usuário do atendente
        SELECT id_usuario INTO v_usuario_id
        FROM atendente
        WHERE id = NEW.id_atendente;

        -- Pontuação base
        v_pontos := 50;

        -- Bonus
        IF NEW.resolvido_primeiro_contato THEN
            v_pontos := v_pontos + 20;
        END IF;

        -- Garante que exista pontuação
        INSERT INTO pontuacao (id_usuario, pontos_total, nivel_atual)
        VALUES (v_usuario_id, 0, 1)
        ON CONFLICT (id_usuario) DO NOTHING;

        -- Atualiza pontos + nível em UMA operação
        UPDATE pontuacao
        SET 
            pontos_total = pontos_total + v_pontos,
            nivel_atual = CASE
                WHEN pontos_total + v_pontos >= 500 THEN 5
                WHEN pontos_total + v_pontos >= 300 THEN 4
                WHEN pontos_total + v_pontos >= 150 THEN 3
                WHEN pontos_total + v_pontos >= 50 THEN 2
                ELSE 1
            END,
            ultima_atualizacao = CURRENT_TIMESTAMP
        WHERE id_usuario = v_usuario_id;

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- =====================================
-- TRIGGER
-- =====================================

DROP TRIGGER IF EXISTS trg_adicionar_pontos ON atendimento;

CREATE TRIGGER trg_adicionar_pontos
AFTER UPDATE ON atendimento
FOR EACH ROW
EXECUTE FUNCTION fn_adicionar_pontos_atendimento();
