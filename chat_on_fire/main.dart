import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ChatPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: LoginRegister(),
      title: "APPFIRE",
    ),
  );
}

class LoginRegister extends StatefulWidget {
  LoginRegisterState createState() => LoginRegisterState();
}

class LoginRegisterState extends State<LoginRegister> {
  final _scaff_key = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<UserCredential> logIn(String email, String passwd) async =>
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: passwd);
  Future<UserCredential> signUp(String email, String passwd) async =>
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: passwd);

  //bool _verificationComplete = true;
  Widget build(BuildContext context) {
    /*if (_verificationComplete) {
      //pushReplacement va alla pagina successiva senza poter tornare indietro
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ConfigPage()));
    }*/

    UserCredential _user;
    return Scaffold(
      key: _scaff_key,
      appBar: AppBar(
        title: Text("ChatOnFire"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Effettua il login con la tua mail",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(labelText: "Indirizzo Mail"),
              autofocus: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              autofocus: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: MaterialButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text("Log In".toUpperCase()),
              onPressed: () {
                logIn(_emailController.text, _passwordController.text)
                    .then((user) {
                  _user = user;
                  /*if(!_user.isEmailVerified){
                      _user.sendEmailVerification();
                    }*/
                  //_verificationComplete = true;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConfigPage()),
                  );
                }).catchError((e) {
                  //Scaffold.of(context).showSnackBar(
                  //  SnackBar(content: Text("non Hai un account Registrati")));
                }); //Creo un thread
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: MaterialButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text("Create an account".toUpperCase()),
              onPressed: () async {
                try {
                  _user = await signUp(
                      _emailController.text, _passwordController.text);
                  /*if(!_user.isEmailVerified){
                    _user.sendEmailVerification();
                  }*/
                  //_verificationComplete = true;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ConfigPage()));
                  //)
                } catch (e) {
                  //Scaffold.of(context)
                  //   .showSnackBar(SnackBar(content: Text("Errore")));
                  print(e);
                }
                //Creo un thread
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ConfigPage extends StatefulWidget {
  ConfigPageState createState() => ConfigPageState();
}

class ConfigPageState extends State<ConfigPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configure le informazioni del tuo account"),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Nome",
            ),
            controller: _nameController,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Bio",
            ),
            controller: _bioController,
          ),
          MaterialButton(
            child: Text("Submit"),
            onPressed: () => setDataAndGoToChatPage(
                _nameController.text, _bioController.text, context),
          ),
        ],
      ),
    );
  }
}

void setDataAndGoToChatPage(String name, String bio, BuildContext context) {
  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user != null) {
      print(user.uid);

      user.updateProfile();
      FirebaseFirestore.instance.collection("Users").doc("user.uid").set({
        "bio": bio,
        "displayName": name,
        "email": user.email,
      });
    }
  });

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => ChatPage()),
  );
}
