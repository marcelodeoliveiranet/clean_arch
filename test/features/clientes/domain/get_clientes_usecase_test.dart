import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_arch/features/clientes/domain/usecases/get_clientes_use_case.dart';
import 'package:clean_arch/features/clientes/domain/repositories/cliente_repository.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';

class MockClienteRepository extends Mock implements ClienteRepository {}

void main() {
  late GetClientesUseCase useCase;
  late MockClienteRepository mockRepo;

  setUp(() {
    mockRepo = MockClienteRepository();
    useCase = GetClientesUseCase(clienteRepository: mockRepo);
  });

  test('deve retornar lista de ClienteEntity do repository', () async {
    final clientes = [
      const ClienteEntity(
        foto: '',
        tipoPessoa: 'F',
        codigoCliente: 1,
        razaoSocial: 'Teste',
        nomeFantasia: 'Teste',
        codigoRamoAtividade: 1,
        cnpjCpf: '000',
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
      ),
    ];

    when(() => mockRepo.getClientes(any())).thenAnswer((_) async => clientes);

    final result = await useCase.call('filter');

    expect(result, clientes);
    verify(() => mockRepo.getClientes('filter')).called(1);
  });
}
