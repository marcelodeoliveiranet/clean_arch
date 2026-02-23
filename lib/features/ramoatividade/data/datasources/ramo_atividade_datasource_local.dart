import 'package:clean_arch/features/ramoatividade/data/models/ramo_atividade_model.dart';

abstract class RamoatividadeDatasourceLocal {
  Future<List<RamoAtividadeModel>> getAll();
  Future<int> save(RamoAtividadeModel ramoAtividade);
  Future<void> delete(RamoAtividadeModel ramoAtividade);
}
