// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_arch/features/presentation/cliente_list/cubit/TipoTelefone/tipo_telefone_list_state.dart';
import 'package:clean_arch/features/tipotelefone/domain/usecases/get_tipo_telefone_use_case.dart';

class TipoTelefoneListCubit extends Cubit<TipoTelefoneListState> {
  final GetTipoTelefoneUseCase getTipoTelefoneUseCase;

  TipoTelefoneListCubit(this.getTipoTelefoneUseCase)
    : super(TipoTelefoneListInitial());

  Future<void> load() async {
    emit(TipoTelefoneListLoading());
    await Future.delayed(Duration(seconds: 5));

    try {
      final tipos = await getTipoTelefoneUseCase();
      emit(TipoTelefoneListSucess(tipos: tipos));
    } catch (e) {
      emit(TipoTelefoneListError(error: e.toString()));
    }
  }
}
