import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch/features/exemplo/domain/entities/exemplo_entity.dart';
import 'package:clean_arch/features/exemplo/domain/usecases/get_exemplos_usecase.dart';

abstract class ExemploState {}

class ExemploInitial extends ExemploState {}

class ExemploLoading extends ExemploState {}

class ExemploSuccess extends ExemploState {
  final List<ExemploEntity> dados;
  ExemploSuccess(this.dados);
}

class ExemploError extends ExemploState {
  final String message;
  ExemploError(this.message);
}

class ExemploCubit extends Cubit<ExemploState> {
  final GetExemplosUseCase getExemplosUseCase;

  ExemploCubit({required this.getExemplosUseCase}) : super(ExemploInitial());

  Future<void> load(String filter) async {
    try {
      emit(ExemploLoading());
      final dados = await getExemplosUseCase.call(filter);
      emit(ExemploSuccess(dados));
    } catch (e) {
      emit(ExemploError(e.toString()));
    }
  }
}
