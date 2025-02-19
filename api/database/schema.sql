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
(10752, 'Guerra'),
(10751, 'Família'),
(10402, 'Musical');

-- Tabela de filmes
CREATE TABLE IF NOT EXISTS filmes (
    id_filme INTEGER PRIMARY KEY AUTOINCREMENT,
    id_tmdb INTEGER UNIQUE NOT NULL, -- ID do filme no TMDb
    titulo TEXT NOT NULL,
    ano_lancamento INTEGER,
    sinopse TEXT,
    poster_url TEXT,
    imdb_id TEXT UNIQUE,
    facebook_id TEXT UNIQUE,
    instagram_id TEXT UNIQUE,
    twitter_id TEXT UNIQUE
);

-- Tabela de relacionamento entre filmes e gêneros
CREATE TABLE IF NOT EXISTS filme_genero (
    id_filme INTEGER,
    id_genero INTEGER,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero) ON DELETE CASCADE,
    PRIMARY KEY (id_filme, id_genero)
);

-- Tabela de produtoras
CREATE TABLE IF NOT EXISTS produtoras (
    id_produtora INTEGER PRIMARY KEY,
    nome TEXT UNIQUE NOT NULL
);

-- Relacionamento entre filmes e produtoras
CREATE TABLE IF NOT EXISTS filme_produtora (
    id_filme INTEGER,
    id_produtora INTEGER,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    FOREIGN KEY (id_produtora) REFERENCES produtoras(id_produtora) ON DELETE CASCADE,
    PRIMARY KEY (id_filme, id_produtora)
);

-- Tabela de países de produção
CREATE TABLE IF NOT EXISTS paises (
    id_pais TEXT PRIMARY KEY,
    nome TEXT UNIQUE NOT NULL
);

-- Relacionamento entre filmes e países
CREATE TABLE IF NOT EXISTS filme_pais (
    id_filme INTEGER,
    id_pais TEXT,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais) ON DELETE CASCADE,
    PRIMARY KEY (id_filme, id_pais)
);

-- Tabela de idiomas
CREATE TABLE IF NOT EXISTS idiomas (
    id_idioma TEXT PRIMARY KEY,
    nome TEXT UNIQUE NOT NULL
);

-- Relacionamento entre filmes e idiomas
CREATE TABLE IF NOT EXISTS filme_idioma (
    id_filme INTEGER,
    id_idioma TEXT,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    FOREIGN KEY (id_idioma) REFERENCES idiomas(id_idioma) ON DELETE CASCADE,
    PRIMARY KEY (id_filme, id_idioma)
);

-- Tabela de avaliações dos filmes
CREATE TABLE IF NOT EXISTS avaliacoes (
    id_avaliacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    nota INTEGER CHECK (nota BETWEEN 1 AND 5),
    critica TEXT,
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE
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

-- Tabela de favoritos
CREATE TABLE IF NOT EXISTS favoritos (
    id_favorito INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    data_favorito TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    UNIQUE (id_usuario, id_filme) -- Evita duplicação
);

-- Tabela de preferências do usuário
CREATE TABLE IF NOT EXISTS preferencias_usuario (
    id_preferencia INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    generos_preferidos TEXT,
    ano_preferido INTEGER,
    nota_minima INTEGER CHECK (nota_minima BETWEEN 1 AND 5),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabela de interações do usuário com o sistema
CREATE TABLE IF NOT EXISTS interacoes (
    id_interacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    tipo_interacao TEXT CHECK (tipo_interacao IN ('clicou', 'assistiu', 'ignorou')),
    data_interacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE
);

-- Tabela de histórico de busca
CREATE TABLE IF NOT EXISTS historico_busca (
    id_busca INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    termo_busca TEXT NOT NULL,
    data_busca TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabela de recomendações para usuários
CREATE TABLE IF NOT EXISTS recomendacoes (
    id_recomendacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_filme INTEGER,
    razao TEXT, -- Exemplo: "baseado no seu histórico", "baseado em seus favoritos"
    data_recomendacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE
);

-- Tabela de configurações da API TMDb
CREATE TABLE IF NOT EXISTS configuracoes_api (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chave_api TEXT NOT NULL,
    base_url TEXT NOT NULL DEFAULT 'https://api.themoviedb.org/3',
    endpoint_populares TEXT DEFAULT '/movie/popular',
    endpoint_busca TEXT DEFAULT '/search/movie',
    endpoint_detalhes TEXT DEFAULT '/movie/',
    endpoint_series_populares TEXT DEFAULT '/tv/popular',
    endpoint_busca_series TEXT DEFAULT '/search/tv',
    endpoint_detalhes_series TEXT DEFAULT '/tv/',
    cache_respostas TEXT,
    ultimo_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
