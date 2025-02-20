-- Ativar suporte a chaves estrangeiras
PRAGMA foreign_keys = ON;

-- Tabela de usuários: Armazena informações dos usuários cadastrados
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de avaliações: Armazena as notas e críticas dos usuários sobre os filmes
CREATE TABLE IF NOT EXISTS avaliacoes (
    id_avaliacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme_tmdb INTEGER NOT NULL,  -- ID do filme no TMDb
    nota INTEGER CHECK (nota BETWEEN 1 AND 5),
    critica TEXT,
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabela de favoritos: Lista os filmes favoritos dos usuários
CREATE TABLE IF NOT EXISTS favoritos (
    id_usuario INTEGER,
    id_filme_tmdb INTEGER NOT NULL,  -- ID do filme no TMDb
    data_favorito TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    PRIMARY KEY (id_usuario, id_filme_tmdb)
);

-- Tabela de histórico de visualização: Registra os filmes assistidos pelos usuários
CREATE TABLE IF NOT EXISTS historico_visualizacao (
    id_usuario INTEGER,
    id_filme_tmdb INTEGER NOT NULL,  -- ID do filme no TMDb
    data_visualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    PRIMARY KEY (id_usuario, id_filme_tmdb)
);

-- Tabela de preferências do usuário: Armazena os gêneros favoritos e filtros de recomendação
CREATE TABLE IF NOT EXISTS preferencias_usuario (
    id_usuario INTEGER PRIMARY KEY,
    generos_preferidos TEXT, -- Lista de IDs de gêneros do TMDb (ex: "28,12,16")
    ano_preferido INTEGER,
    nota_minima INTEGER CHECK (nota_minima BETWEEN 1 AND 5),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabela de recomendações: Filmes recomendados para os usuários
CREATE TABLE IF NOT EXISTS recomendacoes (
    id_usuario INTEGER,
    id_filme_tmdb INTEGER NOT NULL,  -- ID do filme no TMDb
    razao TEXT,  -- Exemplo: "Baseado no seu histórico", "Baseado nos seus favoritos"
    data_recomendacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    PRIMARY KEY (id_usuario, id_filme_tmdb)
);
