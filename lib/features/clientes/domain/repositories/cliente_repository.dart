import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';

abstract class ClienteRepository {
  Future<List<ClienteEntity>> getClientes(String filter);
  Future<ClienteEntity> saveCliente(ClienteEntity cliente);
  Future<void> deleteCliente(ClienteEntity cliente);
  Future<bool> existsByCpfAndIe(String cpfCnpj, String ieRg);
}
