import 'package:clean_arch/core/database/app_database.dart';
import 'package:clean_arch/core/database/tables/cliente.dart';
import 'package:clean_arch/core/database/tables/ramo_atividade.dart';
import 'package:clean_arch/core/database/tables/tipo_telefone.dart';
import 'package:clean_arch/core/injection/injection.dart';
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local_imp.dart';
import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';
import 'package:clean_arch/features/presentation/cliente_list/page/cliente_list_page.dart';
import 'package:clean_arch/features/ramoatividade/data/datasources/ramo_atividade_datasorce_local_imp.dart';
import 'package:clean_arch/features/ramoatividade/data/models/ramo_atividade_model.dart';
import 'package:clean_arch/features/tipotelefone/data/datasource/tipo_telefone_datasource_local_imp.dart';
import 'package:clean_arch/features/tipotelefone/data/models/tipo_telefone_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

Future<void> exibirEstruturaTabela(Database db, String nomeTabela) async {
  var columns = await db.rawQuery("PRAGMA table_info($nomeTabela)");

  debugPrint("");
  debugPrint("Colunas da tabela: $nomeTabela");
  debugPrint("===============================");

  String pk = "False";

  for (var column in columns) {
    if (column["pk"] == 1) {
      pk = "True ";
    } else {
      pk = "False";
    }

    debugPrint(
      "Campo PK: $pk | Coluna: ${column['name']} | Tipo:${column['type']}",
    );
  }

  final fks = await db.rawQuery("PRAGMA foreign_key_list($nomeTabela)");

  if (fks.isNotEmpty) {
    debugPrint("");
    debugPrint("Foreign Keys");
    debugPrint("============");

    for (var row in fks) {
      print(row);
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final db = await AppDatabase.database;

  // await exibirEstruturaTabela(db, clienteTableName);
  // await exibirEstruturaTabela(db, ramoAtividadeTableName);
  // await exibirEstruturaTabela(db, tipoTelefoneTableName);

  // TipoTelefoneDatasourceLocalImp tipoTelefoneDataSource =
  //     TipoTelefoneDatasourceLocalImp();

  // TipoTelefoneModel tipoTelefone = TipoTelefoneModel(descricao: "Celular");
  // await tipoTelefoneDataSource.save(tipoTelefone);

  // RamoAtividadeDatasorceLocalImp ramoAtividadeDatasorceLocalImp =
  //     RamoAtividadeDatasorceLocalImp();

  // RamoAtividadeModel ramo = RamoAtividadeModel(
  //   codigo: null,
  //   descricao: "Atacado",
  // );
  // await ramoAtividadeDatasorceLocalImp.save(ramo);

  // ClienteDatasourceLocalImp clienteDatasourceLocalImp =
  //     ClienteDatasourceLocalImp();

  // ClienteModel cliente = ClienteModel(
  //   foto: "",
  //   codigoCliente: null,
  //   razaoSocial: "Marcelo de Oliveira",
  //   nomeFantasia: "Marcelo de Oliveira",
  //   codigoRamoAtividade: 1,
  //   cnpjCpf: "111.615.378-56",
  //   tipoPessoa: "F",
  //   ieRg: "15.793.623",
  //   inscricaoMunicipal: "",
  //   email: "marcelosdeoliveiras@gmail.com",
  //   homePage: "",
  //   cep: "05134-000",
  //   logradouro: "Rua Manoel Martins da Rocha",
  //   numero: "571",
  //   complemento: "Casa",
  //   bairro: "Vila Guedes",
  //   municipio: "São Paulo",
  //   codigoIbgeMunicipio: 123456,
  //   uf: "SP",
  //   codigoTipoTelefone1: 1,
  //   telefone1: "(11) 9 7119-4051",
  //   complementoTelefone1: "",
  //   dataCadastro: "",
  // );

  // await clienteDatasourceLocalImp.save(cliente);

  // cliente = ClienteModel(
  //   foto: "",
  //   codigoCliente: null,
  //   razaoSocial: "Marcos de Oliveira",
  //   nomeFantasia: "Marcos de Oliveira",
  //   codigoRamoAtividade: 1,
  //   cnpjCpf: "47.685.926/0001-21",
  //   tipoPessoa: "J",
  //   ieRg: "147.971.927.976",
  //   inscricaoMunicipal: "",
  //   email: "marcosdeoliveiras@gmail.com",
  //   homePage: "",
  //   cep: "05134-000",
  //   logradouro: "Rua Manoel Martins da Rocha",
  //   numero: "571",
  //   complemento: "Casa",
  //   bairro: "Vila Guedes",
  //   municipio: "São Paulo",
  //   codigoIbgeMunicipio: 123456,
  //   uf: "SP",
  //   codigoTipoTelefone1: 1,
  //   telefone1: "(11) 9 6136-5214",
  //   complementoTelefone1: "",
  //   dataCadastro: "",
  // );

  // await clienteDatasourceLocalImp.save(cliente);

  // cliente = ClienteModel(
  //   foto: "",
  //   codigoCliente: null,
  //   razaoSocial: "Claudio Elias de Oliveira",
  //   nomeFantasia: "Claudio Elias de Oliveira",
  //   codigoRamoAtividade: 1,
  //   cnpjCpf: "111.615.378-56",
  //   tipoPessoa: "F",
  //   ieRg: "15.793.623",
  //   inscricaoMunicipal: "",
  //   email: "claudioeliasdeoliveiras@gmail.com",
  //   homePage: "",
  //   cep: "05134-000",
  //   logradouro: "Rua Manoel Martins da Rocha",
  //   numero: "571",
  //   complemento: "Casa",
  //   bairro: "Vila Guedes",
  //   municipio: "São Paulo",
  //   codigoIbgeMunicipio: 123456,
  //   uf: "SP",
  //   codigoTipoTelefone1: 1,
  //   telefone1: "(11) 9 6136-5214",
  //   complementoTelefone1: "",
  //   dataCadastro: "",
  // );

  // await clienteDatasourceLocalImp.save(cliente);

  // cliente = ClienteModel(
  //   foto: "",
  //   codigoCliente: null,
  //   razaoSocial: "Rodrigo Sandor Rodrigues de Oliveira",
  //   nomeFantasia: "Rodrigo Sandor Rodrigues de Oliveira",
  //   codigoRamoAtividade: 1,
  //   cnpjCpf: "111.615.378-56",
  //   tipoPessoa: "F",
  //   ieRg: "15.793.623",
  //   inscricaoMunicipal: "",
  //   email: "rodrigosrdeoliveiras@gmail.com",
  //   homePage: "",
  //   cep: "05134-000",
  //   logradouro: "Rua Manoel Martins da Rocha",
  //   numero: "571",
  //   complemento: "Casa",
  //   bairro: "Vila Guedes",
  //   municipio: "São Paulo",
  //   codigoIbgeMunicipio: 123456,
  //   uf: "SP",
  //   codigoTipoTelefone1: 1,
  //   telefone1: "(11) 9 6136-5214",
  //   complementoTelefone1: "",
  //   dataCadastro: "",
  // );

  // await clienteDatasourceLocalImp.save(cliente);

  // cliente = ClienteModel(
  //   foto: "",
  //   codigoCliente: null,
  //   razaoSocial: "Rebeca Sandor Rodrigues de Oliveira",
  //   nomeFantasia: "Rebeca Sandor Rodrigues de Oliveira",
  //   codigoRamoAtividade: 1,
  //   cnpjCpf: "111.615.378-56",
  //   tipoPessoa: "F",
  //   ieRg: "15.793.623",
  //   inscricaoMunicipal: "",
  //   email: "rebecasrdeoliveiras@gmail.com",
  //   homePage: "",
  //   cep: "05134-000",
  //   logradouro: "Rua Manoel Martins da Rocha",
  //   numero: "571",
  //   complemento: "Casa",
  //   bairro: "Vila Guedes",
  //   municipio: "São Paulo",
  //   codigoIbgeMunicipio: 123456,
  //   uf: "SP",
  //   codigoTipoTelefone1: 1,
  //   telefone1: "(11) 9 6136-5214",
  //   complementoTelefone1: "",
  //   dataCadastro: "",
  // );

  // await clienteDatasourceLocalImp.save(cliente);

  // cliente = ClienteModel(
  //   foto: "",
  //   codigoCliente: null,
  //   razaoSocial: "Rosalina Maria de Jesus de Oliveira",
  //   nomeFantasia: "Rosalina Maria de Jesus de Oliveira",
  //   codigoRamoAtividade: 1,
  //   cnpjCpf: "86.924.544/0001-65",
  //   tipoPessoa: "J",
  //   ieRg: "464.521.956.107",
  //   inscricaoMunicipal: "",
  //   email: "rosalinamjdeoliveiras@gmail.com",
  //   homePage: "",
  //   cep: "05134-000",
  //   logradouro: "Rua Manoel Martins da Rocha",
  //   numero: "571",
  //   complemento: "Casa",
  //   bairro: "Vila Guedes",
  //   municipio: "São Paulo",
  //   codigoIbgeMunicipio: 123456,
  //   uf: "SP",
  //   codigoTipoTelefone1: 1,
  //   telefone1: "(11) 9 6136-5214",
  //   complementoTelefone1: "",
  //   dataCadastro: "",
  // );

  // await clienteDatasourceLocalImp.save(cliente);
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: ClienteListPage(),
    );
  }
}
