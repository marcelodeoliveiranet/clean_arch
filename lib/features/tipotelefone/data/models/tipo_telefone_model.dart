class TipoTelefoneModel {
  final int? codigo;
  final String descricao;

  TipoTelefoneModel({this.codigo, required this.descricao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo_tipo_telefone': codigo,
      'descricao_tipo_telefone': descricao,
    };
  }

  factory TipoTelefoneModel.fromMap(Map<String, dynamic> map) {
    return TipoTelefoneModel(
      codigo:
          map['codigo_tipo_telefone'] != null
              ? map['codigo_tipo_telefone'] as int
              : null,
      descricao: map['descricao_tipo_telefone'] as String,
    );
  }
}
