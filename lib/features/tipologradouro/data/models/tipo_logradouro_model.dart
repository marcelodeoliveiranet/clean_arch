class TipoLogradouroModel {
  final int? codigoTipoLogradouro;
  final String descricaoTipoLogradouro;

  TipoLogradouroModel({
    this.codigoTipoLogradouro,
    required this.descricaoTipoLogradouro,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo_tipo_logradouro': codigoTipoLogradouro,
      'descricao_tipo_logradouro': descricaoTipoLogradouro,
    };
  }

  factory TipoLogradouroModel.fromMap(Map<String, dynamic> map) {
    return TipoLogradouroModel(
      codigoTipoLogradouro:
          map['codigo_tipo_togradouro'] != null
              ? map['codigo_tipo_logradouro'] as int
              : null,
      descricaoTipoLogradouro: map['descricao_tipo_logradouro'] as String,
    );
  }
}
