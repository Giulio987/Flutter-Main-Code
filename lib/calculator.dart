class Calculation {
  List<String> a = [];
  //per controllare se una stringa contiene operatori
  final RegExp regExp = RegExp("[+\\-xÃ·]"); //regular expression
  //bool matches = regExp.hasMatch(string);

  void add(String added) {
    if (a.isEmpty) {
      //se la lista è vuota
      if (!regExp.hasMatch(added)) {
        a.add(added); //aggiungiamo il carattere se non è un operatore
      }
    } else if (regExp.hasMatch(a.last)) {
      if (!RegExp("[+\\-xÃ·.]").hasMatch(added)) {
        a.add(added);
      }
    } else {
      if (regExp.hasMatch(added)) {
        if (!RegExp(".").hasMatch(a.last)) a.last += ".0";
        a.add(added);
      } else {
        a.last += added;
      }
    }
  }

  String getString() {
    String str = "";
    a.forEach((String element) {
      str += element;
    });
    return str;
  }

  void deleteAll() => a = [];

  void deleteOne() {
    if (a.length > 0) {
      // se la lista non è vuota
      if (a.last.length > 1) {
        // e l'ultimo numero ha lunghezza maggiore di uno
        a.last = a.last.substring(0, a.last.length - 1);
      } else {
        a.removeLast();
      }
    }
  }

  double getResult() {
    if (regExp.hasMatch(a.last)) {
      a.removeLast(); //rimuove l'ultimo elemento
    }
    if (a.last.indexOf(".") == a.last.length - 1) {
      //rimuove il punto e basta dalla stringa
      a.last = a.last.substring(0, a.length - 1);
    }
    for (int i = 0; i < a.length; i++) {
      if (a[i] == "x") {
        a[i - 1] = "${double.parse(a[i - 1]) * double.parse(a[i + 1])}";
        a.removeAt(i);
        a.removeAt(i);
        i--;
      } else if (a[i] == "Ã·") {
        if (double.parse(a[i + 1]) == 0) {
          throw DivideByZeroExc();
        }
        a[i - 1] = "${double.parse(a[i - 1]) / double.parse(a[i + 1])}";
        a.removeAt(i);
        a.removeAt(i);
        i--;
      }
    }
    for (int i = 0; i < a.length; i++) {
      if (a[i] == "-") {
        a[i - 1] = "${double.parse(a[i - 1]) - double.parse(a[i + 1])}";
        a.removeAt(i);
        a.removeAt(i);
        i--;
      } else if (a[i] == "+") {
        a[i - 1] = "${double.parse(a[i - 1]) + double.parse(a[i + 1])}";
        a.removeAt(i);
        a.removeAt(i);
        i--;
      }
    }
    if (a.length != 1) throw Error();
    return double.parse(a[0]);
  }
}

class DivideByZeroExc implements Exception {}
