import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';

abstract class RamoAtividadeRepository {
  Future<List<RamoAtividadeEntity>> getAll();
  Future<RamoAtividadeEntity> save(RamoAtividadeEntity ramo);
}
