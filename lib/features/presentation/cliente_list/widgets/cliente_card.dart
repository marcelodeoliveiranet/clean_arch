import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';
import 'package:clean_arch/features/presentation/cliente_list/widgets/remover_cliente_dialog.dart';
import 'package:flutter/material.dart';

class ClienteCard extends StatelessWidget {
  const ClienteCard({super.key, required this.cliente});

  final ClienteEntity cliente;

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
          Column(
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

          Spacer(),

          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: IntrinsicHeight(child: RemoverClienteDialog()),
                  );
                },
              );
            },
            icon: Icon(Icons.delete),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
