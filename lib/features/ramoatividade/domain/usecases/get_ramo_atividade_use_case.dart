// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';
import 'package:clean_arch/features/ramoatividade/domain/repositories/ramo_atividade_repository.dart';

class GetRamoAtividadeUseCase {
  final RamoAtividadeRepository ramoAtividadeRepository;

  GetRamoAtividadeUseCase({required this.ramoAtividadeRepository});

  Future<List<RamoAtividadeEntity>> call() async {
    return await ramoAtividadeRepository.getAll();
  }
}
