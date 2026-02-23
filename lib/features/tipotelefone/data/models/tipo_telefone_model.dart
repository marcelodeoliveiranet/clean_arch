import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';

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

  TipoTelefoneEntity toEntity() {
    return TipoTelefoneEntity(codigo: codigo, descricao: descricao);
  }

  factory TipoTelefoneModel.fromEntity(TipoTelefoneEntity entity) {
    return TipoTelefoneModel(
      codigo: entity.codigo,
      descricao: entity.descricao,
    );
  }
}
