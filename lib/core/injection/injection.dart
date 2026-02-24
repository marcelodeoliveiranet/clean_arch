import 'package:clean_arch/features/cep/data/datasource/cep_datasource_remote.dart';
import 'package:clean_arch/features/cep/data/datasource/cep_datasource_remote_imp.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  getIt.registerLazySingleton<CepDatasourceLocal>(
    () => CepDatasourceLocalImp(),
  );

  //getIt.registerLazySingleton<CepRepository>(() => CepRepositoryImp());
}
