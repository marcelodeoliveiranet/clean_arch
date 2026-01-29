import 'package:clean_arch/core/database/app_database.dart';
import 'package:clean_arch/core/database/tables/tipo_logradouro.dart';
import 'package:clean_arch/features/tipologradouro/data/datasources/tipo_logradouro_datasource_local.dart';
import 'package:clean_arch/features/tipologradouro/data/models/tipo_logradouro_model.dart';
import 'package:sqflite/sqflite.dart';

class TipoLogradouroDatasourceLocalImp extends TipoLogradouroDatasourceLocal {
  @override
  Future<void> delete(TipoLogradouroModel tipoLogradouro) async {
    final Database db = await AppDatabase.database;

    await db.delete(
      tipoLogradouroTableName,
      where: "codigo_tipo_logradouro = ?",
      whereArgs: [tipoLogradouro.codigoTipoLogradouro],
    );
  }

  @override
  Future<List<TipoLogradouroModel>> get() async {
    final Database db = await AppDatabase.database;
    final tiposLogradouro = await db.query(tipoLogradouroTableName);
    return tiposLogradouro.map((e) => TipoLogradouroModel.fromMap(e)).toList();
  }

  @override
  Future<void> save(TipoLogradouroModel tipoLogradouro) async {
    final Database db = await AppDatabase.database;
    await db.insert(tipoLogradouroTableName, tipoLogradouro.toMap());
  }
}
