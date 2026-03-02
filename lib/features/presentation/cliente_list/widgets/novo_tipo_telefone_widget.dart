import 'package:clean_arch/core/injection/injection.dart';
import 'package:clean_arch/features/presentation/cliente_list/cubit/TipoTelefone/tipo_telefone_list_cubit.dart';
import 'package:clean_arch/features/tipotelefone/domain/entities/tipo_telefone_entity.dart';
import 'package:flutter/material.dart';

class NovoTipoTelefoneWidget extends StatefulWidget {
  const NovoTipoTelefoneWidget({super.key});

  @override
  State<NovoTipoTelefoneWidget> createState() => _NovoTipoTelefoneWidgetState();
}

class _NovoTipoTelefoneWidgetState extends State<NovoTipoTelefoneWidget> {
  final formModalKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final cubitTipoTelefone = getIt<TipoTelefoneListCubit>();

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
                "Cadastrar um novo tipo de telefone",
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

                  if (cubitTipoTelefone.listaTipoTelefones.any(
                    (tipo) =>
                        tipo.descricao.toLowerCase() ==
                        descricaoController.text.toLowerCase().trim(),
                  )) {
                    return "Este tipo já foi cadastrado";
                  }

                  TipoTelefoneEntity tipoTelefoneEntity = TipoTelefoneEntity(
                    descricao: descricaoController.text.trim(),
                  );

                  cubitTipoTelefone.save(tipoTelefoneEntity);

                  return null;
                },
              ),

              const SizedBox(height: 44),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
