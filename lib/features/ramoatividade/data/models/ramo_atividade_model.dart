class RamoAtividadeModel {
  final int? codigoRamoAtividade;
  final String descricaoRamoAtividade;

  const RamoAtividadeModel({
    this.codigoRamoAtividade,
    required this.descricaoRamoAtividade,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo_ramo_atividade': codigoRamoAtividade,
      'descricao_ramo_atividade': descricaoRamoAtividade,
    };
  }

  factory RamoAtividadeModel.fromMap(Map<String, dynamic> map) {
    return RamoAtividadeModel(
      codigoRamoAtividade:
          map['codigo_ramo_atividade'] != null
              ? map['codigo_ramo_atividade'] as int
              : null,
      descricaoRamoAtividade: map['descricao_ramo_atividade'] as String,
    );
  }
}
