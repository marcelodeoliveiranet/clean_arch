import 'package:clean_arch/core/database/app_database.dart';
import 'package:clean_arch/core/database/tables/cliente.dart';
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local.dart';
import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';
import 'package:sqflite/sqflite.dart';

class ClienteDatasourceLocalImp implements ClienteDatasourceLocal {
  @override
  Future<void> delete(ClienteModel cliente) async {
    final Database db = await AppDatabase.database;
    await db.delete(
      clienteTableName,
      where: "codigo_cliente = ?",
      whereArgs: [cliente.codigoCliente],
    );
  }

  @override
  Future<List<ClienteModel>> get(String filter) async {
    final Database db = await AppDatabase.database;
    final registers = await db.query(
      clienteTableName,
      where: "Upper(razao_social) like ?",
      whereArgs: ['%${filter.toUpperCase()}%'],
    );
    return registers.map((e) => ClienteModel.fromMap(e)).toList();
  }

  @override
  Future<ClienteModel> save(ClienteModel cliente) async {
    final Database db = await AppDatabase.database;

    if (cliente.codigoCliente == null) {
      final novoCodigo = await db.insert(clienteTableName, cliente.toMap());
      return cliente.copyWith(codigoCliente: novoCodigo);
    } else {
      await db.update(
        clienteTableName,
        cliente.toMap(),
        where: 'codigo_cliente = ?',
        whereArgs: [cliente.codigoCliente],
      );
      return cliente;
    }
  }

  @override
  Future<bool> existsByCpfAndIe(
    String cpfCnpj,
    String ieRg,
    int? codigoCliente,
  ) async {
    final Database db = await AppDatabase.database;
    final List<Map<String, dynamic>> result;

    if (codigoCliente == null) {
      result = await db.query(
        clienteTableName,
        where: "cnpj_cpf = ? AND ie_rg = ?",
        whereArgs: [cpfCnpj, ieRg],
        limit: 1,
      );
    } else {
      result = await db.query(
        clienteTableName,
        where: "cnpj_cpf = ? AND ie_rg = ? AND codigo_cliente != ?",
        whereArgs: [cpfCnpj, ieRg, codigoCliente],
        limit: 1,
      );
    }

    return result.isNotEmpty;
  }
}
