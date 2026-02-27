import 'package:clean_arch/core/exceptions/businnes_exception.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/clientes/domain/usecases/edit_cliente_use_case.dart';
import 'package:clean_arch/features/clientes/domain/usecases/save_cliente_use_case.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_form/cliente_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClienteFormCubit extends Cubit<ClienteFormState> {
  final SaveClienteUseCase saveClienteUseCase;
  final EditClienteUseCase editClienteUseCase;
  ClienteFormCubit(this.saveClienteUseCase, this.editClienteUseCase)
    : super(ClienteFormInitial());

  Future<void> insert(ClienteEntity cliente) async {
    emit(ClienteFormSaving());

    try {
      await saveClienteUseCase.call(cliente);
      emit(ClienteFormSucessInsert());
    } on BusinnesException catch (e) {
      emit(ClienteFormError(error: e.mensagem));
    } catch (e) {
      emit(ClienteFormError(error: e.toString()));
    }
  }

  Future<void> edit(ClienteEntity cliente) async {
    emit(ClienteFormSaving());

    try {
      await editClienteUseCase.call(cliente);
      emit(ClienteFormSucessEdit());
    } on BusinnesException catch (e) {
      emit(ClienteFormError(error: e.mensagem));
    } catch (e) {
      emit(ClienteFormError(error: e.toString()));
    }
  }
}
