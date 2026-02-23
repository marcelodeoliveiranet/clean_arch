import 'package:clean_arch/features/exemplo/domain/entities/exemplo_entity.dart';
import 'package:clean_arch/features/exemplo/domain/repositories/exemplo_repository.dart';

class GetExemplosUseCase {
  final ExemploRepository repository;

  GetExemplosUseCase({required this.repository});

  Future<List<ExemploEntity>> call(String filter) async {
    return await repository.getExemplos(filter);
  }
}
