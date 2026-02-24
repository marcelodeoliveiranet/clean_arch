// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';
import 'package:clean_arch/features/tipotelefone/domain/repositories/tipo_telefone_repository.dart';

class SaveTipoTelefoneUseCase {
  final TipoTelefoneRepository tipoTelefoneRepository;

  SaveTipoTelefoneUseCase({required this.tipoTelefoneRepository});

  Future<TipoTelefoneEntity> save(TipoTelefoneEntity tipo) async {
    return await tipoTelefoneRepository.save(tipo);
  }
}
