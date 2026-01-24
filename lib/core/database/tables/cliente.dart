const String clienteTableName = "CLIENTE";

const String clienteTable = ''' 
CREATE TABLE $clienteTableName (
  codigo_cliente INT IDENTITY NOT NULL,
  razao_social VARCHAR(60) NOT NULL,
  nome_fantasia VARCHAR(60) NOT NULL,
  codigo_atividade SMALLINT NOT NULL,
  cnpj_cpf VARCHAR(20) NOT NULL,
  tipoPessoa CHAR(1) DEFAULT 'J',
  ie_rg VARCHAR(20),
  inscricao_municipal VARCHAR(20),
  email VARCHAR(90),
  home_page VARCHAR(120),  
  cep VARCHAR(9) NOT NULL,
  codigo_tipo_logradouro SMALLINT NOT NULL,
  logradouro VARCHAR(255) NOT NULL,
  numero VARCHAR(50) NOT NULL,
  complemento VARCHAR(100) NOT NULL,
  bairro VARCHAR(100) NOT NULL,
  municipio VARCHAR(100) NOT NULL,
  codigo_ibge_municipio INT NOT NULL,
  uf VARCHAR(2) NOT NULL,
  CONSTRAINT [PK_Cliente] PRIMARY KEY ([codigo_cliente])  
''';
