-- Ativar suporte a chaves estrangeiras
PRAGMA foreign_keys = ON;

-- Tabela de usuários: armazena informações dos usuários cadastrados
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    senha TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de gêneros: contém os diferentes gêneros de filmes
CREATE TABLE IF NOT EXISTS generos (
    id_genero INTEGER PRIMARY KEY,
    nome TEXT UNIQUE NOT NULL
);

-- Tabela de filmes: armazena dados principais sobre filmes
CREATE TABLE IF NOT EXISTS filmes (
    id_filme INTEGER PRIMARY KEY AUTOINCREMENT,
    id_tmdb INTEGER UNIQUE NOT NULL,
    titulo TEXT NOT NULL,
    ano_lancamento INTEGER,
    sinopse TEXT,
    poster_url TEXT,
    imdb_id TEXT UNIQUE,
    orcamento INTEGER,
    receita INTEGER,
    duracao INTEGER,
    id_status INTEGER,
    FOREIGN KEY (id_status) REFERENCES status_filme(id_status) ON DELETE SET NULL
);

-- Tabela de status de filmes: armazena o estado do filme (lançado, em produção, etc.)
CREATE TABLE IF NOT EXISTS status_filme (
    id_status INTEGER PRIMARY KEY AUTOINCREMENT,
    descricao TEXT UNIQUE NOT NULL
);

-- Inserindo os status de filmes padrão
INSERT INTO status_filme (descricao) VALUES
('Rumor'), ('Planejado'), ('Em produção'), ('Pós-produção'), ('Lançado'), ('Cancelado');

-- Relacionamento entre filmes e gêneros
CREATE TABLE IF NOT EXISTS filme_genero (
    id_filme INTEGER,
    id_genero INTEGER,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero) ON DELETE CASCADE,
    PRIMARY KEY (id_filme, id_genero)
);

-- Tabela de produtoras: armazena os estúdios/produtoras de filmes
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

-- Tabela de países de produção de filmes
CREATE TABLE IF NOT EXISTS paises (
    id_pais TEXT PRIMARY KEY,
    nome TEXT UNIQUE NOT NULL
);

-- Relacionamento entre filmes e países de produção
CREATE TABLE IF NOT EXISTS filme_pais (
    id_filme INTEGER,
    id_pais TEXT,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais) ON DELETE CASCADE,
    PRIMARY KEY (id_filme, id_pais)
);

-- Tabela de idiomas dos filmes
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

-- Tabela de pessoas: atores, diretores e roteiristas
CREATE TABLE IF NOT EXISTS pessoas (
    id_pessoa INTEGER PRIMARY KEY,
    nome TEXT UNIQUE NOT NULL,
    perfil_url TEXT
);

-- Relacionamento entre filmes e pessoas (atores, diretores, roteiristas)
CREATE TABLE IF NOT EXISTS filme_pessoa (
    id_filme INTEGER,
    id_pessoa INTEGER,
    papel TEXT CHECK (papel IN ('ator', 'diretor', 'roteirista')),
    personagem TEXT,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    FOREIGN KEY (id_pessoa) REFERENCES pessoas(id_pessoa) ON DELETE CASCADE,
    PRIMARY KEY (id_filme, id_pessoa, papel)
);

-- Tabela de vídeos: armazena trailers e vídeos promocionais dos filmes
CREATE TABLE IF NOT EXISTS videos (
    id_video TEXT PRIMARY KEY,
    id_filme INTEGER,
    tipo TEXT CHECK (tipo IN ('Trailer', 'Teaser', 'Entrevista', 'Bastidores')),
    site TEXT CHECK (site IN ('YouTube', 'Vimeo')),
    url TEXT NOT NULL,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE
);

-- Tabela de palavras-chave dos filmes
CREATE TABLE IF NOT EXISTS palavras_chave (
    id_palavra INTEGER PRIMARY KEY,
    nome TEXT UNIQUE NOT NULL
);

-- Relacionamento entre filmes e palavras-chave
CREATE TABLE IF NOT EXISTS filme_palavra (
    id_filme INTEGER,
    id_palavra INTEGER,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    FOREIGN KEY (id_palavra) REFERENCES palavras_chave(id_palavra) ON DELETE CASCADE,
    PRIMARY KEY (id_filme, id_palavra)
);

-- Tabela de avaliações de filmes
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

-- Tabela de favoritos
CREATE TABLE IF NOT EXISTS favoritos (
    id_usuario INTEGER,
    id_filme INTEGER,
    data_favorito TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    PRIMARY KEY (id_usuario, id_filme)
);

-- Tabela de histórico de visualização
CREATE TABLE IF NOT EXISTS historico_visualizacao (
    id_usuario INTEGER,
    id_filme INTEGER,
    data_visualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    PRIMARY KEY (id_usuario, id_filme)
);

-- Tabela de recomendações
CREATE TABLE IF NOT EXISTS recomendacoes (
    id_usuario INTEGER,
    id_filme INTEGER,
    razao TEXT,
    data_recomendacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme) ON DELETE CASCADE,
    PRIMARY KEY (id_usuario, id_filme)
);
