import 'package:clean_arch/core/injection/injection.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/RamoAtividade/ramo_atividade_list_cubit.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/RamoAtividade/ramo_atividade_list_state.dart';
import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RamoAtividadeDropdownWidget extends StatefulWidget {
  final RamoAtividadeEntity? ramoAtividadeEntitySelecionado;
  final void Function(RamoAtividadeEntity? value) onChanged;
  const RamoAtividadeDropdownWidget({
    super.key,
    required this.ramoAtividadeEntitySelecionado,
    required this.onChanged,
  });

  @override
  State<RamoAtividadeDropdownWidget> createState() =>
      _RamoAtividadeDropdownWidgetState();
}

class _RamoAtividadeDropdownWidgetState
    extends State<RamoAtividadeDropdownWidget> {
  final cubitRamoAtividade = getIt<RamoAtividadeListCuibit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RamoAtividadeListCuibit, RamoAtividadeListState>(
      bloc: cubitRamoAtividade,
      builder: (context, state) {
        if (state is RamoAtividadeListLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RamoAtividadeListError) {
          return Center(child: Text(state.error));
        } else if (state is RamoAtividadeListSucess) {
          return DropdownButtonFormField<RamoAtividadeEntity>(
            value: widget.ramoAtividadeEntitySelecionado,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.category),
              labelText: "Selecione um ramo atividade",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            isExpanded: true,
            items:
                state.ramos.map((ramo) {
                  return DropdownMenuItem(
                    value: ramo,
                    child: Text(ramo.descricao),
                  );
                }).toList(),
            validator: (value) {
              if (value == null) {
                return "Selecione um ramo de atividade";
              }
              return null;
            },
            onChanged: widget.onChanged,
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
