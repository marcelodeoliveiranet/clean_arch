import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local.dart';
import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';
import 'package:clean_arch/features/clientes/data/repositories/cliente_repository_imp.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/clientes/domain/repositories/cliente_repository.dart';
import 'package:clean_arch/features/clientes/domain/usecases/save_cliente_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClienteDataSource extends Mock implements ClienteDatasourceLocal {}

class FakeClienteModel extends Fake implements ClienteModel {}

void main() {
  late MockClienteDataSource dataSource;
  late ClienteRepository repository;

  setUp(() {
    registerFallbackValue(FakeClienteModel());
    dataSource = MockClienteDataSource();
    repository = ClienteRepositoryImp(clienteDatasourceLocal: dataSource);
  });

  test('save cliente use case ...', () async {
    //Arrange
    final SaveClienteUseCase saveClienteUseCase = SaveClienteUseCase(
      clienteRepository: repository,
    );

    when(() => dataSource.save(any())).thenAnswer((_) => Future.value(1));

    //Act
    final response = await saveClienteUseCase(clienteEntity);

    //Assert
    expect(response.codigoCliente, 1);
  });
}

const clienteModel = ClienteModel(
  foto: "",
  codigoCliente: 0,
  razaoSocial: "Marcelo",
  nomeFantasia: "Marcelo",
  codigoRamoAtividade: 1,
  cnpjCpf: "12364556",
  tipoPessoa: "F",
  ieRg: "154741",
  inscricaoMunicipal: "",
  email: "marcelosdeoliveiras@gmail.com",
  homePage: "",
  cep: "05134-000",
  logradouro: "Manoel Martins da Rocha",
  numero: "571",
  complemento: "",
  bairro: "MMM",
  municipio: "MMM",
  codigoIbgeMunicipio: 1233,
  uf: "SP",
  codigoTipoTelefone1: 1,
  telefone1: "123456789",
  complementoTelefone1: "",
  dataCadastro: "",
);

const clienteEntity = ClienteEntity(
  foto: "",
  codigoCliente: 0,
  razaoSocial: "Marcelo",
  nomeFantasia: "Marcelo",
  codigoRamoAtividade: 1,
  cnpjCpf: "12364556",
  tipoPessoa: "F",
  ieRg: "154741",
  inscricaoMunicipal: "",
  email: "marcelosdeoliveiras@gmail.com",
  homePage: "",
  cep: "05134-000",
  logradouro: "Manoel Martins da Rocha",
  numero: "571",
  complemento: "",
  bairro: "MMM",
  municipio: "MMM",
  codigoIbgeMunicipio: 1233,
  uf: "SP",
  codigoTipoTelefone1: 1,
  telefone1: "123456789",
  complementoTelefone1: "",
  dataCadastro: "",
);
