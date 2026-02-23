import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';

sealed class RamoAtividadeListState {}

class RamoAtividadeListInitial implements RamoAtividadeListState {}

class RamoAtividadeListLoading implements RamoAtividadeListState {}

class RamoAtividadeListSucess implements RamoAtividadeListState {
  final List<RamoAtividadeEntity> ramos;

  const RamoAtividadeListSucess({required this.ramos});
}

class RamoAtividadeListError implements RamoAtividadeListState {
  final String error;

  const RamoAtividadeListError({required this.error});
}
