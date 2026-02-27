import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/cliente_list/cliente_list_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/page/cliente_cadastro_page.dart';
import 'package:clean_arch/features/presentation/cliente_list/widgets/remover_cliente_dialog.dart';
import 'package:flutter/material.dart';

class ClienteCard extends StatelessWidget {
  const ClienteCard({super.key, required this.cliente, required this.cubit});
  final ClienteEntity cliente;
  final ClienteListCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 2, 63, 7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 10,
        children: [
          CircleAvatar(radius: 35, backgroundImage: NetworkImage(cliente.foto)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cliente.razaoSocial,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  cliente.email,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  cliente.telefone1,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          Spacer(),

          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: IntrinsicHeight(
                      child: RemoverClienteDialog(
                        cliente: cliente,
                        cubit: cubit,
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.delete),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ClienteCadastroPage(
                        isEditing: true,
                        cliente: cliente,
                      ),
                ),
              );
            },
            icon: Icon(Icons.edit),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
