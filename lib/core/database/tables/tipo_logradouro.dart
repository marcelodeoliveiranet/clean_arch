const String tipoLogradouroTableName = "TIPOLOGRADOURO";

const String tipoLogradouroTable = ''' 
  CREATE TABLE IF NOT EXISTS $tipoLogradouroTableName (
    codigo_tipo_logradouro INTEGER PRIMARY KEY,
    descricao_tipo_logradouro TEXT NOT NULL
  )
''';
