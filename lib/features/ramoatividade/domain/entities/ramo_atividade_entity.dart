// ignore_for_file: public_member_api_docs, sort_constructors_first
class RamoAtividadeEntity {
  final int? codigo;
  final String descricao;

  const RamoAtividadeEntity({this.codigo, required this.descricao});

  RamoAtividadeEntity copyWith({int? codigo, String? descricao}) {
    return RamoAtividadeEntity(
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
    );
  }
}
