// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clean_arch/features/presentation/cliente_list/cubit/RamoAtividade/ramo_atividade_list_state.dart';
import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';
import 'package:clean_arch/features/ramoatividade/domain/usecases/get_ramo_atividade_use_case.dart';
import 'package:clean_arch/features/ramoatividade/domain/usecases/save_ramo_atividade_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RamoAtividadeListCuibit extends Cubit<RamoAtividadeListState> {
  RamoAtividadeListCuibit(
    this.getRamoAtividadeUseCase,
    this.saveRamoAtividadeUseCase,
  ) : super(RamoAtividadeListInitial());

  final GetRamoAtividadeUseCase getRamoAtividadeUseCase;
  final SaveRamoAtividadeUseCase saveRamoAtividadeUseCase;

  List<RamoAtividadeEntity> listaRamoAtividade = [];

  Future<void> load() async {
    emit(RamoAtividadeListLoading());

    try {
      final ramos = await getRamoAtividadeUseCase();
      listaRamoAtividade = ramos;
      emit(RamoAtividadeListSucess(ramos: ramos));
    } catch (e) {
      emit(RamoAtividadeListError(error: e.toString()));
    }
  }

  Future<RamoAtividadeEntity> save(RamoAtividadeEntity ramo) async {
    emit(RamoAtividadeListLoading());

    try {
      return await saveRamoAtividadeUseCase.save(ramo);
    } catch (e) {
      emit(RamoAtividadeListError(error: e.toString()));
      rethrow;
    }
  }
}
