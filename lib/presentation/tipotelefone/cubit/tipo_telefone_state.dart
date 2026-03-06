import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';

sealed class TipoTelefoneState {}

class TipoTelefoneInitial implements TipoTelefoneState {}

class TipoTelefoneLoading implements TipoTelefoneState {}

class TipoTelefoneSucess implements TipoTelefoneState {
  final List<TipoTelefoneEntity> tipos;

  const TipoTelefoneSucess({required this.tipos});
}

class TipoTelefoneError implements TipoTelefoneState {
  final String error;

  const TipoTelefoneError({required this.error});
}
