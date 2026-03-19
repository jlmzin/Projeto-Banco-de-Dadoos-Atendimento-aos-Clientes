# SGA Gamificado
# 🎮 SGA Gamificado
🎮 SGA GAMIFICADO + LOJA DE RECOMPENSAS
📌 Tema do Projeto

O projeto propõe o desenvolvimento de um Sistema de Gestão de Atendimento (SGA) com Gamificação e Loja de Recompensas, modelado por meio de diagrama ER utilizando a linguagem Mermaid.

A proposta integra conceitos de Engenharia de Software, Banco de Dados e Gamificação, aplicando mecânicas de jogos em um sistema corporativo de atendimento.

🎯 Objetivo Geral

Desenvolver um modelo estruturado de Sistema de Gestão de Atendimento que utilize elementos de gamificação — como pontos, níveis, badges, ranking e metas — além de uma loja de recompensas integrada, com o objetivo de:

Aumentar o engajamento dos atendentes

Incentivar a melhoria da qualidade do atendimento

Estimular a participação ativa dos clientes

Criar um ambiente organizacional mais motivador e produtivo

💡 Justificativa

Sistemas tradicionais de atendimento costumam ser operacionais e pouco motivadores.
Ao integrar gamificação e recompensas, o sistema passa a:

Estimular desempenho

Promover reconhecimento

Criar competição saudável

Melhorar indicadores de satisfação

🧩 Diferencial do Projeto

O sistema inclui:

Controle de usuários (cliente e atendente)

Gestão completa de atendimentos

Sistema de pontuação e níveis

Badges (conquistas)

Ranking mensal

Metas para atendentes

Loja de recompensas com controle de estoque

Histórico de resgates

Modelo relacional estruturado em Mermaid

🚀 Resultado Esperado

Espera-se que o modelo proposto demonstre como a gamificação pode ser aplicada de forma estruturada em ambientes corporativos, promovendo melhoria contínua, engajamento e eficiência operacional.
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
