import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "Flutter Demo",
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: MyHomePage(
        title: "Flutter Demo",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final data = [
    {"Treno", CupertinoIcons.train_style_one},
    {"Cerca", CupertinoIcons.search},
    {"Condividi", CupertinoIcons.share}
  ];
  @override
  Widget build(context) => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.train_style_one), label: "Treno"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search), label: "Cerca"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.share), label: "Condividi"),
          ],
        ),
        tabBuilder: (context, i) => CupertinoTabView(
          builder: (context) => CupertinoPageScaffold(
            child: Center(
              child: Text("ciao"),
            ),
          ),
        ),
      );
}

/*return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style:
                  CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            ),
            CupertinoButton(
              onPressed: _incrementCounter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.add_circled_solid),
                  Text("Increase")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }*/
