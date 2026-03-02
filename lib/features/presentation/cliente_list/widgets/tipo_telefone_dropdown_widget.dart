import 'package:clean_arch/core/injection/injection.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/TipoTelefone/tipo_telefone_list_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/TipoTelefone/tipo_telefone_list_state.dart';
import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipoTelefoneDropdownWidget extends StatefulWidget {
  final TipoTelefoneEntity? tipoTelefoneEntitySelecionado;
  final void Function(TipoTelefoneEntity? value) onChanged;
  const TipoTelefoneDropdownWidget({
    super.key,
    required this.tipoTelefoneEntitySelecionado,
    required this.onChanged,
  });

  @override
  State<TipoTelefoneDropdownWidget> createState() =>
      _TipoTelefoneDropdownWidgetState();
}

class _TipoTelefoneDropdownWidgetState
    extends State<TipoTelefoneDropdownWidget> {
  final cubitTipoTelefone = getIt<TipoTelefoneListCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TipoTelefoneListCubit, TipoTelefoneListState>(
      bloc: cubitTipoTelefone,
      builder: (context, state) {
        if (state is TipoTelefoneListLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TipoTelefoneListError) {
          return Center(child: Text(state.error));
        } else if (state is TipoTelefoneListSucess) {
          return DropdownButtonFormField<TipoTelefoneEntity>(
            value: widget.tipoTelefoneEntitySelecionado,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.category),
              labelText: "Selecione um tipo telefone",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            isExpanded: true,
            items:
                state.tipos.map((tipo) {
                  return DropdownMenuItem(
                    value: tipo,
                    child: Text(tipo.descricao),
                  );
                }).toList(),
            onChanged: widget.onChanged,
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
