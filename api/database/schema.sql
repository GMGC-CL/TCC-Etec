-- Ativar suporte a chaves estrangeiras
PRAGMA foreign_keys = ON;
PRAGMA encoding = 'UTF-8';

-- Tabela de usuários: Armazena informações dos usuários cadastrados
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL,
    admin INTEGER DEFAULT 0 CHECK (admin IN (0,1)),
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

-- Tabela de preferências do usuário: Armazena filtros de recomendação
CREATE TABLE IF NOT EXISTS preferencias_usuario (
    id_usuario INTEGER PRIMARY KEY,
    ano_preferido INTEGER,
    nota_minima INTEGER CHECK (nota_minima BETWEEN 1 AND 5),
    preferencia_ator TEXT, -- Lista de IDs ou nomes de atores preferidos
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabela de associação entre usuários e seus gêneros preferidos
CREATE TABLE IF NOT EXISTS usuario_genero (
    id_usuario INTEGER NOT NULL,
    id_genero INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero) ON DELETE CASCADE,
    PRIMARY KEY (id_usuario, id_genero)
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

-- Tabela de filmes: Armazena informações sobre os filmes
CREATE TABLE IF NOT EXISTS filmes (
    id_filme_tmdb INTEGER PRIMARY KEY,  -- ID do filme no TMDb
    nome TEXT NOT NULL -- Nome do filme
);

-- Tabela de gêneros de filmes
CREATE TABLE IF NOT EXISTS generos (
    id_genero INTEGER PRIMARY KEY,  -- ID do gênero (corresponde ao TMDb)
    nome TEXT NOT NULL UNIQUE  -- Nome do gênero
);

-- Tabela de relacionamento entre filmes e gêneros (muitos para muitos)
CREATE TABLE IF NOT EXISTS filme_genero (
    id_filme_tmdb INTEGER NOT NULL,
    id_genero INTEGER NOT NULL,
    FOREIGN KEY (id_filme_tmdb) REFERENCES filmes(id_filme_tmdb) ON DELETE CASCADE,
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero) ON DELETE CASCADE,
    PRIMARY KEY (id_filme_tmdb, id_genero)
);

-- Tabela de comentários: Permite que usuários comentem sobre os filmes
CREATE TABLE IF NOT EXISTS comentarios (
    id_comentario INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER NOT NULL,
    id_filme_tmdb INTEGER NOT NULL,
    comentario TEXT NOT NULL,
    data_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme_tmdb) REFERENCES filmes(id_filme_tmdb) ON DELETE CASCADE
);