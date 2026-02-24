// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';
import 'package:clean_arch/features/tipotelefone/domain/usecases/save_tipo_telefone_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_arch/features/presentation/cliente_list/cubit/TipoTelefone/tipo_telefone_list_state.dart';
import 'package:clean_arch/features/tipotelefone/domain/usecases/get_tipo_telefone_use_case.dart';

class TipoTelefoneListCubit extends Cubit<TipoTelefoneListState> {
  final GetTipoTelefoneUseCase getTipoTelefoneUseCase;
  final SaveTipoTelefoneUseCase saveTipoTelefoneUseCase;

  List<TipoTelefoneEntity> listaTipoTelefones = [];

  TipoTelefoneListCubit(
    this.getTipoTelefoneUseCase,
    this.saveTipoTelefoneUseCase,
  ) : super(TipoTelefoneListInitial());

  Future<void> load() async {
    emit(TipoTelefoneListLoading());

    try {
      final tipos = await getTipoTelefoneUseCase();
      listaTipoTelefones = tipos;
      emit(TipoTelefoneListSucess(tipos: tipos));
    } catch (e) {
      emit(TipoTelefoneListError(error: e.toString()));
    }
  }

  Future<TipoTelefoneEntity> save(TipoTelefoneEntity tipo) async {
    emit(TipoTelefoneListLoading());

    try {
      return await saveTipoTelefoneUseCase.save(tipo);
    } catch (e) {
      emit(TipoTelefoneListError(error: e.toString()));
      rethrow;
    }
  }
}
