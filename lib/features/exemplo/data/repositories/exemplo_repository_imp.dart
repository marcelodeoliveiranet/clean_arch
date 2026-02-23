import 'package:clean_arch/features/exemplo/data/datasources/exemplo_datasource_local.dart';
import 'package:clean_arch/features/exemplo/data/models/exemplo_model.dart';
import 'package:clean_arch/features/exemplo/domain/entities/exemplo_entity.dart';
import 'package:clean_arch/features/exemplo/domain/repositories/exemplo_repository.dart';

class ExemploRepositoryImp implements ExemploRepository {
  final ExemploDatasourceLocal datasource;

  ExemploRepositoryImp({required this.datasource});

  @override
  Future<void> deleteExemplo(ExemploEntity exemplo) async {
    final model = ExemploModel.fromEntity(exemplo);
    await datasource.delete(model);
  }

  @override
  Future<List<ExemploEntity>> getExemplos(String filter) async {
    final models = await datasource.get(filter);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<ExemploEntity> saveExemplo(ExemploEntity exemplo) async {
    final model = ExemploModel.fromEntity(exemplo);
    final id = await datasource.save(model);
    return model.toEntity().copyWith(id: id);
  }
}
