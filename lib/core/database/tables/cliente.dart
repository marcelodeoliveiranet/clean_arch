import 'package:clean_arch/core/database/tables/ramo_atividade.dart';
import 'package:clean_arch/core/database/tables/tipo_telefone.dart';

const String clienteTableName = "CLIENTE";

const String clienteTable = ''' 
CREATE TABLE IF NOT EXISTS $clienteTableName (
  foto TEXT,
  tipo_pessoa CHAR(1) DEFAULT 'J',
  codigo_cliente INTEGER PRIMARY KEY,
  razao_social TEXT NOT NULL,
  nome_fantasia TEXT NOT NULL,
  codigo_ramo_atividade INTEGER NOT NULL,
  cnpj_cpf TEXT NOT NULL,  
  ie_rg TEXT,
  inscricao_municipal TEXT,
  email TEXT,
  home_page TEXT,    
  cep TEXT NOT NULL,  
  logradouro TEXT NOT NULL,
  numero TEXT NOT NULL,
  complemento TEXT NOT NULL,
  bairro TEXT NOT NULL,
  municipio TEXT NOT NULL,
  codigo_ibge_municipio INTEGER NOT NULL,
  uf TEXT NOT NULL,
  codigo_tipo_telefone1 INTEGER,
  telefone1 text,
  complemento_telefone1 TEXT,
  data_cadastro TEXT NOT NULL DEFAULT(DATETIME('NOW', 'LOCALTIME')),

  FOREIGN KEY (codigo_ramo_atividade) 
  REFERENCES $ramoAtividadeTableName(codigo_ramo_atividade),

  FOREIGN KEY (codigo_tipo_telefone1)
  REFERENCES $tipoTelefoneTableName(codigo_tipo_telefone)
  )  
''';
