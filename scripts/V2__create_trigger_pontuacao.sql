-- =====================================
-- FUNÇÃO: ADICIONAR PONTOS AO FINALIZAR ATENDIMENTO
-- =====================================

CREATE OR REPLACE FUNCTION fn_adicionar_pontos_atendimento()
RETURNS TRIGGER AS $$
DECLARE
    v_usuario_id INT;
    v_pontos INT;
BEGIN
    -- Só executa quando o atendimento for FINALIZADO (status = 2)
    IF NEW.id_status = 2 AND OLD.id_status <> 2 THEN

        -- Busca o usuário do atendente
        SELECT id_usuario INTO v_usuario_id
        FROM atendente
        WHERE id = NEW.id_atendente;

        -- Define pontuação base
        v_pontos := 50;

        -- Bonus se resolveu no primeiro contato
        IF NEW.resolvido_primeiro_contato = TRUE THEN
            v_pontos := v_pontos + 20;
        END IF;

        -- Atualiza pontuação
        UPDATE pontuacao
        SET pontos_total = pontos_total + v_pontos,
            ultima_atualizacao = CURRENT_TIMESTAMP
        WHERE id_usuario = v_usuario_id;

        -- Atualiza nível automaticamente (exemplo simples)
        UPDATE pontuacao
        SET nivel_atual = 
            CASE
                WHEN pontos_total >= 500 THEN 5
                WHEN pontos_total >= 300 THEN 4
                WHEN pontos_total >= 150 THEN 3
                WHEN pontos_total >= 50 THEN 2
                ELSE 1
            END
        WHERE id_usuario = v_usuario_id;

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- =====================================
-- TRIGGER: DISPARA APÓS UPDATE NO ATENDIMENTO
-- =====================================

DROP TRIGGER IF EXISTS trg_adicionar_pontos ON atendimento;

CREATE TRIGGER trg_adicionar_pontos
AFTER UPDATE ON atendimento
FOR EACH ROW
EXECUTE FUNCTION fn_adicionar_pontos_atendimento();
