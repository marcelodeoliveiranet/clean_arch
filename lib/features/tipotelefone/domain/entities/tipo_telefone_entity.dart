// ignore_for_file: public_member_api_docs, sort_constructors_first
class TipoTelefoneEntity {
  final int? codigo;
  final String descricao;

  TipoTelefoneEntity({this.codigo, required this.descricao});

  TipoTelefoneEntity copyWith({int? codigo, String? descricao}) {
    return TipoTelefoneEntity(
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
    );
  }
}
