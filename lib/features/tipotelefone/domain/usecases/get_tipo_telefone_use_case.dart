// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';
import 'package:clean_arch/features/tipotelefone/domain/repositories/tipo_telefone_repository.dart';

class GetTipoTelefoneUseCase {
  final TipoTelefoneRepository tipoTelefoneRepository;

  GetTipoTelefoneUseCase({required this.tipoTelefoneRepository});

  Future<List<TipoTelefoneEntity>> call() async {
    return await tipoTelefoneRepository.getAll();
  }
}
