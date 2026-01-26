const String clienteTableName = "CLIENTE";

const String clienteTable = ''' 
CREATE TABLE IF NOT EXISTS $clienteTableName (
  codigo_cliente INTEGER PRIMARY KEY,
  razao_social TEXT NOT NULL,
  nome_fantasia TEXT NOT NULL,
  codigo_atividade INTEGER NOT NULL,
  cnpj_cpf TEXT NOT NULL,
  tipoPessoa CHAR(1) DEFAULT 'J',
  ie_rg TEXT,
  inscricao_municipal TEXT,
  email TEXT,
  home_page TEXT,  
  cep TEXT NOT NULL,
  codigo_tipo_logradouro INTEGER NOT NULL,
  logradouro TEXT NOT NULL,
  numero TEXT NOT NULL,
  complemento TEXT NOT NULL,
  bairro TEXT NOT NULL,
  municipio TEXT NOT NULL,
  codigo_ibge_municipio INTEGER NOT NULL,
  uf TEXT NOT NULL)  
''';
