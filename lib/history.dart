import 'package:flutter/material.dart';

class Historico extends StatefulWidget {
  final List<HistoryEntry> historyList;
  final double screenHeight;

  const Historico(this.historyList, this.screenHeight, {Key? key})
      : super(key: key);

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height -
                (widget.screenHeight * 3 / 4),
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(43, 43, 43, 1),
              child: ListView.builder(
                itemCount: widget.historyList.length,
                itemBuilder: (context, indice) {
                  return widget.historyList[indice];
                },
              ),
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(43, 43, 43, 1),
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  child: const Icon(Icons.delete),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(43, 43, 43, 1)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        const RoundedRectangleBorder()),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.historyList.clear();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryEntry extends StatelessWidget {
  final String valor1;
  final String valor2;
  final String valorMain;
  final String operacao;

  const HistoryEntry(
      {required this.valor1,
      this.valor2 = "",
      required this.valorMain,
      required this.operacao,
      Key? key})
      : super(key: key);

  String contaSub() {
    if (["+", "-", "x", "/"].contains(operacao)) {
      return valor1 + "  " + operacao + "  " + valor2 + " =";
    }
    if (["sqr", "sqrt"].contains(operacao)) {
      return operacao + "( " + valor1 + " )" + " =";
    }
    if (operacao == "1/x") {
      return "1/( " + valor1 + " )" + " =";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context, [contaSub(), valorMain]);
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromRGBO(43, 43, 43, 1)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder()),
        ),
        child: ListTile(
          title: Text(
            contaSub(),
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            valorMain,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
