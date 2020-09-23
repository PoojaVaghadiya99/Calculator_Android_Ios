import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 28.0;
  double resultFontSize = 48.0;
  Color resultColor = Colors.black54;
  Color equationColor = Colors.black54;

  // ignore: non_constant_identifier_names
  ButtonPressed(String btnText)
  {
    setState(() {
        if(btnText == "C")
        {
          equation = "0";
          result = "0";
          equationFontSize = 28.0;
          resultFontSize = 48.0;

          resultColor = Colors.black;
          equationColor = Colors.grey;
        }
        else if(btnText == "<-")
        {
          equation = equation.substring(0,equation.length-1);
          if(equation == "")
          {
            equation = "0";
          }
          equationFontSize = 48.0;
          resultFontSize = 28.0;

          resultColor = Colors.grey;
          equationColor = Colors.black;
        }
        else if(btnText == "=")
        {
          equationFontSize = 28.0;
          resultFontSize = 48.0;

          resultColor = Colors.black;
          equationColor = Colors.grey;

          expression = equation;
          expression = expression.replaceAll('x','*');
          try
          {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = "${exp.evaluate(EvaluationType.REAL,cm)}";
          }
          catch(e)
          {
            result = "Error";
          }
        }
        else
        {
          equationFontSize = 48.0;
          resultFontSize = 28.0;


          resultColor = Colors.grey;
          equationColor = Colors.black;
          if(equation == "0")
          {
            equation = btnText;
          }
          else
          {
            equation = equation + btnText;
          }

        }
    });
  }

  Widget BuildButton(String btnText, double btnHeight, Color btnColor)
  {
    return  Container(
      height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
      color: btnColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: Colors.white,
              width: 1,
              style: BorderStyle.solid,
            )),
        padding: EdgeInsets.all(16.0),
        onPressed: () => ButtonPressed(btnText),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Calculator",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),),
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(10.0),
              child: Text(
                equation,
                style: TextStyle(
                  fontSize: equationFontSize,
                  fontWeight: FontWeight.bold,
                  color: equationColor,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(10.0),
              child: Text(
                result,
                style: TextStyle(
                  fontSize: resultFontSize,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(children: [
                    TableRow(children: [
                      BuildButton("C",1,Colors.redAccent),
                      BuildButton("<-",1,Colors.blue),
                      BuildButton("/",1,Colors.blue),
                    ]),
                    TableRow(children: [
                      BuildButton("7",1,Colors.black54),
                      BuildButton("8",1,Colors.black54),
                      BuildButton("9",1,Colors.black54),
                    ]),
                    TableRow(children: [
                      BuildButton("4",1,Colors.black54),
                      BuildButton("5",1,Colors.black54),
                      BuildButton("6",1,Colors.black54),
                    ]),
                    TableRow(children: [
                      BuildButton("1",1,Colors.black54),
                      BuildButton("2",1,Colors.black54),
                      BuildButton("3",1,Colors.black54),
                    ]),
                    TableRow(children: [
                      BuildButton(".",1,Colors.black54),
                      BuildButton("0",1,Colors.black54),
                      BuildButton("00",1,Colors.black54),
                    ]),
                  ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          BuildButton("x",1,Colors.blue),
                        ]
                      ),
                      TableRow(
                          children: [
                            BuildButton("-",1,Colors.blue),
                          ]
                      ),
                      TableRow(
                          children: [
                            BuildButton("+",1,Colors.blue),
                          ]
                      ),
                      TableRow(
                          children: [
                            BuildButton("=",2,Colors.redAccent),
                          ]
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
