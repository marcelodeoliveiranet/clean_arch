import 'package:clean_arch/features/tipologradouro/data/models/tipo_logradouro_model.dart';

abstract class TipoLogradouroDatasourceLocal {
  Future<List<TipoLogradouroModel>> get();
  Future<void> save(TipoLogradouroModel tipoLogradouro);
  Future<void> delete(TipoLogradouroModel tipoLogradouro);
}
