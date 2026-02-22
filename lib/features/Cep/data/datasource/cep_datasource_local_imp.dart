// ignore_for_file: public_member_api_docs, sort_constructors_first
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
        return CepModel.fromJson(response.data);
      } else {
        throw Exception('CEP não encontrado');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
