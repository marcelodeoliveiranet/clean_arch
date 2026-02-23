// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch/features/presentation/cliente_list/cubit/Cliente/cliente_list_cuibit.dart';
import 'package:clean_arch/features/presentation/cliente_list/widgets/cliente_card.dart';
import 'package:flutter/material.dart';
import 'package:clean_arch/features/clientes/domain/entities/cliente_entity.dart';

class RenderClientesWidget extends StatelessWidget {
  final List<ClienteEntity> clientes;
  final ClienteListCuibit cubit;

  const RenderClientesWidget({
    Key? key,
    required this.clientes,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clientes.length,
      itemBuilder: (context, index) {
        return ClienteCard(cliente: clientes[index], cubit: cubit);
      },
    );
  }
}
