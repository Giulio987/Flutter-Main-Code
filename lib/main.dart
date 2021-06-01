import 'package:flutter/material.dart';
import 'calculator.dart';
import 'package:path_provider/path_provider.dart';

//Utilizzo una classe wrapper-> i un'app grande serve
void main() => runApp(Calcolatrice());

class Calcolatrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calcolatrice Flutetr",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black26,
      ),
      home: CalculatorHomePage(
        title: "Calcolatrice Flutter",
      ),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  CalculatorHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _str = "0";

  var _calculation = Calculation();

  void add(String a) {
    setState(() {
      _calculation.add(a);
      _str = _calculation.getString();
    });
  }

  void deleteAll() {
    setState(() {
      _calculation.deleteAll();
      _str = _calculation.getString();
    });
  }

  void deleteOne() {
    setState(() {
      _calculation.deleteOne();
      _str = _calculation.getString();
    });
  }

  void getResult() {
    setState(() {
      try {
        _str = _calculation.getResult().toString();
      } on DivideByZeroExc {
        _str = "Non dovresti dividere per 0";
      } finally {
        _calculation = new Calculation();
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        //serve a tenere i widget quanto piu lontano possibile l'uno dall'altro
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //schermo
          Expanded(
            flex: 2,
            child: Card(
              //verde di intensità molto bassa-> 500 intensità normale
              color: Colors.lightGreen[50],
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  _str,
                  textScaleFactor: 2.0,
                ),
              ),
            ),
          ),
          //riga per cancellare
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: MaterialButton(
                    onPressed: () {
                      deleteAll();
                    },
                    child: Text(
                      "C",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black54,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: () {
                      deleteOne();
                    },
                    child: Text(
                      "<-",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          //riga con numeri e op
          Expanded(
            flex: 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('7');
                                },
                                child: Text(
                                  "7",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('8');
                                },
                                child: Text(
                                  "8",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('9');
                                },
                                child: Text(
                                  "9",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('4');
                                },
                                child: Text(
                                  "4",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('5');
                                },
                                child: Text(
                                  "5",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('6');
                                },
                                child: Text(
                                  "6",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('1');
                                },
                                child: Text(
                                  "1",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('2');
                                },
                                child: Text(
                                  "2",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('3');
                                },
                                child: Text(
                                  "3",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('0');
                                },
                                child: Text(
                                  "0",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  add('.');
                                },
                                child: Text(
                                  ".",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueAccent,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MaterialButton(
                                onPressed: () {
                                  getResult();
                                },
                                child: Text(
                                  "=",
                                  style: TextStyle(color: Colors.black87),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () {
                            add('Ã·');
                          },
                          child: Image.asset(
                            'icons/divide.png',
                            width: 10.0,
                            height: 10.0,
                          ),
                          color: Colors.blue[50],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () {
                            add('x');
                          },
                          child: Text("x"),
                          color: Colors.blue[50],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () {
                            add('-');
                          },
                          child: Text("-"),
                          color: Colors.blue[50],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () {
                            add('+');
                          },
                          child: Text("+"),
                          color: Colors.blue[50],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
