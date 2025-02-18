-- Criando o banco de dados
PRAGMA foreign_keys = ON;

-- Tabela de usuários
CREATE TABLE usuarios (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de filmes
CREATE TABLE filmes (
    id_filme INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    ano_lancamento INTEGER,
    genero TEXT,
    diretor TEXT,
    elenco TEXT,
    sinopse TEXT,
    poster_url TEXT
);

-- Tabela de avaliações dos filmes
CREATE TABLE avaliacoes (
    id_avaliacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    nota INTEGER CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE
);

-- Tabela de filmes favoritos dos usuários
CREATE TABLE favoritos (
    id_favorito INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    UNIQUE (id_usuario, id_filme)
);

-- Tabela de histórico de visualização
CREATE TABLE historico_visualizacao (
    id_historico INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    data_visualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE
);

-- Tabela de preferências do usuário
CREATE TABLE preferencias_usuario (
    id_preferencia INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    generos_preferidos TEXT,
    elenco_preferido TEXT,
    diretores_preferidos TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabela para armazenar interações do usuário com o sistema
CREATE TABLE interacoes (
    id_interacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    tipo_interacao TEXT CHECK (tipo_interacao IN ('clicou', 'assistiu', 'ignorou')),
    data_interacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE
);

-- Tabela auxiliar para armazenar dados da API TMDb
CREATE TABLE filmes_api (
    id_filme_api INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT,
    ano_lancamento INTEGER,
    genero TEXT,
    diretor TEXT,
    elenco TEXT,
    sinopse TEXT,
    poster_url TEXT,
    api_id TEXT UNIQUE -- ID do filme na API externa
);
