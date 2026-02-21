import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';

sealed class TipoTelefoneListState {}

class TipoTelefoneListInitial implements TipoTelefoneListState {}

class TipoTelefoneListLoading implements TipoTelefoneListState {}

class TipoTelefoneListSucess implements TipoTelefoneListState {
  final List<TipoTelefoneEntity> tipos;

  const TipoTelefoneListSucess({required this.tipos});
}

class TipoTelefoneListError implements TipoTelefoneListState {
  final String error;

  const TipoTelefoneListError({required this.error});
}
