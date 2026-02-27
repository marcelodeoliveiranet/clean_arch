import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';

abstract class ClienteDatasourceLocal {
  Future<List<ClienteModel>> get(String filter);
  Future<ClienteModel> save(ClienteModel cliente);
  Future<ClienteModel> edit(ClienteModel cliente);
  Future<void> delete(ClienteModel cliente);
  Future<bool> existsByCpfAndIe(
    String cpfCnpj,
    String ieRg,
    int? codigoCliente,
  );
}
