// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local.dart';
import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/clientes/domain/repositories/cliente_repository.dart';

class ClienteRepositoryImp implements ClienteRepository {
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
      codigoTipoLogradouro: cliente.codigoTipoLogradouro,
      logradouro: cliente.logradouro,
      numero: cliente.numero,
      complemento: cliente.complemento,
      bairro: cliente.bairro,
      municipio: cliente.municipio,
      codigoIbgeMunicipio: cliente.codigoIbgeMunicipio,
      uf: cliente.uf,
      codigoTipoTelefone1: cliente.codigoTipoTelefone1,
      codigoTipoTelefone2: cliente.codigoTipoTelefone2,
      complementoTelefone1: cliente.complementoTelefone1,
      complementoTelefone2: cliente.complementoTelefone2,
      dataCadastro: cliente.dataCadastro,
      telefone1: cliente.telefone1,
      telefone2: cliente.telefone2,
    );

    await clienteDatasourceLocal.delete(clienteModel);
  }

  @override
  Future<List<ClienteEntity>> getClientes() async {
    final clientes = await clienteDatasourceLocal.get();
    return clientes.map((e) => e.toEntity()).toList();
  }

  @override
  Future<ClienteEntity> saveCliente(ClienteEntity cliente) async {
    ClienteModel clienteModel = ClienteModel.fromEntity(cliente);

    final codigo = await clienteDatasourceLocal.save(clienteModel);

    return clienteModel.toEntity().copyWith(codigoCliente: codigo);
  }

  final ClienteDatasourceLocal clienteDatasourceLocal;

  const ClienteRepositoryImp({required this.clienteDatasourceLocal});
}
