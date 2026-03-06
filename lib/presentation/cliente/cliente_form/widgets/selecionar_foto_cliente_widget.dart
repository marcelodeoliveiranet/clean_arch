import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelecionarFotoClienteWidget extends StatefulWidget {
  final File? fotoCliente;
  final Function(File fotoSelecionada) onFotoSelecionada;

  const SelecionarFotoClienteWidget({
    super.key,
    required this.fotoCliente,
    required this.onFotoSelecionada,
  });

  @override
  State<SelecionarFotoClienteWidget> createState() =>
      _SelecionarFotoClienteWidgetState();
}

class _SelecionarFotoClienteWidgetState
    extends State<SelecionarFotoClienteWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> selecionarFoto(ImageSource source) async {
    final XFile? imagem = await _picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (imagem != null) {
      setState(() {
        widget.onFotoSelecionada(File(imagem.path));
      });
    }
  }

  Future<void> mostrarOpcoesFoto() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Camera"),
                onTap: () async {
                  Navigator.pop(context);
                  selecionarFoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Galeria"),
                onTap: () async {
                  Navigator.pop(context);
                  selecionarFoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: mostrarOpcoesFoto,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            backgroundImage:
                widget.fotoCliente != null
                    ? FileImage(widget.fotoCliente!)
                    : null,
            child:
                widget.fotoCliente == null
                    ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                    : null,
          ),
        ),

        SizedBox(width: 10),

        TextButton.icon(
          onPressed: mostrarOpcoesFoto,
          icon: const Icon(Icons.photo),
          label: const Text("Selecionar foto"),
        ),

        Divider(),
      ],
    );
  }
}
