import 'package:clean_arch/features/exemplo/data/datasources/exemplo_datasource_local.dart';
import 'package:clean_arch/features/exemplo/data/models/exemplo_model.dart';

// Implementação simples em memória como template (substituir por sqflite/http conforme necessário)
class ExemploDatasourceLocalImp implements ExemploDatasourceLocal {
  final List<ExemploModel> _storage = [];
  int _autoInc = 1;

  @override
  Future<void> delete(ExemploModel model) async {
    _storage.removeWhere((e) => e.id == model.id);
  }

  @override
  Future<List<ExemploModel>> get(String filter) async {
    if (filter.isEmpty) return List.from(_storage);
    return _storage
        .where((e) => e.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

  @override
  Future<int> save(ExemploModel model) async {
    final id = _autoInc++;
    final m = ExemploModel(id: id, name: model.name);
    _storage.add(m);
    return id;
  }
}
