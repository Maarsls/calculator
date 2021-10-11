import 'package:calculator/localizations.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class Layout extends StatefulWidget {
  const Layout({Key key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  bool isFirst = true;
  String equation = "0";
  num result = 0;
  List buttonNames = [
    "AC",
    "⌫",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "^",
    "0",
    ",",
    "="
  ];

  Widget _buttonPressed(String text, {bool isClear = false}) {
    setState(() {
      switch (text) {
        case "×":
          {
            equation += " * ";
            isFirst = false;
          }
          break;
        case ",":
          {
            equation += ".";
          }
          break;
        case "-":
          {
            print("minus");
            equation += " - ";
            isFirst = false;
          }
          break;
        case "÷":
          {
            equation += " / ";
            isFirst = false;
          }
          break;
        case "+":
          {
            equation += " + ";
            isFirst = false;
          }
          break;
        case "=":
          {
            result = equation.interpret();
            equation = result.toString();
            equation = equation.replaceAll(".", ",");
            equation = equation.replaceAll(",0", "");
            isFirst = true;
            print(result);
          }
          break;
        case "AC":
          {
            equation = "";
          }
          break;

        case "⌫":
          {
            equation = equation.substring(0, equation.length - 1);
          }
          break;
        default:
          {
            if (isFirst) {
              equation = "";
              isFirst = false;
            }
            equation += text;
          }
      }
    });
  }

  Widget _buildButtons() {
    return GridView.count(
        crossAxisCount: 4, // 4x4 grid
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: buttonNames.map<Widget>((e) {
          return _button(e, 0);
        }).toList());
  }

  Widget _button(text, double paddingBot) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Color.fromRGBO(154, 192, 205, 1),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return InkWell(
              onTap: () {
                _buttonPressed(text);
              },
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            );
          }),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          children: [
            Padding(
              child: Text(
                "Rechner",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.red),
              ),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            ),
            Expanded(
              child: Padding(
                child: Text(
                  '$equation',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 50),
                ),
                padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 5.0),
              ),
            ),
            _buildButtons(),
          ],
        ),
      ),
    );
  }
}
