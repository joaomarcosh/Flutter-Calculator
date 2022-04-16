//import 'dart:html';
//import 'dart:ui';

import 'package:flutter/material.dart';
import "botoes.dart";
import "calc2.dart";

void main() => runApp(Calculadora());

class Calculadora extends StatelessWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaPrincipal(),
      theme: ThemeData.dark(),
      routes: {
        "/calc2" : (BuildContext context) => Tela2(),
        "/calcPadrao" : (BuildContext context) => TelaPrincipal()
      },
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  String contaMain = "0";
  String contaSub = "";
  bool isReplaceable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("Calculadora Padrão"),
        //leading: Icon(Icons.calculate_outlined),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.history))],
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      drawer: Drawer(
        child: ElevatedButton(
          child: Text("Calculadora 2"),
          onPressed: (){
            Navigator.pushNamed(context, "/calc2");
          },
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight / 4,
                  child: Column(
                    children: [
                      Align(
                        child: Padding(
                          padding: EdgeInsets.only(top:16,bottom: 8),
                          child: Text(contaSub,style: TextStyle(fontSize: 16),),
                        ),
                        alignment: Alignment(0.95,0),
                      ),Align(
                        child: Text(contaMain,style: TextStyle(fontSize: 48),),
                        alignment: Alignment(0.95,0),
                      ),
                    ],
                  ),
                ),
                GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  childAspectRatio: (6 * constraints.maxWidth - 120) /
                      (3 * constraints.maxHeight - 112),
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  padding: EdgeInsets.all(4),
                  children: [
                    BotaoSimples("%", Colors.black45, () => null),
                    BotaoSimples("CE", Colors.black45, () => null),
                    BotaoSimples("C", Colors.black45, () => null),
                    BotaoSimples("<", Colors.black45, () => null),
                    BotaoSimples("1/x", Colors.black45, () => null),
                    BotaoSimples("x²", Colors.black45, () => null),
                    BotaoSimples("sqrt", Colors.black45, () => null),
                    BotaoSimples("/", Colors.black45, () => null),
                    BotaoSimples("7", Colors.black, () => null),
                    BotaoSimples("8", Colors.black, () => null),
                    BotaoSimples("9", Colors.black, () => null),
                    BotaoSimples("X", Colors.black45, () => null),
                    BotaoSimples("4", Colors.black, () => null),
                    BotaoSimples("5", Colors.black, () => null),
                    BotaoSimples("6", Colors.black, () => null),
                    BotaoSimples("-", Colors.black45, () => null),
                    BotaoSimples("1", Colors.black, () {contaMain+="1";}),
                    BotaoSimples("2", Colors.black, () => null),
                    BotaoSimples("3", Colors.black, () => null),
                    BotaoSimples("+", Colors.black45, () => null),
                    BotaoSimples("+/-", Colors.black, () => null),
                    BotaoSimples("0", Colors.black, () => null),
                    BotaoSimples(",", Colors.black, () => null),
                    BotaoSimples("=", Colors.blue[900], () => null),
                  ],
                ),
              ],
            );
          }),
    );
  }
}

