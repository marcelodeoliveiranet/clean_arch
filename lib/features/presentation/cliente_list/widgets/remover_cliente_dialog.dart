import 'package:flutter/material.dart';

class RemoverClienteDialog extends StatelessWidget {
  const RemoverClienteDialog({super.key});

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
              },
              child: Text("Excluir", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }
}
