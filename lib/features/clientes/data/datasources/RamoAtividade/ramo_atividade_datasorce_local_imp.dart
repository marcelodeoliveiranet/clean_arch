import 'package:clean_arch/core/database/app_database.dart';
import 'package:clean_arch/core/database/tables/ramo_atividade.dart';
import 'package:clean_arch/features/clientes/data/datasources/RamoAtividade/ramo_atividade_datasource_local.dart';
import 'package:clean_arch/features/clientes/data/models/ramo_atividade_model.dart';
import 'package:sqflite/sqflite.dart';

class RamoAtividadeDatasorceLocalImp extends RamoatividadeDatasourceLocal {
  @override
  Future<void> delete(RamoAtividadeModel ramoAtividade) async {
    final Database db = await AppDatabase.database;

    await db.delete(
      ramoAtividadeTableName,
      where: "codigo_ramo_atividade = ?",
      whereArgs: [ramoAtividade.codigoRamoAtividade],
    );
  }

  @override
  Future<List<RamoAtividadeModel>> get() async {
    final Database db = await AppDatabase.database;

    final clientes = await db.query(ramoAtividadeTableName);
    return clientes.map((e) => RamoAtividadeModel.fromMap(e)).toList();
  }

  @override
  Future<void> save(RamoAtividadeModel ramoAtividade) async {
    final Database db = await AppDatabase.database;
    await db.insert(ramoAtividadeTableName, ramoAtividade.toMap());
  }
}
