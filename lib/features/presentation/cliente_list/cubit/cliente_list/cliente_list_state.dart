// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';

sealed class ClienteListState {}

class ClienteListInitial implements ClienteListState {}

class ClienteListLoading implements ClienteListState {}

class ClienteListSucess implements ClienteListState {
  final List<ClienteEntity> clientes;

  const ClienteListSucess({required this.clientes});
}

class ClienteListError implements ClienteListState {
  final String error;

  const ClienteListError({required this.error});
}
