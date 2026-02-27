import 'package:clean_arch/features/cep/data/datasource/cep_datasource_remote.dart';
import 'package:clean_arch/features/cep/data/datasource/cep_datasource_remote_imp.dart';
import 'package:clean_arch/features/cep/data/repositores/cep_repository_imp.dart';
import 'package:clean_arch/features/cep/domain/repositories/cep_repository.dart';
import 'package:clean_arch/features/cep/domain/usecases/get_cep_use_case.dart';
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local.dart';
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local_imp.dart';
import 'package:clean_arch/features/clientes/data/repositories/cliente_repository_imp.dart';
import 'package:clean_arch/features/clientes/domain/repositories/cliente_repository.dart';
import 'package:clean_arch/features/clientes/domain/usecases/delete_cliente_uses_case.dart';
import 'package:clean_arch/features/clientes/domain/usecases/edit_cliente_use_case.dart';
import 'package:clean_arch/features/clientes/domain/usecases/get_clientes_use_case.dart';
import 'package:clean_arch/features/clientes/domain/usecases/save_cliente_use_case.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cep/cep_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_form/cliente_form_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_list/cliente_list_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/RamoAtividade/ramo_atividade_list_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/TipoTelefone/tipo_telefone_list_cubit.dart';
import 'package:clean_arch/features/ramoatividade/data/datasources/ramo_atividade_datasorce_local_imp.dart';
import 'package:clean_arch/features/ramoatividade/data/datasources/ramo_atividade_datasource_local.dart';
import 'package:clean_arch/features/ramoatividade/data/repositories/ramo_atividade_repository_imp.dart';
import 'package:clean_arch/features/ramoatividade/domain/repositories/ramo_atividade_repository.dart';
import 'package:clean_arch/features/ramoatividade/domain/usecases/get_ramo_atividade_use_case.dart';
import 'package:clean_arch/features/ramoatividade/domain/usecases/save_ramo_atividade_use_case.dart';
import 'package:clean_arch/features/tipotelefone/data/datasource/tipo_telefone_datasource_local.dart';
import 'package:clean_arch/features/tipotelefone/data/datasource/tipo_telefone_datasource_local_imp.dart';
import 'package:clean_arch/features/tipotelefone/data/repositories/tipo_telefone_repository_imp.dart';
import 'package:clean_arch/features/tipotelefone/domain/repositories/tipo_telefone_repository.dart';
import 'package:clean_arch/features/tipotelefone/domain/usecases/get_tipo_telefone_use_case.dart';
import 'package:clean_arch/features/tipotelefone/domain/usecases/save_tipo_telefone_use_case.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  //DataSource
  getIt.registerLazySingleton<CepDatasourceRemote>(
    () => CepDatasourceRemoteImp(),
  );

  getIt.registerLazySingleton<TipoTelefoneDatasourceLocal>(
    () => TipoTelefoneDatasourceLocalImp(),
  );

  getIt.registerLazySingleton<RamoatividadeDatasourceLocal>(
    () => RamoAtividadeDatasorceLocalImp(),
  );

  getIt.registerLazySingleton<ClienteDatasourceLocal>(
    () => ClienteDatasourceLocalImp(),
  );

  //Repositories
  getIt.registerLazySingleton<CepRepository>(
    () => CepRepositoryImp(cepDatasourceLocal: getIt<CepDatasourceRemote>()),
  );

  getIt.registerLazySingleton<RamoAtividadeRepository>(
    () => RamoAtividadeRepositoryImp(
      ramoatividadeDatasourceLocal: getIt<RamoatividadeDatasourceLocal>(),
    ),
  );

  getIt.registerLazySingleton<TipoTelefoneRepository>(
    () => TipoTelefoneRepositoryImp(
      tipoTelefoneDatasourceLocal: getIt<TipoTelefoneDatasourceLocal>(),
    ),
  );

  getIt.registerLazySingleton<ClienteRepository>(
    () => ClienteRepositoryImp(
      clienteDatasourceLocal: getIt<ClienteDatasourceLocal>(),
    ),
  );

  //UseCase
  getIt.registerLazySingleton<GetCepUseCase>(
    () => GetCepUseCase(cepRepository: getIt<CepRepository>()),
  );

  getIt.registerLazySingleton<GetRamoAtividadeUseCase>(
    () => GetRamoAtividadeUseCase(
      ramoAtividadeRepository: getIt<RamoAtividadeRepository>(),
    ),
  );

  getIt.registerLazySingleton<SaveRamoAtividadeUseCase>(
    () => SaveRamoAtividadeUseCase(
      ramoAtividadeRepository: getIt<RamoAtividadeRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetTipoTelefoneUseCase>(
    () => GetTipoTelefoneUseCase(
      tipoTelefoneRepository: getIt<TipoTelefoneRepository>(),
    ),
  );

  getIt.registerLazySingleton<SaveTipoTelefoneUseCase>(
    () => SaveTipoTelefoneUseCase(
      tipoTelefoneRepository: getIt<TipoTelefoneRepository>(),
    ),
  );

  getIt.registerLazySingleton<SaveClienteUseCase>(
    () => SaveClienteUseCase(clienteRepository: getIt<ClienteRepository>()),
  );

  getIt.registerLazySingleton<GetClientesUseCase>(
    () => GetClientesUseCase(clienteRepository: getIt<ClienteRepository>()),
  );

  getIt.registerLazySingleton<DeleteClienteUsesCase>(
    () => DeleteClienteUsesCase(clienteRepository: getIt<ClienteRepository>()),
  );

  getIt.registerLazySingleton<EditClienteUseCase>(
    () => EditClienteUseCase(clienteRepository: getIt<ClienteRepository>()),
  );

  //Cubit
  getIt.registerLazySingleton<CepCubit>(() => CepCubit(getIt<GetCepUseCase>()));

  getIt.registerLazySingleton<RamoAtividadeListCuibit>(
    () => RamoAtividadeListCuibit(
      getIt<GetRamoAtividadeUseCase>(),
      getIt<SaveRamoAtividadeUseCase>(),
    ),
  );

  getIt.registerLazySingleton<TipoTelefoneListCubit>(
    () => TipoTelefoneListCubit(
      getIt<GetTipoTelefoneUseCase>(),
      getIt<SaveTipoTelefoneUseCase>(),
    ),
  );

  getIt.registerLazySingleton<ClienteListCubit>(
    () => ClienteListCubit(
      getIt<GetClientesUseCase>(),
      getIt<DeleteClienteUsesCase>(),
    ),
  );

  getIt.registerLazySingleton<ClienteFormCubit>(
    () => ClienteFormCubit(
      getIt<SaveClienteUseCase>(),
      getIt<EditClienteUseCase>(),
    ),
  );
}
