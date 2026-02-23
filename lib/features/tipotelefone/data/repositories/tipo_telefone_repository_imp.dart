// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/tipotelefone/data/datasource/tipo_telefone_datasource_local.dart';
import 'package:clean_arch/features/tipotelefone/data/models/tipo_telefone_model.dart';
import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';
import 'package:clean_arch/features/tipotelefone/domain/repositories/tipo_telefone_repository.dart';

class TipoTelefoneRepositoryImp implements TipoTelefoneRepository {
  final TipoTelefoneDatasourceLocal tipoTelefoneDatasourceLocal;

  TipoTelefoneRepositoryImp({required this.tipoTelefoneDatasourceLocal});

  @override
  Future<void> delete(TipoTelefoneEntity tipo) async {
    TipoTelefoneModel tipoTelefoneModel = TipoTelefoneModel(
      codigo: tipo.codigo,
      descricao: tipo.descricao,
    );

    await tipoTelefoneDatasourceLocal.delete(tipoTelefoneModel);
  }

  @override
  Future<List<TipoTelefoneEntity>> getAll() async {
    final tipos = await tipoTelefoneDatasourceLocal.get();
    return tipos.map((e) => e.toEntity()).toList();
  }

  @override
  Future<TipoTelefoneEntity> save(TipoTelefoneEntity tipo) async {
    TipoTelefoneModel tipoTelefoneModel = TipoTelefoneModel.fromEntity(tipo);
    final codigo = await tipoTelefoneDatasourceLocal.save(tipoTelefoneModel);
    return tipoTelefoneModel.toEntity().copyWith(codigo: codigo);
  }
}
