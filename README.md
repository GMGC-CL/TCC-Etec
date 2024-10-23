# TCC - Etec

<details>
  <summary>UML</summary>

![alt text](tccdiagrama.png)

Este diagrama de casos de uso ilustra as principais funcionalidades do **Sistema de Recomendação de Filmes**. De modo a esclarecer a lógica, irei descreve detalhadamente cada ator, caso de uso, e as interações representadas.

### Atores:
1. **Usuário Não Logado**: 
   - Um usuário que acessa o sistema sem realizar login. Pode buscar recomendações de filmes, mas não tem acesso a funcionalidades de personalização e gestão de histórico.

2. **Usuário Logado**:
   - Após fazer login, o usuário tem acesso a funcionalidades adicionais, como salvar e gerenciar o histórico de busca, interagir com os filmes (avaliar, favoritar, comentar), e gerenciar seu perfil.

### Casos de Uso:

1. **Buscar Recomendação de Filmes** (disponível para todos os usuários):
   - O usuário pode inserir suas preferências (gênero, ano, nota, etc.) e obter uma lista de filmes recomendados com base nessas informações.
   - Para ambos os tipos de usuários, a funcionalidade de buscar filmes se aplica igualmente. Não há necessidade de login para usá-la.

2. **Fazer Login:**

    - Usuários que possuem cadastro no sistema podem fazer login, ganhando acesso a funcionalidades exclusivas. 
    - `<<extend>>`: Funções como **Gerenciar Histórico**, **Gerenciar Interações**, **Salvar Histórico de Busca**, e **Gerenciar Perfil** estendem o login, ou seja, essas funcionalidades só estão disponíveis após o login ser efetuado.
    - Caso o login falhe, o sistema exibirá uma **Mensagem de Erro**.
    - Se for preciso, **Alterar Senha** é uma opção oferecida ao usuário que tenta realizar o login.


3. **Salvar Histórico** (disponível apenas para Usuário Logado) – `<<include>>` de "Buscar Recomendação de Filmes":
   - Após buscar recomendações, o sistema salva automaticamente as buscas e os filmes recomendados no histórico de preferências do usuário.
   - Este caso de uso é automaticamente incluído quando o usuário faz a busca e está logado.

4. **Gerenciar Histórico** (disponível apenas para Usuário Logado) – `<<extend>>` de "Salvar Histórico":
   - O usuário logado pode visualizar, editar, ou excluir buscas anteriores e recomendações salvas.
   - Este é um caso de uso opcional e estendido, pois o usuário pode optar por realizar essa ação, mas não é um processo automático.
   - Dentro do gerenciamento do histórico, o sistema oferece automaticamente **Recomendações Baseadas no Histórico**. 

5. **Gerenciar Interações** (disponível apenas para Usuário Logado):
- Usuários logados podem gerenciar suas interações com os filmes recomendados, como favoritar, avaliar, e comentar sobre filmes.
-  **Gerar Interações** e **Gerenciar Interações** estão conectadas, pois após o usuário gerar interações, ele pode querer gerenciá-las. Porém, a conexão é representada como um uso comum, sem que uma dependa da outra diretamente.
- `<<extend>>`: A partir de **Favoritar Filmes**, o usuário pode acessar a lista de favoritos e remover filmes dessa lista.
- `<<extend>>`: A partir de **Avaliar Filmes**, o usuário pode acessar a lista de avaliações e editar suas avaliações anteriores.

6. **Gerenciar Perfil**(disponível apenas para Usuário Logado) – `<<extend>>` de "Fazer Login"::
- Usuários logados podem gerenciar informações do seu perfil, como alterar senha ou dados cadastrais.
.


</details>
<details>
  <summary>Construção da API</summary>

Para facilitar o desenvolvimento da  Api, dividi em partes o que cada pasta e arquivo deve conter, considerando as funcionalidades necessárias para o aplicativo de recomendação de filmes.

### 1. **firebase**
O Firebase pode ser usado para autenticação e armazenamento de dados em nuvem. Você precisará desenvolver a configuração e algumas funcionalidades relacionadas à autenticação.

#### a) `firebase/firebase_config.py`
- **O que desenvolver:**  
  Inicializa o Firebase dentro do seu aplicativo. Isso envolve carregar as credenciais e inicializar o SDK.
  
- **Objetivo:**  
  Configurar o Firebase, para que as funções de autenticação e outros serviços possam ser usados em todo o app.

