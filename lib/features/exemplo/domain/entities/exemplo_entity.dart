// Entidade de domínio para a feature `exemplo`
class ExemploEntity {
  final int? id;
  final String name;

  const ExemploEntity({this.id, required this.name});

  ExemploEntity copyWith({int? id, String? name}) {
    return ExemploEntity(id: id ?? this.id, name: name ?? this.name);
  }
}
