import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_arch/features/clientes/data/repositories/cliente_repository_imp.dart';
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local.dart';
import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';

class MockClienteDatasourceLocal extends Mock
    implements ClienteDatasourceLocal {}

void main() {
  late ClienteRepositoryImp repository;
  late MockClienteDatasourceLocal mockDatasource;

  setUp(() {
    mockDatasource = MockClienteDatasourceLocal();
    repository = ClienteRepositoryImp(clienteDatasourceLocal: mockDatasource);
  });

  test('getClientes deve mapear ClienteModel para ClienteEntity', () async {
    final model = const ClienteModel(
      foto: '',
      codigoCliente: 1,
      razaoSocial: 'R',
      nomeFantasia: 'N',
      codigoRamoAtividade: 1,
      cnpjCpf: 'c',
      tipoPessoa: 'F',
      ieRg: '',
      inscricaoMunicipal: '',
      email: '',
      homePage: '',
      cep: '',
      logradouro: '',
      numero: '',
      complemento: '',
      bairro: '',
      municipio: '',
      codigoIbgeMunicipio: 0,
      uf: '',
      codigoTipoTelefone1: 1,
      telefone1: '',
      complementoTelefone1: '',
      dataCadastro: '',
    );

    when(() => mockDatasource.get(any())).thenAnswer((_) async => [model]);

    final result = await repository.getClientes('f');

    expect(result, isA<List<ClienteEntity>>());
    expect(result.first.razaoSocial, model.razaoSocial);
    verify(() => mockDatasource.get('f')).called(1);
  });

  test('saveCliente deve persistir e retornar entidade com id', () async {
    final entity = const ClienteEntity(
      foto: '',
      tipoPessoa: 'F',
      codigoCliente: null,
      razaoSocial: 'R',
      nomeFantasia: 'N',
      codigoRamoAtividade: 1,
      cnpjCpf: 'c',
      ieRg: '',
      inscricaoMunicipal: '',
      email: '',
      homePage: '',
      cep: '',
      logradouro: '',
      numero: '',
      complemento: '',
      bairro: '',
      municipio: '',
      codigoIbgeMunicipio: 0,
      uf: '',
      codigoTipoTelefone1: 1,
      telefone1: '',
      complementoTelefone1: '',
      dataCadastro: '',
    );

    when(() => mockDatasource.save(any())).thenAnswer((_) async => 42);

    final saved = await repository.save(entity);

    expect(saved.codigoCliente, 42);
    verify(() => mockDatasource.save(any())).called(1);
  });
}
