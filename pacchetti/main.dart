import 'package:flutter/material.dart';
import 'dart:async';
import 'package:battery/battery.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  runApp(MaterialApp(
    title: "Prova Pacchetti",
    theme: ThemeData(primarySwatch: Colors.blue),
    home: HomePage("Dashboard"),
  ));
}

class HomePage extends StatefulWidget {
  HomePage(this.title);
  final String title;
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String _connectionStatus = "Unknown";
  IconData _connectionIcon;
  String _batteryStatus = 'Unknown';
  IconData _batteryIcon;
  Color _connectionColor = Colors.deepOrange;
  Color _batteryColor = Colors.deepOrange;

  StreamSubscription<ConnectivityResult> _connSub;
  StreamSubscription<BatteryState> _battSub;
  @override
  void initState() {
    super.initState();

    _connSub = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult res) async {
      setState(() {
        switch (res) {
          case ConnectivityResult.mobile:
            _connectionStatus = "Mobile Data";
            _connectionIcon = Icons.sim_card;
            _connectionColor = Colors.red;
            break;
          case ConnectivityResult.wifi:
            _connectionStatus = "WI-FI";
            _connectionIcon = Icons.wifi;
            _connectionColor = Colors.blue;
            break;
          case ConnectivityResult.none:
            _connectionStatus = "No Connections";
            _connectionIcon = Icons.not_interested;
            _connectionColor = Colors.black;
        }
      });
    });
    _connectionStatus = "No Connections";
    _connectionIcon = Icons.not_interested;
    _connectionColor = Colors.black;
    _battSub = Battery().onBatteryStateChanged.listen((BatteryState res) async {
      setState(() {
        switch (res) {
          case BatteryState.charging:
            _batteryStatus = 'Charging';
            _batteryIcon = Icons.battery_charging_full;
            _batteryColor = Colors.blueAccent;
            break;
          case BatteryState.full:
            _batteryStatus = 'Full';
            _batteryIcon = Icons.battery_full;
            _batteryColor = Colors.green;
            break;
          case BatteryState.discharging:
            _batteryStatus = 'In Use';
            _batteryIcon = Icons.battery_alert;
            _batteryColor = Colors.redAccent;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connSub.cancel();
    _battSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                _connectionIcon,
                color: _connectionColor,
                size: 50.0,
              ),
              Text(
                "connessione:\n $_connectionStatus",
                style: TextStyle(color: _connectionColor, fontSize: 40),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                _batteryIcon,
                color: _batteryColor,
                size: 50.0,
              ),
              Text(
                "connessione:\n $_batteryStatus",
                style: TextStyle(color: _batteryColor, fontSize: 40),
              )
            ],
          )
        ],
      ),
    );
  }
}
