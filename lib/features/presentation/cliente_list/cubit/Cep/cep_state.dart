import 'package:clean_arch/features/Cep/domain/entities/cep_entity.dart';

sealed class CepState {}

class CepStateInitial implements CepState {}

class CepStateLoading implements CepState {}

class CepStateSucess implements CepState {
  final CepEntity cep;

  const CepStateSucess({required this.cep});
}

class CepStateError implements CepState {
  final String error;

  const CepStateError({required this.error});
}
