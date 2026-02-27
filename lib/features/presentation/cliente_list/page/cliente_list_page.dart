import 'package:clean_arch/core/injection/injection.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_form/cliente_form_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_form/cliente_form_state.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_list/cliente_list_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_list/cliente_list_state.dart';
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
  final cubitCliente = getIt<ClienteListCubit>();
  final cubitFormCliente = getIt<ClienteFormCubit>();
  final procurarPorController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cubitCliente.load("");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClienteFormCubit, ClienteFormState>(
      bloc: cubitFormCliente,
      listener: (context, state) {
        if (state is ClienteFormSucessEdit ||
            state is ClienteFormSucessInsert) {
          cubitCliente.load(procurarPorController.text.trim());
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 35, left: 8, right: 8),
          child: Form(
            key: formKey,
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
                  onSubmitted: (value) {
                    cubitCliente.load(value);
                  },
                  controller: procurarPorController,
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
                  child: BlocBuilder<ClienteListCubit, ClienteListState>(
                    bloc: cubitCliente,
                    builder: (context, state) {
                      if (state is ClienteListLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ClienteListSucess) {
                        return RenderClientesWidget(
                          clientes: state.clientes,
                          cubit: cubitCliente,
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
      ),
    );
  }
}
