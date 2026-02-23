import 'package:clean_arch/features/exemplo/domain/entities/exemplo_entity.dart';

abstract class ExemploRepository {
  Future<List<ExemploEntity>> getExemplos(String filter);
  Future<ExemploEntity> saveExemplo(ExemploEntity exemplo);
  Future<void> deleteExemplo(ExemploEntity exemplo);
}
