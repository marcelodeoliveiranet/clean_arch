// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/core/exceptions/businnes_exception.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/clientes/domain/usecases/delete_cliente_uses_case.dart';
import 'package:clean_arch/features/clientes/domain/usecases/save_cliente_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch/features/clientes/domain/usecases/get_clientes_use_case.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cliente/cliente_list_state.dart';

class ClienteListCuibit extends Cubit<ClienteListState> {
  ClienteListCuibit(
    this.getClientesUseCase,
    this.deleteClienteUsesCase,
    this.saveClienteUseCase,
  ) : super(ClienteListInitial());

  final GetClientesUseCase getClientesUseCase;
  final DeleteClienteUsesCase deleteClienteUsesCase;
  final SaveClienteUseCase saveClienteUseCase;

  Future<void> load(String filter) async {
    emit(ClienteListLoading());

    try {
      final clientes = await getClientesUseCase(filter);
      emit(ClienteListSucess(clientes: clientes));
    } on BusinnesException catch (e) {
      emit(ClienteListError(error: e.mensagem));
    } catch (e) {
      emit(ClienteListError(error: e.toString()));
    }
  }

  Future<void> delete(ClienteEntity clienteEntity) async {
    try {
      await deleteClienteUsesCase.deleteCliente(clienteEntity);
      final currentState = state;

      if (currentState is ClienteListSucess) {
        final listaClienteAtualizada = List<ClienteEntity>.from(
          currentState.clientes,
        )..removeWhere(
          (value) => value.codigoCliente == clienteEntity.codigoCliente,
        );

        emit(ClienteListSucess(clientes: listaClienteAtualizada));
      }
    } catch (e) {
      emit(ClienteListError(error: e.toString()));
    }
  }

  Future<ClienteEntity> save(ClienteEntity cliente) async {
    emit(ClienteListLoading());

    try {
      return await saveClienteUseCase(cliente);
    } catch (e) {
      emit(ClienteListError(error: e.toString()));
      rethrow;
    }
  }
}
