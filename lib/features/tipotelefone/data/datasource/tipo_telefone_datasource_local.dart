import 'package:clean_arch/features/tipotelefone/data/models/tipo_telefone_model.dart';

abstract class TipoTelefoneDatasourceLocal {
  Future<List<TipoTelefoneModel>> get();
  Future<void> save(TipoTelefoneModel tipoTelefone);
  Future<void> delete(TipoTelefoneModel tipoTelefone);
}