#### b) `firebase/auth.py`
- **O que desenvolver:**  
  Funções relacionadas à autenticação, como criar usuários, verificar tokens de autenticação, e talvez login.
  
- **Objetivo:**  
  Implementar autenticação de usuários com Firebase, permitindo que eles se autentiquem e acessem os recursos protegidos da API.

### 2. **middlewares**
Os middlewares são funções que são executadas antes ou depois das suas rotas, como verificação de autenticação ou logs.

#### a) `middlewares/auth_middleware.py`
- **O que desenvolver:**  
  Um middleware que verifica a autenticação dos usuários antes de permitir o acesso às rotas protegidas.
  
- **Objetivo:**  
  Garantir que as rotas protegidas da sua API só possam ser acessadas por usuários autenticados.

#### b) `middlewares/logging_middleware.py`
- **O que desenvolver:**  
  Um middleware que registra informações sobre as requisições e respostas.
  
- **Objetivo:**  
  Manter um registro detalhado de todas as requisições e respostas para monitorar e depurar o sistema.

### 3. **mongo**
Aqui, iremos configurar o MongoDB para armazenar e consultar dados de filmes ou outras informações relevantes do usuário.

#### a) `mongo/database.py`
- **O que desenvolver:**  
  Configuração básica para se conectar ao MongoDB e retornar uma coleção específica.
  
- **Objetivo:**  
  Configurar e estabelecer uma conexão com o banco de dados MongoDB, que será usado para armazenar e consultar informações como filmes, preferências dos usuários, etc.

#### b) `mongo/models.py`
- **O que desenvolver:**  
  Um modelo que define como as informações de um filme ou outros dados devem ser armazenados no MongoDB.
  
- **Objetivo:**  
  Estruturar os dados de maneira consistente ao inseri-los ou recuperá-los do MongoDB.

#### c) `mongo/repository.py`
- **O que desenvolver:**  
  Funções de repositório que interagem diretamente com o banco de dados, como inserir filmes ou consultar a lista de filmes.
  
- **Objetivo:**  
  Facilitar a interação com o MongoDB, separando a lógica de banco de dados do restante do código.

### 4. **validators**
Os validadores são importantes para garantir que os dados enviados para as rotas da API estão no formato correto. Aqui, você vai validar os dados de entrada, como informações de filmes e usuários.

#### a) `validators/user_validators.py`
- **O que desenvolver:**  
  Validar os dados de entrada do usuário, como o formato de e-mail e a força da senha.
  
- **Objetivo:**  
  Garantir que os dados fornecidos pelo usuário estejam corretos e seguros antes de serem processados.

#### b) `validators/movie_validators.py`
- **O que desenvolver:**  
  Validar os dados relacionados aos filmes, como título, gênero, ano de lançamento, e nota.
  
- **Objetivo:**  
  Garantir que os dados de filmes estejam no formato correto antes de serem armazenados ou utilizados em buscas no TMDB.

---

### Exemplo Prático de Uso:

Imagine que um usuário queira acessar sua rota `/recommendation/` e receber recomendações de filmes baseadas em suas preferências. Aqui está como as diferentes partes que você vai desenvolver funcionarão juntas:

1. **Autenticação (Firebase):**  
   O usuário fará login via Firebase, que cria um token de autenticação. Este token será passado em cada requisição subsequente para verificar se ele está autorizado a usar a API.

2. **Middleware (auth_middleware.py):**  
   O middleware intercepta cada requisição e verifica se o token do Firebase é válido. Se não for, o acesso à rota é negado.

3. **Validação de Dados (validators/movie_validators.py):**  
   Quando o usuário envia suas preferências (como gênero e ano do filme), o validador garante que os dados estão corretos antes de processá-los.

4. **MongoDB (mongo/repository.py):**  
   Se necessário, o MongoDB será utilizado para armazenar informações, como o histórico de preferências do usuário ou filmes já recomendados. 

5. **Requisição para a API TMDB (controller):**  
   Com os dados validados, a aplicação faz uma requisição à API do TMDB usando o `movieController`. O resultado é então retornado ao usuário, ou armazenado no MongoDB para futuras consultas.

6. **Logs e Monitoramento (logging_middleware.py):**  
   Cada requisição e resposta será registrada para que o desenvolvedor possa monitorar o comportamento do sistema e identificar possíveis problemas.

Essa arquitetura distribui bem as responsabilidades, facilitando a manutenção e a escalabilidade do sistema.

</details>