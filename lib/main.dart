//import 'dart:html';
//import 'dart:ui';

import 'dart:math';

import 'package:flutter/material.dart';

import "botoes.dart";
import "history.dart";

void main() => runApp(const Calculadora());

class Calculadora extends StatelessWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TelaPrincipal(),
      theme: ThemeData.dark(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  Color corBotaoNumerico = const Color.fromRGBO(6, 6, 6, 1); //Colors.black;
  Color corBotaoOperacao =
      const Color.fromRGBO(19, 19, 19, 1); //Colors.black45;
  Color corBotaoIgual =
      const Color.fromRGBO(19, 67, 105, 1); //Colors.blue[900]!;
  Color corBackground = const Color.fromRGBO(31, 31, 31, 1); //Colors.black87;
  String contaMain = "0";
  String contaSub = " ";
  String operacao = "";
  double valorMain = 0;
  double valorSub1 = 0;
  double valorSub2 = 0;
  bool isReplaceable = true;
  bool wasEqualPressed = false;
  List<HistoryEntry> historyList = [];
  double screenHeight = 0;

  // void botaoNum(String botao) {
  //   setState(() {
  //     if (botao != "," && canPrintMore()) {
  //       contaMain = isReplaceable ? botao : contaMain + botao;
  //     }
  //     if (botao == "," && canPrintMore()) {
  //       if (isReplaceable == true) {
  //         contaMain = "0,";
  //       } else if (!contaMain.contains(",")) {
  //         contaMain += ",";
  //       }
  //     }
  //     if (botao != "0") {
  //       isReplaceable = false;
  //     }
  //     if (wasEqualPressed) {
  //       contaSub = " ";
  //       operacao = "";
  //     }
  //     wasEqualPressed = false;
  //   });
  // }

  void botaoNum(String botao) {
    switch (botao) {
      case "0":
      case "1":
      case "2":
      case "3":
      case "4":
      case "5":
      case "6":
      case "7":
      case "8":
      case "9":
        setState(() {
          if (canPrintMore()) {
            contaMain = isReplaceable ? botao : contaMain + botao;
          }
        });
        if ("123456789".contains(botao)) isReplaceable = false;
        break;
      case ",":
        setState(() {
          if (isReplaceable == true) {
            contaMain = "0,";
          } else if (!contaMain.contains(",")) {
            contaMain += ",";
          }
        });
        break;
    }
    if (botao != "0") {
      isReplaceable = false;
    }
    if (wasEqualPressed) {
      contaSub = " ";
      operacao = "";
    }
    wasEqualPressed = false;
  }

  void botaoLimpa(String botao) {
    setState(() {
      switch (botao) {
        case "C":
          contaSub = " ";
          valorSub1 = valorSub2 = 0;
          operacao = "";
          continue CE;
        CE:
        case "CE":
          contaMain = "0";
          valorMain = 0;
          isReplaceable = true;
          wasEqualPressed = false;
          break;
        case "<":
          if (contaMain.length > 1) {
            contaMain = contaMain.substring(0, contaMain.length - 1);
            if (contaMain == "0") isReplaceable = true;
          } else {
            contaMain = "0";
            isReplaceable = true;
          }
          break;
      }
    });
  }

  void botaoInvert() {
    setState(() {
      if (contaMain != "0") {
        if (!contaMain.contains("-")) {
          contaMain = "-" + contaMain;
        } else {
          contaMain = contaMain.replaceAll("-", "");
        }
      }
    });
  }

  void operacaoBasica(String botao) {
    operacao = botao;
    valorSub1 = valorMain = valorReal(contaMain);
    setState(() {
      contaSub = valorAparente(valorSub1) + " $botao ";
    });
    isReplaceable = true;
    wasEqualPressed = false;
  }

  void operacaoAvancada(String botao) {
    operacao = botao;
    valorMain = valorReal(contaMain);
    valorSub1 = valorMain;
    switch (operacao) {
      case "sqr":
        valorMain *= valorMain;
        setState(() {
          contaSub = "sqr( " + valorAparente(valorSub1) + " )";
          contaMain = valorAparente(valorMain);
        });
        break;
      case "sqrt":
        valorMain = sqrt(valorMain);
        setState(() {
          contaSub = "sqrt( " + valorAparente(valorSub1) + " )";
          contaMain = valorAparente(valorMain);
        });
        break;
      case "1/x":
        valorMain = 1 / valorMain;
        setState(() {
          contaSub = "1/( " + valorAparente(valorSub1) + " )";
          contaMain = valorAparente(valorMain);
        });
        break;
    }
    fixNumberSize();
    historyList.insert(
        0,
        HistoryEntry(
          valor1: valorAparente(valorSub1),
          valor2: valorAparente(valorSub2),
          valorMain: valorAparente(valorMain),
          operacao: operacao,
        ));
    if (historyList.length > 20) historyList.removeAt(20);
    isReplaceable = true;
  }

  void botaoPorcentagem() {
    if (["+", "-", "x", "/"].contains(operacao)) {
      valorMain = valorReal(contaMain);
      valorMain = valorSub1 * valorMain / 100;
      valorSub2 = valorMain;
      setState(() {
        contaSub = valorAparente(valorSub1) +
            " $operacao " +
            valorAparente(valorSub2) +
            " =";
        contaMain = valorAparente(valorMain);
      });
    }
  }

  void botaoIgual() {
    if (!wasEqualPressed) {
      valorSub2 = valorMain = valorReal(contaMain);
      wasEqualPressed = true;
    } else {
      valorSub1 = valorMain;
    }
    switch (operacao) {
      case "+":
        valorMain = valorSub1 + valorSub2;
        break;
      case "-":
        valorMain = valorSub1 - valorSub2;
        break;
      case "x":
        valorMain = valorSub1 * valorSub2;
        break;
      case "/":
        valorMain = valorSub1 / valorSub2;
        break;
    }
    fixNumberSize();
    if (!["", "sqr", "sqrt", "1/x"].contains(operacao)) {
      setState(() {
        contaSub = valorAparente(valorSub1) +
            " $operacao " +
            valorAparente(valorSub2) +
            " =";
        contaMain = valorAparente(valorMain);
      });
    }
    if (contaSub != "" && ["+", "-", "x", "/"].contains(operacao)) {
      historyList.insert(
          0,
          HistoryEntry(
            valor1: valorAparente(valorSub1),
            valor2: valorAparente(valorSub2),
            valorMain: valorAparente(valorMain),
            operacao: operacao,
          ));
      if (historyList.length > 20) historyList.removeAt(20);
    }
    isReplaceable = true;
  }

  double valorReal(String numero) {
    return double.parse(numero.replaceAll(",", "."));
  }

  String valorAparente(double numero) {
    return numero.toString().replaceAll(".", ",");
  }

  bool canPrintMore() {
    String preVirgula = "";
    String posVirgula = "";

    if (isReplaceable) return true;
    if (contaMain.contains(",")) {
      preVirgula = contaMain.split(",")[0];
      posVirgula = contaMain.split(",")[1];
    } else {
      preVirgula = contaMain;
    }
    if (contaMain.startsWith("0,") && posVirgula.length < 16) {
      return true;
    } else if (preVirgula.length + posVirgula.length < 16) {
      return true;
    }
    return false;
  }

  void fixNumberSize() {
    String preVirgula = "";
    String posVirgula = "";

    if (contaMain.contains(",")) {
      preVirgula = contaMain.split(",")[0];
      posVirgula = contaMain.split(",")[1];
    } else {
      preVirgula = contaMain;
    }
    if (preVirgula.length + posVirgula.length > 16) {
      contaMain = valorReal(contaMain).toStringAsExponential(15);
      contaMain = contaMain.replaceAll(".", ",");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corBackground,
      appBar: AppBar(
        title: const Text("Calculadora Padrão"),
        //leading: Icon(Icons.calculate_outlined),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              //Navigator.pushNamed(context, "/a");
              final Future futuro = Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false, // set to false
                  pageBuilder: (_, __, ___) =>
                      Historico(historyList, screenHeight),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
              futuro.then((contaHistorico) {
                if (contaHistorico != null) {
                  setState(() {
                    contaSub = contaHistorico[0];
                    contaMain = contaHistorico[1];
                  });
                }
              });
            },
          )
        ],
        backgroundColor: corBackground,
        elevation: 0,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        screenHeight = constraints.maxHeight;
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight / 12,
                      width: constraints.maxWidth,
                      child: Align(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: FittedBox(
                            child: Text(
                              contaSub,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight / 6,
                      width: constraints.maxWidth,
                      child: Align(
                        child: FittedBox(
                            child: Text(
                          contaMain,
                          style: const TextStyle(fontSize: 48),
                        )),
                        alignment: Alignment.topRight,
                      ),
                    ),
                  ],
                ),
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
              padding: const EdgeInsets.all(4),
              children: [
                BotaoSimples("%", corBotaoOperacao, () => botaoPorcentagem()),
                BotaoSimples("CE", corBotaoOperacao, () => botaoLimpa("CE")),
                BotaoSimples("C", corBotaoOperacao, () => botaoLimpa("C")),
                BotaoSimples("<", corBotaoOperacao, () => botaoLimpa("<")),
                BotaoSimples(
                    "1/x", corBotaoOperacao, () => operacaoAvancada("1/x")),
                BotaoSimples(
                    "x²", corBotaoOperacao, () => operacaoAvancada("sqr")),
                BotaoSimples(
                    "√x", corBotaoOperacao, () => operacaoAvancada("sqrt")),
                BotaoSimples("/", corBotaoOperacao, () => operacaoBasica("/")),
                BotaoSimples("7", corBotaoNumerico, () => botaoNum("7")),
                BotaoSimples("8", corBotaoNumerico, () => botaoNum("8")),
                BotaoSimples("9", corBotaoNumerico, () => botaoNum("9")),
                BotaoSimples("X", corBotaoOperacao, () => operacaoBasica("x")),
                BotaoSimples("4", corBotaoNumerico, () => botaoNum("4")),
                BotaoSimples("5", corBotaoNumerico, () => botaoNum("5")),
                BotaoSimples("6", corBotaoNumerico, () => botaoNum("6")),
                BotaoSimples("-", corBotaoOperacao, () => operacaoBasica("-")),
                BotaoSimples("1", corBotaoNumerico, () => botaoNum("1")),
                BotaoSimples("2", corBotaoNumerico, () => botaoNum("2")),
                BotaoSimples("3", corBotaoNumerico, () => botaoNum("3")),
                BotaoSimples("+", corBotaoOperacao, () => operacaoBasica("+")),
                BotaoSimples("+/-", corBotaoNumerico, () => botaoInvert()),
                BotaoSimples("0", corBotaoNumerico, () => botaoNum("0")),
                BotaoSimples(",", corBotaoNumerico, () => botaoNum(",")),
                BotaoSimples("=", corBotaoIgual, () => botaoIgual()),
              ],
            ),
          ],
        );
      }),
    );
  }
}
