import 'package:flutter/material.dart';

class BotaoSimples extends StatelessWidget {
  final String texto;
  final Color? cor;
  final Function() funcao;

  const BotaoSimples(this.texto, this.cor, this.funcao, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: funcao,
      child: Text(texto, style: const TextStyle(fontSize: 16)),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(cor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder())),
    );
  }
}
