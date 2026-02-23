import 'package:clean_arch/features/Cep/data/model/cep_model.dart';

abstract class CepDatasourceLocal {
  Future<CepModel> getAdressByCep(String cep);
}
