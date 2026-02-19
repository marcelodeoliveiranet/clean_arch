// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/core/exceptions/businnes_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_arch/features/clientes/domain/usecases/get_clientes_use_case.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_list_state.dart';

class ClienteListCuibit extends Cubit<ClienteListState> {
  ClienteListCuibit(this.getClientesUseCase) : super(ClienteListInitial());
  final GetClientesUseCase getClientesUseCase;

  Future<void> load(String filter) async {
    emit(ClienteListLoading());
    await Future.delayed(Duration(seconds: 5));

    try {
      final clientes = await getClientesUseCase(filter);
      emit(ClienteListSucess(clientes: clientes));
    } on BusinnesException catch (e) {
      emit(ClienteListError(error: e.mensagem));
    } catch (e) {
      emit(ClienteListError(error: e.toString()));
    }
  }
}
