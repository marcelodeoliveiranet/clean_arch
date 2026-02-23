// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/clientes/domain/repositories/cliente_repository.dart';

class GetClientesUseCase {
  final ClienteRepository clienteRepository;

  GetClientesUseCase({required this.clienteRepository});

  Future<List<ClienteEntity>> call(String filter) async {
    return await clienteRepository.getClientes(filter);
  }
}
