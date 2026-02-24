import 'package:clean_arch/features/cep/domain/entities/cep_entity.dart';
import 'package:clean_arch/features/cep/domain/repositories/cep_repository.dart';

class GetCepUseCase {
  final CepRepository cepRepository;

  GetCepUseCase({required this.cepRepository});

  Future<CepEntity> call(String cep) async {
    return cepRepository.getAdressByCep(cep);
  }
}
