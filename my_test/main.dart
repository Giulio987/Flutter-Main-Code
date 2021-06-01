import 'package:flutter/material.dart';
import 'OurButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'An app that can count to '), //classe con stato
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _displayedString;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_counter == 0) {
      _displayedString = "None";
    } else {
      _displayedString = _counter.toString();
    }
    return Scaffold(
      //struttura base del material design
      appBar: AppBar(
        title: Text(//parrentesi grafe perche abbiamo usato la dot notation
            '${widget.title} $_counter'), //widget text che mostra il titolo impostato prima
      ),
      body: Center(
        child: Container(
          //padding: EdgeInsets.all(20.0),
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: Center(
              child: Text("Text test",
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 30))),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
/* AL posto di Center in Body       PADDING
Padding(
  padding:EdgeInsets.all(20.0), //padding intorno al contenuto
  //padding: EdgeInsets.symmetric(vertical: paddingAmountVertical, horizontal: paddingAmountHorizontal) 
  //"only" invece per "specificare ogni lato-> top,bottm,left,right
  child: Text('Ciao Sono padding')
)*/

/* CONTAINER 
   body: Center(
          child: Container(
            //padding: EdgeInsets.all(20.0),
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Center(
                child: Text("Text test",
                    style:
                        TextStyle(color: Colors.yellowAccent, fontSize: 30))),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));


      COlonna
      mainAxisAlignment: MainAxisAlignment.spaceAround,
*/

/* IMMAGINI
Image.network('https://www.artemedialab.it/wp-content/uploads/2019/04/immagini-sfondo-1-700x400.jpg'),
*/

/**
 * ListView(
 * 	children: <Widget>(
 * 		Text("1"),
 * 		Text("2"),
 * 	)
 * )
 * 
 * ListView.builder(
 * 	itemCount: 499,
 * 	itemBuilder: (BuildContext context, int i)=>
 * 		Text("${i+1}""),
 * )
 * 
 * ListView.separated(
 * itemBuilder: (context, i) => Text(
 *               '$i',
 *               style: Theme.of(context).textTheme.headline4,
 *             ),
 *         separatorBuilder: (context, i) => i % 3 == 0
 *             ? Divider()
 *             : Padding(
 *                 padding: EdgeInsets.all(0.5),
 *               ),
 *         itemCount: 500),
 *  Questo agigunge un widget divider ogni 3 numeri 
 * 
 * ListTile per avere tipo whatsapp
 * ListTile(
 *         sleading: Image.network(
 *             'https://www.artemedialab.it/wp-content/uploads/2019/04/immagini-sfondo-1-700x400.jpg'),
 *         title: Text("prova"),
 *         subtitle: Text("ProvaSub"),
 *         //onTap:opentitle();
 *       ));
 * 
 * 
 * Container per creare widget di qualsiasi forma e grandezza
 * Oppure usare un CircleAvatar-> Container circolare gia pronto
 * 
 * 
 * Liste con eliminazione elementi
 * Figlie di Dimissible
 
ListView.builder(
itemCount: 20,
itemBuilder: (context, i) => Dismissible(
      background: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.clear,
                color: Colors.white,
              ),
              Icon(Icons.clear, color: Colors.white)
            ],
          )),
      key: UniqueKey(),
      child: ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/2/2d/Google-favicon-2015.png")),
        title: Text("Esempio ${i + 1}"),
      ),
      onDismissed: (direction) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Ciao"),
          ),
        );
      },
    )));
Nel caso Si voglia lo Snackbar-> barra sotto quando viene eliminato qualcosa->onDimissed
Meglio di no perche ormai quasi deprecato

All'intero dell column si potrebbe usare come children il widget Expanded per suddividere tutto lo spazio disponibile
MISTO TRA CIrcleAvatar, Aling, Padding -> interfaccia base post facebook
Column(
children: <Widget>[
Row(
children: <Widget>[
  CircleAvatar(
    backgroundImage: NetworkImage(
        "https://i1.wp.com/blog.tesiviaggi.it/wp-content/uploads/2018/01/cropped-Tesi-Favicon.jpg?ssl=1"),
  ),
  Padding(
    padding: EdgeInsets.all(20),
    child: Text("Posrter corto"),
  ),
],
),
Align(
alignment: FractionalOffset.centerLeft,
child: Padding(
  padding: EdgeInsets.all(5),
  child: Text("Questo è un testo corto ma poco importa"),
),
),
Divider(),
Row(
children: <Widget>[
  IconButton(
    icon: Icon(Icons.thumb_up),
    color: Colors.redAccent,
    onPressed: () {},
  ),
  IconButton(
    icon: Icon(Icons.comment),
    color: Colors.greenAccent,
    onPressed: () {},
  ),
  IconButton(
    icon: Icon(Icons.share),
    color: Colors.blueAccent,
    onPressed: () {},
  )
],
),
Divider(),
],
),


GRIGLIE
GridView.count(
  crossAxisCount: 3,
  crossAxisSpacing: 20.0,
  scrollDirection: Axis.horizontal,
  mainAxisSpacing: 100,
  padding: EdgeInsets.all(20),
  children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
      .map(
        (e) => Text("$e", style: Theme.of(context).textTheme.headline4),
      )
      .toList(),
),


CARD
GridView.builder(
        itemCount: 15,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 50.0,
          mainAxisExtent: 100.0,
        ),
        padding: EdgeInsets.all(20),
        itemBuilder: (context, i) => Card(
          child: Center(
            child: Text("${i + 1}"),
          ),
        ),
      ),

  Sliver sono porzioni di area scrollabile che si possono manipolare a piacimento
APPBAR COLLASSABILE
   CustomScrollView(
        //appBar collasabile
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Un Collapsible"),
            floating:
                true, //così l'appbar apparirà ogni volta che scorre verso l'alto
            snap: true, //e questo anche per i piccoli movimenti
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => ListTile(
                title: Text("$i"),
              ),
            ),
          ),
        ],
      ),
KEY per identificare elementi che devono necesariamente cambiare
Di solito non si usa direttamente ma ad esempio Dimissible ne ha bisogno
*/
