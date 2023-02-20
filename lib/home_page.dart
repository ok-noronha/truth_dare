import 'player_man.dart';
import 'ui_helpers.dart';
import 'question_man.dart';
import 'players_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _p = Player.getPlayerObj();
  String _name = "";
  String? _quest = "";
  bool _playButtonVisibility = true;
  bool _playerNameVisibility = false;
  bool _questionVisibility = false;
  bool _choiceButtonVisibility = false;

  @override
  void initState() {
    readJson();
    super.initState();
  }

  void _setplayer() {
    setState(() {
      _p = Player.getRandomPlayer()!;
      _name = _p.name;
      _questionVisibility = false;
      _playerNameVisibility = true;
      _choiceButtonVisibility = true;
      _playButtonVisibility = false;
    });
  }

  void _setquest(int param) {
    setState(() {
      _quest = getRandomQuestion(param, _p).question;
      _questionVisibility = true;
      _choiceButtonVisibility = false;
      _playButtonVisibility = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: invertInvertColorsStrong(context),
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.verified_user),
              alignment: const Alignment(0, 0),
              tooltip: 'Change Settings',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => getPLayersPage("Players")));
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: _playerNameVisibility,
                child: Text(
                  _name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Visibility(
                visible: _questionVisibility,
                child: Text(
                  _quest!,
                ),
              ),
              Visibility(
                visible: _choiceButtonVisibility,
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
                visible: _playButtonVisibility,
                child: FloatingActionButton(
                  onPressed: () {
                    if (Player.getPlayers().isEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => getPLayersPage("Players")));
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
      ),
    );
  }
}
