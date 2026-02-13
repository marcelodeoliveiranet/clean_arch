import 'package:clean_arch/core/database/app_database.dart';
import 'package:clean_arch/core/database/tables/tipo_telefone.dart';
import 'package:clean_arch/features/tipotelefone/data/datasource/tipo_telefone_datasource_local.dart';
import 'package:clean_arch/features/tipotelefone/data/models/tipo_telefone_model.dart';
import 'package:sqflite/sqflite.dart';

class TipoTelefoneDatasourceLocalImp extends TipoTelefoneDatasourceLocal {
  @override
  Future<void> delete(TipoTelefoneModel tipoTelefone) async {
    final Database db = await AppDatabase.database;

    await db.delete(
      tipoTelefoneTableName,
      where: "codigo_tipo_telefone = ?",
      whereArgs: [tipoTelefone.codigo],
    );
  }

  @override
  Future<List<TipoTelefoneModel>> get() async {
    final Database db = await AppDatabase.database;
    final tiposTelefone = await db.query(tipoTelefoneTableName);
    return tiposTelefone.map((e) => TipoTelefoneModel.fromMap(e)).toList();
  }

  @override
  Future<int> save(TipoTelefoneModel tipoTelefone) async {
    final Database db = await AppDatabase.database;
    return await db.insert(tipoTelefoneTableName, tipoTelefone.toMap());
  }
}
