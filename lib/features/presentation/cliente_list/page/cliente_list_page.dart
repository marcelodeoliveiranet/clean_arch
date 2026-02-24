import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local_imp.dart';
import 'package:clean_arch/features/clientes/data/repositories/cliente_repository_imp.dart';
import 'package:clean_arch/features/clientes/domain/usecases/delete_cliente_uses_case.dart';
import 'package:clean_arch/features/clientes/domain/usecases/get_clientes_use_case.dart';
import 'package:clean_arch/features/clientes/domain/usecases/save_cliente_use_case.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cliente/cliente_list_cuibit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cliente/cliente_list_state.dart';
import 'package:clean_arch/features/presentation/cliente_list/page/cliente_cadastro_page.dart';
import 'package:clean_arch/features/presentation/cliente_list/widgets/render_clientes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClienteListPage extends StatefulWidget {
  const ClienteListPage({super.key});

  @override
  State<ClienteListPage> createState() => _ClienteListPageState();
}

class _ClienteListPageState extends State<ClienteListPage> {
  final cubit = ClienteListCuibit(
    GetClientesUseCase(
      clienteRepository: ClienteRepositoryImp(
        clienteDatasourceLocal: ClienteDatasourceLocalImp(),
      ),
    ),
    DeleteClienteUsesCase(
      clienteRepository: ClienteRepositoryImp(
        clienteDatasourceLocal: ClienteDatasourceLocalImp(),
      ),
    ),
    SaveClienteUseCase(
      clienteRepository: ClienteRepositoryImp(
        clienteDatasourceLocal: ClienteDatasourceLocalImp(),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    cubit.load("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 35, left: 8, right: 8),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Consulta de Clientes",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            TextField(
              onChanged: (value) {
                cubit.load(value);
              },
              decoration: InputDecoration(
                hintText: "Busca por razao social",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color.fromARGB(255, 2, 63, 7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<ClienteListCuibit, ClienteListState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is ClienteListLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ClienteListSucess) {
                    return RenderClientesWidget(
                      clientes: state.clientes,
                      cubit: cubit,
                    );
                  } else if (state is ClienteListError) {
                    return Center(child: Text(state.error));
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClienteCadastroPage(isEditing: false),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 2, 63, 7),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
