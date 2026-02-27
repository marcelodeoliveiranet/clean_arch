import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_list/cliente_list_cubit.dart';
import 'package:flutter/material.dart';

class RemoverClienteDialog extends StatelessWidget {
  const RemoverClienteDialog({
    super.key,
    required this.cliente,
    required this.cubit,
  });
  final ClienteEntity cliente;
  final ClienteListCubit cubit;

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
                cubit.delete(cliente);
              },
              child: Text("Excluir", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }
}
