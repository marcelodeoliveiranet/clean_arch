import 'package:clean_arch/features/exemplo/domain/entities/exemplo_entity.dart';

class ExemploModel {
  final int? id;
  final String name;

  const ExemploModel({this.id, required this.name});

  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  factory ExemploModel.fromMap(Map<String, dynamic> map) =>
      ExemploModel(id: map['id'] as int?, name: map['name'] as String);

  ExemploEntity toEntity() => ExemploEntity(id: id, name: name);

  factory ExemploModel.fromEntity(ExemploEntity entity) =>
      ExemploModel(id: entity.id, name: entity.name);
}
