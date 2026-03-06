// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';
import 'package:clean_arch/features/tipotelefone/domain/usecases/save_tipo_telefone_use_case.dart';
import 'package:clean_arch/presentation/tipotelefone/cubit/tipo_telefone_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch/features/tipotelefone/domain/usecases/get_tipo_telefone_use_case.dart';

class TipoTelefoneCubit extends Cubit<TipoTelefoneState> {
  final GetTipoTelefoneUseCase getTipoTelefoneUseCase;
  final SaveTipoTelefoneUseCase saveTipoTelefoneUseCase;

  List<TipoTelefoneEntity> listaTipoTelefones = [];

  TipoTelefoneCubit(this.getTipoTelefoneUseCase, this.saveTipoTelefoneUseCase)
    : super(TipoTelefoneInitial());

  Future<void> load() async {
    emit(TipoTelefoneLoading());

    try {
      final tipos = await getTipoTelefoneUseCase();
      listaTipoTelefones = tipos;
      emit(TipoTelefoneSucess(tipos: tipos));
    } catch (e) {
      emit(TipoTelefoneError(error: e.toString()));
    }
  }

  Future<TipoTelefoneEntity> save(TipoTelefoneEntity tipo) async {
    emit(TipoTelefoneLoading());

    try {
      return await saveTipoTelefoneUseCase.save(tipo);
    } catch (e) {
      emit(TipoTelefoneError(error: e.toString()));
      rethrow;
    }
  }
}
