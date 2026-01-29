import 'package:clean_arch/core/database/app_database.dart';
import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local_imp.dart';
import 'package:clean_arch/features/ramoatividade/data/datasources/ramo_atividade_datasorce_local_imp.dart';
import 'package:clean_arch/features/clientes/data/models/cliente_model.dart';
import 'package:clean_arch/features/ramoatividade/data/models/ramo_atividade_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

Future<void> exibirEstruturaTabela(Database db, String nomeTabela) async {
  var columns = await db.rawQuery("PRAGMA table_info($nomeTabela)");

  print("");
  print("Colunas da tabela: $nomeTabela");
  print("===============================");

  for (var column in columns) {
    if (column["pk"] == 1) {
      print(
        "Campo PK: True  | Coluna: ${column['name']} | Tipo:${column['type']}",
      );
    } else {
      print(
        "Campo PK: False | Coluna: ${column['name']} | Tipo:${column['type']}",
      );
    }
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

  await exibirEstruturaTabela(db, "CLIENTE");
  await exibirEstruturaTabela(db, "RAMOATIVIDADE");

  final RamoAtividadeDatasorceLocalImp dsRamoAtividade =
      RamoAtividadeDatasorceLocalImp();

  RamoAtividadeModel ramoAtividadeModel = RamoAtividadeModel(
    descricaoRamoAtividade: "Atacado",
  );

  await dsRamoAtividade.save(ramoAtividadeModel);
  final ramoAtividades = await dsRamoAtividade.get();
  print(ramoAtividades);

  ramoAtividades.forEach((element) => print(element.toMap()));

  final ClienteDatasourceLocalImp ds = ClienteDatasourceLocalImp();

  ClienteModel clienteModel = ClienteModel(
    codigoCliente: null,
    razaoSocial: "Marcelo de Oliveira",
    nomeFantasia: "Marcelo",
    codigoRamoAtividade: 2,
    cnpjCpf: "111",
    tipoPessoa: "F",
    ieRg: "12",
    inscricaoMunicipal: "",
    email: "marcelosdeoliveiras@gmail.com",
    homePage: "",
    cep: "05134-000",
    codigoTipoLogradouro: 1,
    logradouro: "Rua tal",
    numero: "571",
    complemento: "",
    bairro: "Vila Guedes",
    municipio: "São Paulo",
    codigoIbgeMunicipio: 123456,
    uf: "SP",
  );

  await ds.save(clienteModel);

  final clientes = await ds.get();
  print(clientes);

  //await ds.delete(clientes.last);
  print(await ds.get());

  clientes.forEach((element) => print(element.toMap()));

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
