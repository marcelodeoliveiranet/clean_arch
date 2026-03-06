import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';

sealed class RamoAtividadeState {}

class RamoAtividadeListInitial implements RamoAtividadeState {}

class RamoAtividadeListLoading implements RamoAtividadeState {}

class RamoAtividadeListSucess implements RamoAtividadeState {
  final List<RamoAtividadeEntity> ramos;

  const RamoAtividadeListSucess({required this.ramos});
}

class RamoAtividadeListError implements RamoAtividadeState {
  final String error;

  const RamoAtividadeListError({required this.error});
}
