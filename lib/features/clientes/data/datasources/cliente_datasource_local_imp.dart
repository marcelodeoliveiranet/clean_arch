import 'package:clean_arch/core/database/app_database.dart';
import 'package:clean_arch/core/database/tables/cliente.dart';
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local.dart';
import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';
import 'package:sqflite/sqflite.dart';

class ClienteDatasourceLocalImp implements ClienteDatasourceLocal {
  @override
  Future<void> delete(ClienteModel cliente) async {
    throw UnimplementedError();
  }

  @override
  Future<List<ClienteModel>> get() async {
    final Database db = await AppDatabase.database;
    final registers = await db.query(clienteTableName);
    return registers.map((e) => ClienteModel.fromMap(e)).toList();
  }

  @override
  Future<int> save(ClienteModel cliente) async {
    final Database db = await AppDatabase.database;
    return await db.insert(clienteTableName, cliente.toMap());
  }
}
