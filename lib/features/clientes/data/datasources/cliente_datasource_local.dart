import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';

abstract class ClienteDatasourceLocal {
  Future<List<ClienteModel>> get();
  Future<int> save(ClienteModel cliente);
  Future<void> delete(ClienteModel cliente);
}
