import 'package:clean_arch/features/cep/data/model/cep_model.dart';

abstract class CepDatasourceRemote {
  Future<CepModel> getAdressByCep(String cep);
}
