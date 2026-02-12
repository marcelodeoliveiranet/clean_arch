// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';

class RenderClientesWidget extends StatelessWidget {
  final List<ClienteEntity> clientes;

  const RenderClientesWidget({Key? key, required this.clientes})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clientes.length,
      itemBuilder: (context, index) {
        return Text(clientes[index].razaoSocial);
      },
    );
  }
}
