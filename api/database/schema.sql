-- Ativar suporte a chaves estrangeiras
PRAGMA foreign_keys = ON;
PRAGMA encoding = 'UTF-8';

---------------------------------------------------------------------------------------------------------

-- Tabela de usuários: Armazena informações dos usuários cadastrados
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL,
    admin INTEGER DEFAULT 0 CHECK (admin IN (0,1)),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de histórico de visualização, favoritos e comentários
CREATE TABLE IF NOT EXISTS historico_visualizacao (
    id_usuario INTEGER,
    id_filme_tmdb INTEGER NOT NULL,
    data_visualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    favorito INTEGER DEFAULT 0 CHECK (favorito IN (0,1)),
    comentario TEXT,
    nota INTEGER CHECK (nota BETWEEN 1 AND 5),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme_tmdb) REFERENCES filmes(id_filme_tmdb) ON DELETE CASCADE,
    PRIMARY KEY (id_usuario, id_filme_tmdb)
    );

---------------------------------------------------------------------------------------------------------


-- Tabela de preferências de tags: Armazena tags favoritas
CREATE TABLE IF NOT EXISTS preferencias_usuario (
    id_usuario INTEGER PRIMARY KEY,
    tags_favoritas TEXT NOT NULL, 
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
    id_filme_tmdb INTEGER NOT NULL,
    razao TEXT,
    data_recomendacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    PRIMARY KEY (id_usuario, id_filme_tmdb)
);

---------------------------------------------------------------------------------------------------------

-- Tabela de filmes: Armazena informações sobre os filmes
CREATE TABLE IF NOT EXISTS filmes (
    id_filme_tmdb INTEGER PRIMARY KEY,
    nome TEXT NOT NULL
);

-- Tabela de gêneros de filmes
CREATE TABLE IF NOT EXISTS generos (
    id_genero INTEGER PRIMARY KEY,
    nome TEXT NOT NULL UNIQUE
);

-- Tabela de relacionamento entre filmes e gêneros (muitos para muitos)
CREATE TABLE IF NOT EXISTS filme_genero (
    id_filme_tmdb INTEGER NOT NULL,
    id_genero INTEGER NOT NULL,
    FOREIGN KEY (id_filme_tmdb) REFERENCES filmes(id_filme_tmdb) ON DELETE CASCADE,
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero) ON DELETE CASCADE,
    PRIMARY KEY (id_filme_tmdb, id_genero)
);

-- Tabela de tags
CREATE TABLE IF NOT EXISTS tags (
    id_tag INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE
);

-- Tabela de relacionamento entre filmes e tags (Muitos para Muitos)
CREATE TABLE IF NOT EXISTS filme_tag (
    id_filme_tmdb INTEGER,
    id_tag INTEGER,
    FOREIGN KEY (id_filme_tmdb) REFERENCES filmes(id_filme_tmdb) ON DELETE CASCADE,
    FOREIGN KEY (id_tag) REFERENCES tags(id_tag) ON DELETE CASCADE,
    PRIMARY KEY (id_filme_tmdb, id_tag)
);
