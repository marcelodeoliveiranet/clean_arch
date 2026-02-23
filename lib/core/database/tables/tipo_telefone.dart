const String tipoTelefoneTableName = "TIPOTELEFONE";

const String tipoTelefoneTable = ''' 
  CREATE TABLE IF NOT EXISTS $tipoTelefoneTableName (
    codigo_tipo_telefone INTEGER PRIMARY KEY,
    descricao_tipo_telefone TEXT NOT NULL
  )
''';
