import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local_imp.dart';
import 'package:clean_arch/features/clientes/data/repositories/cliente_repository_imp.dart';
import 'package:clean_arch/features/clientes/domain/usecases/get_clientes_use_case.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_list_cuibit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_list_state.dart';
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
  );

  @override
  void initState() {
    super.initState();
    cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClienteListCuibit, ClienteListState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is ClienteListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ClienteListSucess) {
            return RenderClientesWidget(clientes: state.clientes);
          } else if (state is ClienteListError) {
            return Center(child: Text(state.error));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
