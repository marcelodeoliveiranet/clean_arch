import 'package:clean_arch/features/exemplo/data/models/exemplo_model.dart';

abstract class ExemploDatasourceLocal {
  Future<List<ExemploModel>> get(String filter);
  Future<int> save(ExemploModel model);
  Future<void> delete(ExemploModel model);
}
