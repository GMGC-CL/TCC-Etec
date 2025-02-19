-- Ativando suporte a chaves estrangeiras no SQLite
PRAGMA foreign_keys = ON;

-- Tabela de usuários
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de gêneros
CREATE TABLE IF NOT EXISTS generos (
    id_genero INTEGER PRIMARY KEY,
    nome TEXT UNIQUE NOT NULL
);

-- Populando a tabela de gêneros
INSERT INTO generos (id_genero, nome) VALUES
(28, 'Ação'),
(35, 'Comédia'),
(18, 'Drama'),
(10749, 'Romance'),
(16, 'Animação'),
(99, 'Documentário'),
(36, 'Biografia'),
(878, 'Ficção Científica'),
(27, 'Terror'),
(12, 'Aventura'),
(14, 'Fantasia'),
(9648, 'Mistério'),
(10752, 'Ação e Aventura'),
(10751, 'Família'),
(10402, 'Musical');

-- Tabela de filmes
CREATE TABLE IF NOT EXISTS filmes (
    id_filme INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    ano_lancamento INTEGER,
    sinopse TEXT,
    poster_url TEXT
);

-- Tabela de relacionamento entre filmes e gêneros
CREATE TABLE IF NOT EXISTS filme_genero (
    id_filme INTEGER,
    id_genero INTEGER,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero) ON DELETE CASCADE,
    PRIMARY KEY (id_filme, id_genero)
);

-- Tabela de avaliações dos filmes
CREATE TABLE IF NOT EXISTS avaliacoes (
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
CREATE TABLE IF NOT EXISTS favoritos (
    id_favorito INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    UNIQUE (id_usuario, id_filme)
);

-- Tabela de histórico de visualização
CREATE TABLE IF NOT EXISTS historico_visualizacao (
    id_historico INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    data_visualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE
);

-- Tabela de preferências do usuário
CREATE TABLE IF NOT EXISTS preferencias_usuario (
    id_preferencia INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    generos_preferidos TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabela para armazenar interações do usuário com o sistema
CREATE TABLE IF NOT EXISTS interacoes (
    id_interacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    tipo_interacao TEXT CHECK (tipo_interacao IN ('clicou', 'assistiu', 'ignorou')),
    data_interacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE
);

-- Tabela auxiliar para armazenar dados da API TMDb
CREATE TABLE IF NOT EXISTS filmes_api (
    id_filme_api INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT,
    ano_lancamento INTEGER,
    sinopse TEXT,
    poster_url TEXT,
    api_id TEXT UNIQUE -- ID do filme na API externa
);

-- Tabela de configurações da API TMDb
CREATE TABLE IF NOT EXISTS configuracoes_api (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chave_api TEXT NOT NULL,
    base_url TEXT NOT NULL DEFAULT 'https://api.themoviedb.org/3',
    endpoint_populares TEXT DEFAULT '/movie/popular',
    endpoint_busca TEXT DEFAULT '/search/movie',
    endpoint_detalhes TEXT DEFAULT '/movie/',
    cache_respostas TEXT,
    ultimo_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
