const String clienteTable = ''' 
CREATE TABLE CLIENTE (
  id INT IDENTITY NOT NULL PRIMARY KEY,
  razao_social VARCHAR(60) NOT NULL,
  nome_fantasia VARCHAR(60) NOT NULL,
  codigo_atividade SMALLINT NOT NULL,
  cpf_cnpj VARCHAR(20) NOT NULL,
  inscricao_estadual VARCHAR(20),
  inscricao_municipal VARCHAR(20),
  email VARCHAR(90),
  home_page VARCHAR(120),
  codigo_pais SMALLINT NOT NULL,
  cep VARCHAR(9) NOT NULL,
  codigo_tipo_logradouro SMALLINT NOT NULL,
  logradouro VARCHAR(255) NOT NULL,
  numero VARCHAR(50) NOT NULL,
  complemento VARCHAR(100) NOT NULL,
  bairro VARCHAR(100) NOT NULL,
  municipio VARCHAR(100) NOT NULL,
  codigo_ibge INT NOT NULL,
  uf VARCHAR(2) NOT NULL,
  codigo_municipio_ibge INT NOT NULL)
''';
