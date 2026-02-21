import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';

abstract class TipoTelefoneRepository {
  Future<List<TipoTelefoneEntity>> getAll();
  Future<void> delete(TipoTelefoneEntity tipo);
  Future<TipoTelefoneEntity> save(TipoTelefoneEntity tipo);
}
