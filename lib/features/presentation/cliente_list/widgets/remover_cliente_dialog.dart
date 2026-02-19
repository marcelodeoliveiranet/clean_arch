import 'package:clean_arch/features/clientes/data/datasources/cliente_datasource_local_imp.dart';
import 'package:clean_arch/features/clientes/data/repositories/cliente_repository_imp.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/clientes/domain/usecases/delete_cliente_uses_case.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_delete_cubit.dart';
import 'package:flutter/material.dart';

class RemoverClienteDialog extends StatelessWidget {
  RemoverClienteDialog({super.key, required this.cliente});
  final ClienteEntity cliente;

  final cubit = ClienteDeleteCubit(
    deleteClienteUsesCase: DeleteClienteUsesCase(
      clienteRepository: ClienteRepositoryImp(
        clienteDatasourceLocal: ClienteDatasourceLocalImp(),
      ),
    ),
  );

  Future<void> excluirCliente() async {
    await cubit.delete(cliente);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Você deseja remover esse cliente?",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(),
              child: Text("Cancelar", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                excluirCliente();
              },
              child: Text("Excluir", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }
}
