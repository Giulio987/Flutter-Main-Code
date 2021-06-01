import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void sendText(String text) => FirebaseAuth.instance.authStateChanges().listen(
      (User user) {
        FirebaseFirestore.instance.collection("Messages").add(
          {
            "form": user != null ? "user.displayName" : "Anonymous",
            "when": Timestamp.fromDate(DateTime.now().toUtc()),
            "msg": text,
          },
        );
      },
    );
Stream<QuerySnapshot> getMessages() => FirebaseFirestore.instance
    .collection("Messages")
    .orderBy("when", descending: true)
    .snapshots();

class ChatPage extends StatelessWidget {
  TextEditingController _messagesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatOnFire"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: getMessages(),
              builder: (context, snapshot) => snapshot.hasData
                  ? MessagesList(snapshot.data as QuerySnapshot)
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _messagesController,
                    keyboardType: TextInputType.text,
                    onSubmitted: (text) {
                      sendText(text);
                      _messagesController.clear();
                    },
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    sendText(_messagesController.text);
                    _messagesController.clear();
                  },
                  icon: Icon(Icons.send))
            ],
          )
        ],
      ),
    );
  }
}

class MessagesList extends StatelessWidget {
  MessagesList(this.data);

  final QuerySnapshot data;

  bool areSameDay(Timestamp a, Timestamp b) {
    var date1 = a.toDate().toLocal();
    var date2 = a.toDate().toLocal();
    return (date1.year == date2.year) &&
        (date1.month == date2.month) &&
        (date1.day == date2.day);
  }

  Widget build(BuildContext context) => ListView.builder(
        reverse: true,
        itemCount: data.docs.length,
        itemBuilder: (context, i) {
          var months = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
          ];
          DateTime when = data.docs[i]["when"].toDate().toLocal();
          var widgetToShow = <Widget>[
            Message(
              from: data.docs[i]["form"],
              msg: data.docs[i]["msg"],
              when: when,
              uid: data.docs[i]["form"],
            )
          ];
          if (i == data.docs.length - 1) {
            widgetToShow.insert(
              0,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                    "${when.day} ${months[when.month - 1]} ${when.year}",
                    style: Theme.of(context).textTheme.subtitle1),
              ),
            );
          } else if (!areSameDay(
              data.docs[i + 1]["when"], data.docs[i]["when"])) {
            widgetToShow.insert(
              0,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "${when.day} ${months[when.month - 1]} ${when.year}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            );
          }
          return Column(
            children: widgetToShow,
          );
        },
      );
}

class Message extends StatelessWidget {
  Message({this.from, this.msg, this.uid, this.when});
  final String from;
  final String uid;
  final String msg;
  final DateTime when;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //FIreBaseUser rinominata in User
          User user = snapshot.data;
          return Container(
            alignment:
                user.uid == uid ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width / 3 * 2,
              child: Card(
                shape: StadiumBorder(),
                child: ListTile(
                  title: user.uid != uid
                      ? InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 5.0),
                            child: Text(
                              uid,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Tu",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, left: 5.0),
                    child:
                        Text(msg, style: Theme.of(context).textTheme.bodyText2),
                  ),
                  trailing: Text("${when.hour}:${when.minute}"),
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
