// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch/features/clientes/domain/usecases/delete_cliente_uses_case.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cliente/cliente_list_state.dart';

class ClienteDeleteCubit extends Cubit<ClienteListState> {
  final DeleteClienteUsesCase deleteClienteUsesCase;

  ClienteDeleteCubit({required this.deleteClienteUsesCase})
    : super(ClienteListInitial());

  Future<void> delete(ClienteEntity clienteEntity) async {
    if (state is! ClienteListSucess) return;

    final currentState = state as ClienteListSucess;

    final listaClienteAtualizada = List<ClienteEntity>.from(
      currentState.clientes,
    )..removeWhere(
      (value) => value.codigoCliente == clienteEntity.codigoCliente,
    );

    try {
      await deleteClienteUsesCase.deleteCliente(clienteEntity);
      emit(ClienteListSucess(clientes: listaClienteAtualizada));
    } catch (e) {
      emit(ClienteListError(error: e.toString()));
    }
  }
}
