import 'package:clean_arch/core/exceptions/businnes_exception.dart';
import 'package:dio/dio.dart';
import 'package:clean_arch/features/cep/data/datasource/cep_datasource_remote.dart';
import 'package:clean_arch/features/cep/data/model/cep_model.dart';

class CepDatasourceLocalImp implements CepDatasourceLocal {
  @override
  Future<CepModel> getAdressByCep(String cep) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://viacep.com.br/ws/",
        headers: {"Content-Type": "application/json"},
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    try {
      final response = await dio.get('/$cep/json/');

      if (response.data['erro'] == "true") {
        throw BusinnesException("Cep não encontrado");
      }

      if (response.statusCode == 200) {
        return CepModel.fromJson(response.data);
      } else {
        throw BusinnesException("Erro ao buscar CEP");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw BusinnesException("Tempo de busca do Cep esgotado");
      } else if (e.type == DioExceptionType.connectionError) {
        throw BusinnesException(
          "Erro de rede ao consultar o Cep. Verifique se você tem internet",
        );
      } else if (e.type == DioExceptionType.badResponse) {
        throw BusinnesException("Resposta inválida do servidor do Cep");
      } else {
        throw BusinnesException("Erro inesperado ao consultar o Cep");
      }
    } catch (e) {
      rethrow;
    }
  }
}
