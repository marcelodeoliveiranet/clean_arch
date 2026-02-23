// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/clientes/domain/repositories/cliente_repository.dart';

class SaveClienteUseCase {
  final ClienteRepository clienteRepository;

  SaveClienteUseCase({required this.clienteRepository});

  Future<ClienteEntity> call(ClienteEntity clienteEntity) async {
    return await clienteRepository.saveCliente(clienteEntity);
  }
}
