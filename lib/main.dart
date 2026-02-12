import 'package:clean_arch/core/database/app_database.dart';
import 'package:clean_arch/core/database/tables/cliente.dart';
import 'package:clean_arch/core/database/tables/ramo_atividade.dart';
import 'package:clean_arch/core/database/tables/tipo_logradouro.dart';
import 'package:clean_arch/core/database/tables/tipo_telefone.dart';
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local.dart';
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local_imp.dart';
import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';
import 'package:clean_arch/features/presentation/cliente_list/page/cliente_list_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

Future<void> exibirEstruturaTabela(Database db, String nomeTabela) async {
  var columns = await db.rawQuery("PRAGMA table_info($nomeTabela)");

  print("");
  print("Colunas da tabela: $nomeTabela");
  print("===============================");

  String pk = "False";

  for (var column in columns) {
    if (column["pk"] == 1) {
      pk = "True ";
    } else {
      pk = "False";
    }

    print("Campo PK: $pk | Coluna: ${column['name']} | Tipo:${column['type']}");
  }

  final fks = await db.rawQuery("PRAGMA foreign_key_list($nomeTabela)");

  if (fks.isNotEmpty) {
    print("");
    print("Foreign Keys");
    print("============");

    for (var row in fks) {
      print(row);
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await AppDatabase.database;

  await exibirEstruturaTabela(db, clienteTableName);
  await exibirEstruturaTabela(db, ramoAtividadeTableName);
  await exibirEstruturaTabela(db, tipoLogradouroTableName);
  await exibirEstruturaTabela(db, tipoTelefoneTableName);

  ClienteDatasourceLocalImp clienteDatasourceLocalImp =
      ClienteDatasourceLocalImp();

  ClienteModel cliente = ClienteModel(
    foto: "",
    codigoCliente: null,
    razaoSocial: "Marcelo",
    nomeFantasia: "Marcelo",
    codigoRamoAtividade: 1,
    cnpjCpf: "",
    tipoPessoa: "F",
    ieRg: "",
    inscricaoMunicipal: "",
    email: "",
    homePage: "",
    cep: "",
    codigoTipoLogradouro: 1,
    logradouro: "",
    numero: "",
    complemento: "",
    bairro: "",
    municipio: "",
    codigoIbgeMunicipio: 123456,
    uf: "SP",
    codigoTipoTelefone1: 1,
    telefone1: "",
    codigoTipoTelefone2: 1,
    complementoTelefone1: "",
    telefone2: "",
    complementoTelefone2: "",
    dataCadastro: "",
  );

  clienteDatasourceLocalImp.save(cliente);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ClienteListPage(),
    );
  }
}
