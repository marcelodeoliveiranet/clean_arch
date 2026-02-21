// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clean_arch/features/presentation/cliente_list/cubit/RamoAtividade/ramo_atividade_list_state.dart';
import 'package:clean_arch/features/ramoatividade/domain/usecases/get_ramo_atividade_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RamoAtividadeListCuibit extends Cubit<RamoAtividadeListState> {
  RamoAtividadeListCuibit(this.getRamoAtividadeUseCase)
    : super(RamoAtividadeListInitial());

  final GetRamoAtividadeUseCase getRamoAtividadeUseCase;

  Future<void> load(String filter) async {
    emit(RamoAtividadeListLoading());
    await Future.delayed(Duration(seconds: 5));

    try {
      final ramos = await getRamoAtividadeUseCase();
      emit(RamoAtividadeListSucess(ramos: ramos));
    } catch (e) {
      emit(RamoAtividadeListError(error: e.toString()));
    }
  }
}
