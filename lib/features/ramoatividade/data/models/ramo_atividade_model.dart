import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';

class RamoAtividadeModel {
  final int? codigo;
  final String descricao;

  const RamoAtividadeModel({this.codigo, required this.descricao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo_ramo_atividade': codigo,
      'descricao_ramo_atividade': descricao,
    };
  }

  factory RamoAtividadeModel.fromMap(Map<String, dynamic> map) {
    return RamoAtividadeModel(
      codigo:
          map['codigo_ramo_atividade'] != null
              ? map['codigo_ramo_atividade'] as int
              : null,
      descricao: map['descricao_ramo_atividade'] as String,
    );
  }

  RamoAtividadeEntity toEntity() {
    return RamoAtividadeEntity(codigo: codigo, descricao: descricao);
  }

  factory RamoAtividadeModel.fromEntity(RamoAtividadeEntity entity) {
    return RamoAtividadeModel(
      codigo: entity.codigo,
      descricao: entity.descricao,
    );
  }
}
