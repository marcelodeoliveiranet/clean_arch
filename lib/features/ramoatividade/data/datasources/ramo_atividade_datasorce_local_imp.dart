import 'package:clean_arch/core/database/app_database.dart';
import 'package:clean_arch/core/database/tables/ramo_atividade.dart';
import 'package:clean_arch/features/ramoatividade/data/datasources/ramo_atividade_datasource_local.dart';
import 'package:clean_arch/features/ramoatividade/data/models/ramo_atividade_model.dart';
import 'package:sqflite/sqflite.dart';

class RamoAtividadeDatasorceLocalImp implements RamoatividadeDatasourceLocal {
  @override
  Future<void> delete(RamoAtividadeModel ramoAtividade) async {
    final Database db = await AppDatabase.database;

    await db.delete(
      ramoAtividadeTableName,
      where: "codigo_ramo_atividade = ?",
      whereArgs: [ramoAtividade.codigo],
    );
  }

  @override
  Future<List<RamoAtividadeModel>> getAll() async {
    final Database db = await AppDatabase.database;

    final clientes = await db.query(ramoAtividadeTableName);
    return clientes.map((e) => RamoAtividadeModel.fromMap(e)).toList();
  }

  @override
  Future<int> save(RamoAtividadeModel ramoAtividade) async {
    final Database db = await AppDatabase.database;
    return await db.insert(ramoAtividadeTableName, ramoAtividade.toMap());
  }
}
