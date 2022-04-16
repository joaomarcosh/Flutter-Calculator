import 'package:flutter/material.dart';

class Tela2 extends StatefulWidget {
  const Tela2({Key? key}) : super(key: key);

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("Calculadora 2"),
      ),
      drawer: Drawer(
        child: ElevatedButton(
          child: Text("Calculadora Padrão"),
          onPressed: () { Navigator.pushNamed(context, "/calcPadrao");
            debugPrint("testt");},
        ),
      ),
    );
  }
}