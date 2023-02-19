import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:core';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

var _theme = Colors.blue;
var _foretheme = Colors.white;
List _truths = [];
List _dares = [];
List<_Player> _players = [];

class _Player {
  String name;
  int gender;
  _Player(this.name, this.gender);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Truth or Dare',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        useMaterial3: true,
        primarySwatch: _theme,
      ),
      home: const MyHomePage(title: 'Truth or Dare'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _Player _p = _Player('', -10);
  String _name = "";
  String _quest = "";
  bool _playbtt = true;
  bool _namel = false;
  bool _quesl = false;
  bool _tdbt = false;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final data = await json.decode(response);
    setState(() {
      _truths = data["truths"];
      _dares = data["dares"];
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
    // Call the readJson method when the app starts
  }

  _Player _getplayer() {
    var r = Random();
    var i = r.nextInt(_players.length);
    return _players[i];
  }

  void _setplayer() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _p = _getplayer();
      _name = _p.name;
      _quesl = false;
      _namel = true;
      _tdbt = true;
      _playbtt = false;
    });
  }

  String _getquest(_Player p, int param) {
    //return "question";
    Random r = Random();
    int i = r.nextInt(_truths.length);
    if (param == 0) {
      while (_truths[i]["used"] == 0 && _truths[i]["gender"] == p.gender) {
        i = r.nextInt(_truths.length);
      }
      _truths[i]["used"] = 1;
      // ignore: unused_local_variable
      var y = p.gender;
      return _truths[i]["question"];
    } else {
      while (_dares[i]["used"] == 0 && _dares[i]["gender"] == p.gender) {
        i = r.nextInt(_truths.length);
      }
      _dares[i]["used"] = 1;
      return _dares[i]["question"];
    }
  }

  void _setquest(int param) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _quest = _getquest(_p, param);
      _quesl = true;
      _tdbt = false;
      _playbtt = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        foregroundColor: _foretheme,
        backgroundColor: _theme[900],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            color: _foretheme,
            tooltip: 'Change Settings',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const _SettingsPage(title: "Settings")));
            },
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: _namel,
              child: Text(
                _name,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Visibility(
              visible: _quesl,
              child: Text(
                _quest,
              ),
            ),
            Visibility(
              visible: _tdbt,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      _setquest(0);
                    },
                    tooltip: 'Truth',
                    child: const Text("Truth"),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _setquest(1);
                    },
                    tooltip: 'Dare',
                    child: const Text("Dare"),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _playbtt,
              child: FloatingActionButton(
                onPressed: () {
                  if (_players.isEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const _SettingsPage(title: "Settings")));
                  }
                  _setplayer();
                },
                tooltip: 'Next Round',
                child: const Icon(Icons.play_arrow_rounded),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: _theme,
    );
  }
}

class _SettingsPage extends StatefulWidget {
  // ignore: unused_element
  const _SettingsPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<_SettingsPage> createState() => _PlayerState();
}

class _PlayerState extends State<_SettingsPage> {
  late TextEditingController _playerController;
  late TextEditingController _genc;

  @override
  void initState() {
    super.initState();
    // Call the readJson method when the app starts
    _players.add(_Player("Player 1", 0));
    _playerController = TextEditingController();
    _genc = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _playerController.dispose();
    _genc.dispose();
    super.dispose();
  }

  String _genGender(_Player p) {
    if (p.gender == 1) {
      return 'M';
    } else if (p.gender == -1) {
      return 'F';
    } else {
      return 'N';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Players"),
        backgroundColor: _theme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _players.map((player) {
            return Card(
              child: ListTile(
                leading: ElevatedButton(
                  child: Text(_genGender(player)),
                  onPressed: () {
                    if (player.gender == 1) {
                      player.gender = 0;
                    } else if (player.gender == 0) {
                      player.gender = -1;
                    } else {
                      player.gender = 1;
                    }
                    setState(() {
                      //refresh UI after deleting element from list
                    });
                  },
                ),
                title: Text(player.name),
                trailing: ElevatedButton(
                  child: const Icon(Icons.delete),
                  onPressed: () {
                    //delete action for this button
                    _players.removeWhere((element) {
                      return element.name == player.name;
                    }); //go through the loop and match content to delete from list
                    setState(() {
                      //refresh UI after deleting element from list
                    });
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _openNewPlayer(); //add new element to list
          setState(() {});
        },
        tooltip: 'Add Player',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future _openNewPlayer() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Add Player"),
          content: Column(
            children: [
              TextField(
                controller: _playerController,
                autofocus: true,
                decoration:
                    const InputDecoration(hintText: "Enter Player Name"),
              ),
              TextField(
                controller: _genc,
                autofocus: true,
                decoration: const InputDecoration(hintText: "Gender"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                _players.add(
                    _Player(_playerController.text, int.parse(_genc.text)));
                _playerController.clear();
                _genc.clear();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
}
