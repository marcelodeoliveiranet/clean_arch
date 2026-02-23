const String ramoAtividadeTableName = "RAMOATIVIDADE";

const String ramoAtividadeTable = ''' 
  CREATE TABLE IF NOT EXISTS $ramoAtividadeTableName (
      codigo_ramo_atividade INTEGER PRIMARY KEY,
      descricao_ramo_atividade TEXT NOT NULL
  )
''';
