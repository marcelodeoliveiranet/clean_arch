// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/core/exceptions/businnes_exception.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/clientes/domain/repositories/cliente_repository.dart';

class EditClienteUseCase {
  final ClienteRepository clienteRepository;

  EditClienteUseCase({required this.clienteRepository});

  Future<ClienteEntity> call(ClienteEntity cliente) async {
    final clienteJaCadastrado = await clienteRepository.existsByCpfAndIe(
      cliente.cnpjCpf,
      cliente.ieRg,
      cliente.codigoCliente,
    );

    if (clienteJaCadastrado) {
      if (cliente.tipoPessoa == "F") {
        throw BusinnesException(
          "Já foi cadastrado um cliente com este CPF e RG",
        );
      } else {
        throw BusinnesException(
          "Já foi cadastrado um cliente com este CNPJ e Inscrição Estadual",
        );
      }
    }

    return await clienteRepository.edit(cliente);
  }
}
