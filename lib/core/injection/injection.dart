import 'package:clean_arch/features/Cep/data/datasource/cep_datasource_local.dart';
import 'package:clean_arch/features/Cep/data/datasource/cep_datasource_local_imp.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  getIt.registerLazySingleton<CepDatasourceLocal>(
    () => CepDatasourceLocalImp(),
  );

  //getIt.registerLazySingleton<CepRepository>(() => CepRepositoryImp());
}
