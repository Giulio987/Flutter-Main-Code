import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

Future<int> getLastCom() async {
  final dir = await getTemporaryDirectory(); //retrive della cache
  var file = File(
      '${dir.path}/lastestComicNumber.txt'); //directory file cache completa
  int n = 1; //sicuramente i fumetti iniziano da 1
  try {
    n = json.decode(await http.read(Uri.parse("https://xkcd.com/info.0.json")))[
        "num"]; //li recupero dal web
    file.exists().then((exists) {
      //se il file gia esiste
      //then(allora) crea un thread aspettando che la funzione restituisca un valore
      if (!exists)
        file.createSync(); //solo se non esiste lo crea-> sincronamente
      file.writeAsString('$n'); // altrimenti lo scrive e basta Asincrono
    });
  } catch (e) {
    if (file.existsSync() && file.readAsStringSync() != "") {
      // se non posso prenderlo online vado a vedere se esiste e non è vuuoto
      n = int.parse(file.readAsStringSync()); //prendo il valore all'interno
    }
  }
  return n; //indipendentemente da cosa è diventato torna n
}

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //assicuro che le operazioni asincrone vengano fatte subito
  runApp(MaterialApp(
      home: HomeScreen(
    title: "XKCD app",
    lastestComic: await getLastCom(),
  )));
}

class ComicPage extends StatelessWidget {
  ComicPage({this.comic});
  final Map<String, dynamic> comic;

  void _launchComic(int number) {
    launch("https://xkcd.com/$number/");
  }

//per farlo funzionare dobbiamo racchiudere image in un Inkwell-> come <a><html> </></>
//inksplash è però applicato al material non ai widget
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("#${comic["num"]}")),
      body: ListView(
        children: <Widget>[
          Center(
            child: Text(
              comic["title"],
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Material(
            child: Ink.image(
              image: FileImage(
                File(
                  comic["img"],
                ),
              ),
              height: 300,
              width: 200,
              child: InkWell(
                onTap: () {
                  _launchComic(comic["num"]);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(comic["alt"]),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({this.title, this.lastestComic});
  final int lastestComic;
  final String title;
  Future<Map<String, dynamic>> _fetchComic(int n) async {
    //funzione asincorna, restituisce un oggetto Directory, la stringa percorso e il membro dir.path
    final dir = await getTemporaryDirectory();
    int comicNum = lastestComic - n;
    var comicFile = File("${dir.path}/$comicNum.json");
    //Se esiste il fumetto in cache e non è vuoto lo leggo da li
    if (await comicFile.exists() && comicFile.readAsStringSync() != "") {
      return json.decode(comicFile.readAsStringSync());
    } else {
      comicFile.createSync();
      //altrimenti lo prendo dalla rete
      final comic = json.decode(
          await http.read(Uri.parse("https://xkcd.com/$comicNum/info.0.json")));
      //sostituisco il percorso dell'immagine da quello web a quello locale
      File("${dir.path}/$comicNum.png")
          .writeAsBytesSync(await http.readBytes(Uri.parse(comic["img"])));
      comic["img"] = '${dir.path}/$comicNum.png';
      //non servere mette in pausa l'app per scriverlo qindi non serve await
      comicFile.writeAsString(json.encode(comic));

      return comic;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.looks_one),
            tooltip: ("Select comics by number"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SelectionPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: lastestComic,
        itemBuilder: (context, index) => FutureBuilder(
          future:
              _fetchComic(index), //snapshot prenderà il return della funzione
          builder: (context, snapshot) => snapshot.hasData
              ? ComicTale(comic: snapshot.data)
              : Container(
                  width: 20.0,
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

class ComicTale extends StatelessWidget {
  ComicTale({this.comic});
  final Map<String, dynamic> comic;
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.file(
        File(comic["img"]),
        height: 30,
        width: 30,
      ),
      title: Text(
        comic["title"],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ComicPage(
              comic: comic,
            ),
          ),
        );
      },
    );
  }
}

class ErrorPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Page"),
      ),
      body: Column(
        children: <Widget>[
          Icon(Icons.error),
          Text("Impossibile trovare il fumetto cercato")
        ],
      ),
    );
  }
}

class SelectionPage extends StatelessWidget {
  Future<Map<String, dynamic>> _fetchComic(String n) async {
    final dir = await getTemporaryDirectory();
    var file = File("${dir.path}//$n.json");
    if (await file.exists() && file.readAsStringSync() != "") {
      return json.decode(file.readAsStringSync());
    } else {
      file.createSync();
      var comic;
      try {
        comic = json.decode(await http.read(Uri.parse(
            "https://xkcd.com/$n/info.0.json"))); //rimuovere i breakpoint per vedere la pagina di errore subito
      } catch (e) {
        print("ERROR");
      }
      File("${dir.path}/$n.png")
          .writeAsBytesSync(await http.readBytes(Uri.parse(comic["img"])));
      comic["img"] = "${dir.path}//$n.png";
      file.writeAsString(
          json.encode(comic)); //visto che dopo verrà decodificato
      return comic;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COMIC SELECTION"),
      ),
      body: Center(
        child: TextField(
          decoration: InputDecoration(labelText: "Insert Comic Number"),
          keyboardType: TextInputType.number,
          autofocus: true,
          onSubmitted: (String a) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FutureBuilder(
                future: _fetchComic(a),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return ErrorPage();
                  if (snapshot.hasData)
                    return ComicPage(
                      comic: snapshot.data,
                    );
                  else
                    return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
