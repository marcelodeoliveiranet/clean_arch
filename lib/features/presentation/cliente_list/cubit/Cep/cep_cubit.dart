// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/core/exceptions/businnes_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_arch/features/Cep/domain/usecases/get_cep_use_case.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cep/cep_state.dart';

class CepCubit extends Cubit<CepState> {
  final GetCepUseCase getCepUseCase;

  CepCubit({required this.getCepUseCase}) : super(CepStateInitial());

  Future<void> load(String cep) async {
    emit(CepStateLoading());
    await Future.delayed(Duration(seconds: 5));

    try {
      final dadosCep = await getCepUseCase(cep);
      emit(CepStateSucess(cep: dadosCep));
    } on BusinnesException catch (e) {
      emit(CepStateError(error: e.mensagem));
    } catch (e) {
      emit(CepStateError(error: e.toString()));
    }
  }
}
