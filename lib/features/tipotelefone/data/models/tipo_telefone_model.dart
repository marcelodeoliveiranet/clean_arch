class TipoTelefoneModel {
  final int? codigoTipoTelefone;
  final String descricaoTipoTelefone;

  TipoTelefoneModel({
    this.codigoTipoTelefone,
    required this.descricaoTipoTelefone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo_tipo_telefone': codigoTipoTelefone,
      'descricao_tipo_telefone': descricaoTipoTelefone,
    };
  }

  factory TipoTelefoneModel.fromMap(Map<String, dynamic> map) {
    return TipoTelefoneModel(
      codigoTipoTelefone:
          map['codigo_tipo_telefone'] != null
              ? map['codigo_tipo_telefone'] as int
              : null,
      descricaoTipoTelefone: map['descricao_tipo_telefone'] as String,
    );
  }
}
