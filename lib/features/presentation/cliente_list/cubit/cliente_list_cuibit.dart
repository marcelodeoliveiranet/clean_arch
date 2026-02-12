// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_arch/features/clientes/domain/usecases/get_clientes_use_case.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_list_state.dart';

class ClienteListCuibit extends Cubit<ClienteListState> {
  ClienteListCuibit(this.getClientesUseCase) : super(ClienteListInitial());
  final GetClientesUseCase getClientesUseCase;

  Future<void> load() async {
    emit(ClienteListLoading());
    await Future.delayed(Duration(seconds: 1));

    try {
      final clientes = await getClientesUseCase();
      emit(ClienteListSucess(clientes: clientes));
    } catch (e) {
      emit(ClienteListError(error: e.toString()));
    }
  }
}
