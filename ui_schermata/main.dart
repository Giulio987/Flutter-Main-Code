import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue),
    title: "Prova API web",
    home: HomePage("Dashboard"),
  ));
}

enum PageType { buyTickets, myTickets, profileInfo, pastTrips, myPoints }

class HomePage extends StatefulWidget {
  HomePage(this.title);
  final String title;

  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String month;
  void getJson() async {
    /*var url = Uri.parse("https://xkcd.com/info.0.json");
    Future<Map<String, dynamic>> fetchLastComic() async =>
        jsonDecode(await http.read(url));*/
    http.Response res = await http.get('https://xkcd.com/info.0.json');
    //print(res.body);
    Map<String, dynamic> data = json.decode(res.body);
    month = data["month"];
  }

  PageType _pageType = PageType.buyTickets;
  String _string;
  String _sub;
  String _str;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    getJson();
    //String month = fetchLastComi()
    switch (_pageType) {
      case PageType.buyTickets:
        _string = "Compra biglietti";
        _sub = "Puoi comprare qui i tui biglietti";
        break;
      case PageType.myPoints:
        _string = "I tuoi punti";
        _sub = "Qui visualizzerai un saldo dei tuoi punti";
        break;
      case PageType.myTickets:
        _string = "Qui potrai visualizzare i tuoi biglietti";
        _sub = "Qui potrai visualizzare i tuoi biglietti";
        break;
      case PageType.profileInfo:
        _string = "Info Profilo";
        _sub = "Qui potrai visualizzare i tuoi dati";
        break;
      case PageType.pastTrips:
        _string = "Viaggi passati";
        _sub = "Qui potrai visualizzare i tuoi viaggi passati";
        break;
    }
    switch (index) {
      case 0:
        _str = "HOME";
        break;
      case 1:
        _str = "pagina 1";
        break;
    }
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.looks_one),
                text: "First Page",
              ),
              Tab(
                icon: Icon(Icons.looks_two),
                text: "Second Page",
              ),
              Tab(
                icon: Icon(Icons.looks_3),
                text: "Third Page",
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_two),
              label: "Pagina 1",
            ),
          ],
          onTap: (page) {
            setState(() {
              switch (page) {
                case 0:
                  index = 0;
                  break;
                case 1:
                  index = 1;
                  break;
              }
            });
          },
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Profile Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "esempio@mail.com",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.train), //iconcina a fianco
                title: Text(
                  "Tickets",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              ListTile(
                title: Text(
                  "Compra biglietti",
                ),
                onTap: () {
                  setState(
                    () => _pageType = PageType.buyTickets,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  "I miei biglietti",
                ),
                onTap: () {
                  setState(
                    () => _pageType = PageType.myTickets,
                  );
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.person), //iconcina a fianco
                title: Text(
                  "Profilo",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              ListTile(
                title: Text(
                  "Informazioni",
                ),
                onTap: () {
                  setState(
                    () => _pageType = PageType.profileInfo,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  "Viaggi Passati",
                ),
                onTap: () {
                  setState(
                    () => _pageType = PageType.pastTrips,
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text("This is the first page"),
            ),
            Center(
              child: Text("This is the second page"),
            ),
            Center(
              child: Text("This is the third page"),
            ),
          ],
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pagina2"),
        ),
        body: Center(
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            child: Text(
              "Torna indietro!",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}

/*
Center(
        child: Container(
          height: 200,
          child: Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Clicca per andare in una nuova pagina",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NewPage(), //chiamata al costruttore del widget creato per la nuova pagina
                          ),
                        );
                      },
                      color: Colors.black,
                      child: Text("Vai alla nuova pagina"),
                    ),
                  ],
                ),
                Text(
                  _string,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  _sub,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  _str,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
      ),

*/

/*
PageView(
  children: <Widget>[
    Center(
      child: Text(
        "Swipe",
        style: Theme.of(context).textTheme.headline6,
      ),
    ),
    Center(
      child: Text(
        "Swipe again or turn back",
        style: Theme.of(context).textTheme.headline6,
      ),
    ),
    Center(
      child: Text(
        "Swipe back",
        style: Theme.of(context).textTheme.headline6,
      ),
    ),
  ],
  controller: PageController(initialPage: 1),
)
*/

/*
return DefaultTabController( // è un inherit wideget
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.looks_one),
                text: "First Page",
              ),
              Tab(
                icon: Icon(Icons.looks_two),
                text: "Second Page",
              ),
              Tab(
                icon: Icon(Icons.looks_3),
                text: "Third Page",
              ),
            ],
          ),
    body: TabBarView(
          children: <Widget>[
            Center(
              child: Text("This is the first page"),
            ),
            Center(
              child: Text("This is the second page"),
            ),
            Center(
              child: Text("This is the third page"),
            ),
          ],
        ),
*/
