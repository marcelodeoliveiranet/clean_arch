import 'package:clean_arch/features/ramoatividade/data/datasources/ramo_atividade_datasource_local.dart';
import 'package:clean_arch/features/ramoatividade/data/models/ramo_atividade_model.dart';
import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';
import 'package:clean_arch/features/ramoatividade/domain/repositories/ramo_atividade_repository.dart';

class RamoAtividadeRepositoryImp implements RamoAtividadeRepository {
  final RamoatividadeDatasourceLocal ramoatividadeDatasourceLocal;

  RamoAtividadeRepositoryImp({required this.ramoatividadeDatasourceLocal});

  @override
  Future<List<RamoAtividadeEntity>> getAll() async {
    final ramos = await ramoatividadeDatasourceLocal.getAll();
    return ramos.map((e) => e.toEntity()).toList();
  }

  @override
  Future<RamoAtividadeEntity> save(RamoAtividadeEntity ramo) async {
    RamoAtividadeModel ramoModel = RamoAtividadeModel.fromEntity(ramo);
    final codigo = await ramoatividadeDatasourceLocal.save(ramoModel);
    return ramoModel.toEntity().copyWith(codigo: codigo);
  }
}
