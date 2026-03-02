import 'package:clean_arch/core/injection/injection.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/RamoAtividade/ramo_atividade_list_cubit.dart';
import 'package:clean_arch/features/ramoatividade/domain/entities/ramo_atividade_entity.dart';
import 'package:flutter/material.dart';

class NovoRamoAtividadeWidget extends StatefulWidget {
  const NovoRamoAtividadeWidget({super.key});

  @override
  State<NovoRamoAtividadeWidget> createState() =>
      _NovoRamoAtividadeWidgetState();
}

class _NovoRamoAtividadeWidgetState extends State<NovoRamoAtividadeWidget> {
  final formModalKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final cubitRamoAtividade = getIt<RamoAtividadeListCuibit>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: formModalKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cadastrar um novo ramo de atividade",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              TextFormField(
                autofocus: true,
                controller: descricaoController,
                decoration: InputDecoration(
                  labelText: "Descrição",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Informe a descrição";
                  }

                  if (cubitRamoAtividade.listaRamoAtividade.any(
                    (ramo) =>
                        ramo.descricao.toLowerCase() ==
                        descricaoController.text.toLowerCase().trim(),
                  )) {
                    return "Este ramo já foi cadastrado";
                  }

                  RamoAtividadeEntity ramo = RamoAtividadeEntity(
                    descricao: descricaoController.text.trim(),
                  );
                  cubitRamoAtividade.save(ramo);

                  return null;
                },
              ),

              const SizedBox(height: 44),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text("Cancelar"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final isVaid =
                            formModalKey.currentState?.validate() ?? false;

                        if (!isVaid) {
                          return;
                        }

                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Gravar"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
