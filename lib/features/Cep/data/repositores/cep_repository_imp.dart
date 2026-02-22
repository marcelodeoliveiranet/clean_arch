// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/Cep/data/datasource/cep_datasource_local.dart';
import 'package:clean_arch/features/Cep/domain/entities/cep_entity.dart';
import 'package:clean_arch/features/Cep/domain/repositories/cep_repository.dart';

class CepRepositoryImp implements CepRepository {
  final CepDatasourceLocal cepDatasourceLocal;

  CepRepositoryImp({required this.cepDatasourceLocal});

  @override
  Future<CepEntity> getAdressByCep(String cep) async {
    final dadosCep = await cepDatasourceLocal.getAdressByCep(cep);
    return dadosCep.toEntity();
  }
}
