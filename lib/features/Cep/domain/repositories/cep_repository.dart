import 'package:clean_arch/features/Cep/domain/entities/cep_entity.dart';

abstract class CepRepository {
  Future<CepEntity> getAdressByCep(String cep);
}
