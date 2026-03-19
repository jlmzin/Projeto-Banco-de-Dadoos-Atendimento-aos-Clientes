-- =====================================
-- MODULO USUARIOS
-- =====================================

CREATE TABLE IF NOT EXISTS usuario (
    id SERIAL PRIMARY KEY,
    email VARCHAR(150) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('cliente', 'atendente'))
);

CREATE TABLE IF NOT EXISTS cliente (
    id SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20),

    CONSTRAINT fk_cliente_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS atendente (
    id SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    nome VARCHAR(150) NOT NULL,
    setor VARCHAR(100) NOT NULL,
    matricula VARCHAR(50) UNIQUE NOT NULL,

    CONSTRAINT fk_atendente_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id)
        ON DELETE CASCADE
);

-- =====================================
-- MODULO ATENDIMENTO
-- =====================================

CREATE TABLE IF NOT EXISTS prioridade (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS status (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS atendimento (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_atendente INT NOT NULL,
    id_prioridade INT NOT NULL,
    id_status INT NOT NULL,
    data_chegada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_inicio TIMESTAMP,
    data_fim TIMESTAMP,
    resolvido_primeiro_contato BOOLEAN DEFAULT FALSE,

    CONSTRAINT fk_atendimento_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id),

    CONSTRAINT fk_atendimento_atendente
        FOREIGN KEY (id_atendente)
        REFERENCES atendente(id),

    CONSTRAINT fk_atendimento_prioridade
        FOREIGN KEY (id_prioridade)
        REFERENCES prioridade(id),

    CONSTRAINT fk_atendimento_status
        FOREIGN KEY (id_status)
        REFERENCES status(id)
);

CREATE TABLE IF NOT EXISTS avaliacao (
    id SERIAL PRIMARY KEY,
    id_atendimento INT NOT NULL,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_avaliacao_atendimento
        FOREIGN KEY (id_atendimento)
        REFERENCES atendimento(id)
        ON DELETE CASCADE
);

-- =====================================
-- MODULO GAMIFICACAO
-- =====================================

CREATE TABLE IF NOT EXISTS pontuacao (
    id SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    pontos_total INT DEFAULT 0 CHECK (pontos_total >= 0),
    nivel_atual INT DEFAULT 1 CHECK (nivel_atual > 0),
    ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_pontuacao_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS badge (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    pontos_necessarios INT NOT NULL CHECK (pontos_necessarios >= 0)
);

CREATE TABLE IF NOT EXISTS usuario_badge (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_badge INT NOT NULL,
    data_conquista TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_usuario_badge_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id),

    CONSTRAINT fk_usuario_badge_badge
        FOREIGN KEY (id_badge)
        REFERENCES badge(id),

    CONSTRAINT unique_usuario_badge UNIQUE (id_usuario, id_badge)
);

CREATE TABLE IF NOT EXISTS ranking_mensal (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    posicao INT,
    pontuacao_mes INT,
    referencia_mes VARCHAR(7) NOT NULL,

    CONSTRAINT fk_ranking_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id)
);

CREATE TABLE IF NOT EXISTS meta_atendente (
    id SERIAL PRIMARY KEY,
    id_atendente INT NOT NULL,
    meta_pontos INT,
    meta_atendimentos INT,
    referencia_mes VARCHAR(7) NOT NULL,

    CONSTRAINT fk_meta_atendente
        FOREIGN KEY (id_atendente)
        REFERENCES atendente(id)
);

-- =====================================
-- MODULO LOJA DE RECOMPENSAS
-- =====================================

CREATE TABLE IF NOT EXISTS recompensa (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    custo_pontos INT NOT NULL CHECK (custo_pontos > 0),
    estoque INT DEFAULT 0 CHECK (estoque >= 0),
    ativa BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS resgate_recompensa (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_recompensa INT NOT NULL,
    pontos_gastos INT NOT NULL,
    data_resgate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_resgate VARCHAR(50) DEFAULT 'PENDENTE',

    CONSTRAINT fk_resgate_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id),

    CONSTRAINT fk_resgate_recompensa
        FOREIGN KEY (id_recompensa)
        REFERENCES recompensa(id)
);
