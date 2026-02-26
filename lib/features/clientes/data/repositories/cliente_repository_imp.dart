// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local.dart';
import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/clientes/domain/repositories/cliente_repository.dart';

class ClienteRepositoryImp implements ClienteRepository {
  final ClienteDatasourceLocal clienteDatasourceLocal;

  const ClienteRepositoryImp({required this.clienteDatasourceLocal});

  @override
  Future<void> deleteCliente(ClienteEntity cliente) async {
    ClienteModel clienteModel = ClienteModel(
      foto: cliente.foto,
      codigoCliente: cliente.codigoCliente,
      razaoSocial: cliente.razaoSocial,
      nomeFantasia: cliente.nomeFantasia,
      codigoRamoAtividade: cliente.codigoRamoAtividade,
      cnpjCpf: cliente.cnpjCpf,
      tipoPessoa: cliente.tipoPessoa,
      ieRg: cliente.ieRg,
      inscricaoMunicipal: cliente.inscricaoMunicipal,
      email: cliente.email,
      homePage: cliente.homePage,
      cep: cliente.cep,
      logradouro: cliente.logradouro,
      numero: cliente.numero,
      complemento: cliente.complemento,
      bairro: cliente.bairro,
      municipio: cliente.municipio,
      codigoIbgeMunicipio: cliente.codigoIbgeMunicipio,
      uf: cliente.uf,
      codigoTipoTelefone1: cliente.codigoTipoTelefone1,
      complementoTelefone1: cliente.complementoTelefone1,
      dataCadastro: cliente.dataCadastro,
      telefone1: cliente.telefone1,
    );

    await clienteDatasourceLocal.delete(clienteModel);
  }

  @override
  Future<List<ClienteEntity>> getClientes(String filter) async {
    final clientes = await clienteDatasourceLocal.get(filter);
    return clientes.map((e) => e.toEntity()).toList();
  }

  @override
  Future<ClienteEntity> saveCliente(ClienteEntity cliente) async {
    ClienteModel clienteModel = ClienteModel.fromEntity(cliente);

    final dadosCliente = await clienteDatasourceLocal.save(clienteModel);

    return clienteModel.toEntity().copyWith(
      codigoCliente: dadosCliente.codigoCliente,
    );
  }

  @override
  Future<bool> existsByCpfAndIe(
    String cpfCnpj,
    String ieRg,
    int? codigoCliente,
  ) async {
    return clienteDatasourceLocal.existsByCpfAndIe(
      cpfCnpj,
      ieRg,
      codigoCliente,
    );
  }
}
