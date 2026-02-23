import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/clientes/domain/repositories/cliente_repository.dart';

class DeleteClienteUsesCase {
  final ClienteRepository clienteRepository;

  DeleteClienteUsesCase({required this.clienteRepository});

  Future<void> deleteCliente(ClienteEntity clienteEntity) async {
    await clienteRepository.deleteCliente(clienteEntity);
  }
}
