import 'package:clean_arch/core/exceptions/businnes_exception.dart';
import 'package:dio/dio.dart';
import 'package:clean_arch/features/Cep/data/datasource/cep_datasource_local.dart';
import 'package:clean_arch/features/Cep/data/model/cep_model.dart';

class CepDatasourceLocalImp implements CepDatasourceLocal {
  @override
  Future<CepModel> getAdressByCep(String cep) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://viacep.com.br/ws/",
        headers: {"Content-Type": "application/json"},
      ),
    );

    final response = await dio.get('/$cep/json/');

    try {
      if (response.statusCode == 200) {
        if (response.data['erro'] == "true") {
          throw BusinnesException("Cep não encontrado");
        } else {
          return CepModel.fromJson(response.data);
        }
      } else {
        throw BusinnesException('CEP não encontrado');
      }
    } catch (e) {
      throw BusinnesException(e.toString());
    }
  }
}
