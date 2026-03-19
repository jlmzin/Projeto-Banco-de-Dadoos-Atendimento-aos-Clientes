# 📊 Modelo de Dados (ER Diagram)
```mermaid
erDiagram

    %% =========================
    %% USUÁRIOS
    %% =========================

    USUARIO {
        int id PK
        string email
        string senha
        string tipo
    }

    CLIENTE {
        int id PK
        int id_usuario FK
        string nome
        string cpf
        string telefone
    }

    ATENDENTE {
        int id PK
        int id_usuario FK
        string nome
        string setor
        string cpf
        string matricula
        string telefone
    }

    %% =========================
    %% ATENDIMENTO
    %% =========================

    PRIORIDADE {
        int id PK
        string descricao
    }

    STATUS {
        int id PK
        string descricao
    }

    ATENDIMENTO {
        int id PK
        int id_cliente FK
        int id_atendente FK
        int id_prioridade FK
        int id_status FK
        datetime data_chegada
        datetime data_inicio
        datetime data_fim
        boolean resolvido_primeiro_contato
    }

    AVALIACAO {
        int id PK
        int id_atendimento FK
        int nota
        string comentario
        datetime data_avaliacao
    }

    %% =========================
    %% GAMIFICAÇÃO
    %% =========================

    PONTUACAO {
        int id PK
        int id_usuario FK
        int pontos_total
        int nivel_atual
        datetime ultima_atualizacao
    }

    BADGE {
        int id PK
        string nome
        string descricao
        int pontos_necessarios
    }

    USUARIO_BADGE {
        int id PK
        int id_usuario FK
        int id_badge FK
        datetime data_conquista
    }

    RANKING_MENSAL {
        int id PK
        int id_usuario FK
        int posicao
        int pontuacao_mes
        string referencia_mes
    }

    META_ATENDENTE {
        int id PK
        int id_atendente FK
        int meta_pontos
        int meta_atendimentos
        string referencia_mes
    }

    %% =========================
    %% LOJA DE RECOMPENSAS
    %% =========================

    RECOMPENSA {
        int id PK
        string nome
        string descricao
        int custo_pontos
        int estoque
        boolean ativa
    }

    RESGATE_RECOMPENSA {
        int id PK
        int id_usuario FK
        int id_recompensa FK
        int pontos_gastos
        datetime data_resgate
        string status_resgate
    }

    %% =========================
    %% RELACIONAMENTOS
    %% =========================

    USUARIO ||--|| CLIENTE : possui
    USUARIO ||--|| ATENDENTE : possui

    CLIENTE ||--o{ ATENDIMENTO : solicita
    ATENDENTE ||--o{ ATENDIMENTO : realiza

    PRIORIDADE ||--o{ ATENDIMENTO : classifica
    STATUS ||--o{ ATENDIMENTO : define

    ATENDIMENTO ||--o{ AVALIACAO : recebe

    USUARIO ||--|| PONTUACAO : possui
    USUARIO ||--o{ USUARIO_BADGE : conquista
    BADGE ||--o{ USUARIO_BADGE : contem

    USUARIO ||--o{ RANKING_MENSAL : participa
    ATENDENTE ||--o{ META_ATENDENTE : possui

    RECOMPENSA ||--o{ RESGATE_RECOMPENSA : gera
    USUARIO ||--o{ RESGATE_RECOMPENSA : realiza
```

---

# 📁 `docs/regras_negocio.md`

```markdown
# 📜 Regras de Negócio

## 👤 Usuários
- Um usuário pode ser cliente ou atendente
- Cada cliente e atendente está vinculado a um usuário

## 📞 Atendimento
- Um cliente pode abrir vários atendimentos
- Um atendimento possui apenas um atendente
- Todo atendimento possui prioridade e status
- O fluxo padrão:
  - Aguardando
  - Em atendimento
  - Finalizado

## ⭐ Avaliação
- Um atendimento pode receber uma avaliação
- A nota varia de 1 a 5

## 🏆 Gamificação
- Atendentes recebem pontos ao finalizar atendimentos
- Recebem bônus ao resolver no primeiro contato
- Pontos acumulados definem o nível do usuário

## 🎖️ Badges
- Usuários podem conquistar badges conforme pontuação

## 📊 Ranking
- Ranking é baseado na pontuação total
- Atualizado mensalmente via procedure

## 🎁 Recompensas
- Usuários podem trocar pontos por recompensas
- O sistema valida:
  - Saldo de pontos
  - Disponibilidade em estoque
