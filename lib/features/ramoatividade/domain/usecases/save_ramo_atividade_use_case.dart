// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';
import 'package:clean_arch/features/ramoatividade/domain/repositories/ramo_atividade_repository.dart';

class SaveRamoAtividadeUseCase {
  final RamoAtividadeRepository ramoAtividadeRepository;

  SaveRamoAtividadeUseCase({required this.ramoAtividadeRepository});

  Future<RamoAtividadeEntity> save(RamoAtividadeEntity ramo) async {
    return await ramoAtividadeRepository.save(ramo);
  }
}
