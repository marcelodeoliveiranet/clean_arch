import 'package:clean_arch/features/clientes/data/models/ramo_atividade_model.dart';

abstract class RamoatividadeDatasourceLocal {
  Future<List<RamoAtividadeModel>> get();
  Future<void> save(RamoAtividadeModel ramoAtividade);
  Future<void> delete(RamoAtividadeModel ramoAtividade);
}
