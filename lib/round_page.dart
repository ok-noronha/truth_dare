import 'colors.dart';
import 'images.dart';

import 'player_man.dart';
import 'question_man.dart';

import 'players_page.dart';

import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

dynamic getRoundPage(String n) => _RoundPage(
      title: n,
    );

class _RoundPage extends StatefulWidget {
  // ignore: unused_element
  const _RoundPage({super.key, required this.title});
  final String title;

  @override
  State<_RoundPage> createState() => _RoundPageState();
}

class _RoundPageState extends State<_RoundPage> {
  Player _p = Player.getPlayerObj();
  String _name = "";
  String? _quest = "";
  Color _questionColor = ThemeManager.gold;
  AssetImage _bgImg = AssetImage(ImageManager.ch11);
  bool _playerNameVisibility = true;
  bool _questionVisibility = false;
  bool _choiceButtonVisibility = true;
  bool _imageVisibility = true;
  // ignore: unused_field
  bool _judgeVisibility = false;

  @override
  void initState() {
    super.initState();
  }

  void _setplayer() {
    if (Player.getRandomPlayer() == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => getPLayersPage("Players")));
    }
    _p = Player.getRandomPlayer()!;
    setState(() {
      _name = _p.name;
      _questionVisibility = false;
      _playerNameVisibility = true;
      _choiceButtonVisibility = true;
      _judgeVisibility = false;
    });
  }

  void _getttplayer() {
    if (Player.getRandomPlayer() == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => getPLayersPage("Players")));
    }
    _p = Player.getRandomPlayer()!;
  }

  void _setquest(int param) {
    setState(() {
      _quest = '${_p.name}, ${getRandomQuestion(param, _p, 0).question}';
      if (param == 0) {
        _questionColor = ThemeManager.gold;
      } else {
        _questionColor = ThemeManager.blood;
      }
      _questionVisibility = true;
      _choiceButtonVisibility = false;
      _judgeVisibility = true;
      _playerNameVisibility = true;
      _imageVisibility = false;
    });
  }

  // ignore: unused_element
  void _deeddone(num scr) {
    _p.addScore(scr);
    setState(() {
      _choiceButtonVisibility = false;
      _judgeVisibility = false;
      _playerNameVisibility = false;
      _questionVisibility = false;
      _imageVisibility = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 30,
            fontFamily: 'Black Cherry',
          ),
        ),
        backgroundColor: ThemeManager.appBarbg,
        foregroundColor: ThemeManager.appBarfg,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_box_rounded),
            //splashRadius: 10,
            alignment: const Alignment(0, 0),
            tooltip: 'Player Settings',
            onPressed: () {
              // ignore: todo
              //TODO: change play button
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      // ignore: todo
                      //TODO: Navigate to Round Page
                      builder: (context) => getPLayersPage("Players")));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            //splashRadius: 10,
            alignment: const Alignment(0, 0),
            tooltip: 'Player Settings',
            onPressed: () {
              // ignore: todo
              //TODO: Add Settings Page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => getPLayersPage("Players")));
            },
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: _bgImg, fit: BoxFit.cover),
        ),
        child: Stack(
          children: <Widget>[
            Visibility(
              //Player Name
              visible: _playerNameVisibility,
              child: Align(
                alignment: Alignment.topCenter,
                child: GradientText(
                  _name,
                  shaderRect: const Rect.fromLTWH(60.0, 28.0, 50.0, 80.0),
                  gradient: Gradients.buildGradient(
                      Alignment.topLeft,
                      Alignment.bottomRight,
                      [ThemeManager.blood, ThemeManager.gold]),
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Color(0xFF140016),
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    //fontFamilyFallback: Typography._helsinkiFontFallbacks,
                    fontFamily: 'Magenta Rose',
                    //color: Color(0xFF250038),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _questionVisibility,
              child: SizedBox(
                child: Column(
                  children: [
                    Card(
                      borderOnForeground: true,
                      elevation: 10,
                      color: _questionColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _quest!,
                        style: const TextStyle(
                          fontFamily: 'Creattion Demo',
                          fontSize: 21,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _deeddone(1);
                          },
                          child: const Text(
                            'Completed',
                            style: TextStyle(
                              fontFamily: 'Creattion Demo',
                              fontSize: 21,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _deeddone(-1);
                          },
                          child: const Text(
                            'Forfeited',
                            style: TextStyle(
                              fontFamily: 'Creattion Demo',
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _choiceButtonVisibility,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _setquest(1);
                      },
                      child: const Text(
                        'Dare',
                        style: TextStyle(
                          fontFamily: 'Creattion Demo',
                          fontSize: 21,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _setquest(0);
                      },
                      child: const Text(
                        'Truth',
                        style: TextStyle(
                          fontFamily: 'Creattion Demo',
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _choiceButtonVisibility,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              _setquest(0);
                            },
                            child: Ink.image(
                              image: const AssetImage(ImageManager.truthImage),
                            ),
                          ),
                          const Text('Truth')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              _setquest(1);
                            },
                            child: Ink.image(
                              image: const AssetImage(ImageManager.dareImage),
                            ),
                          ),
                          const Text('Dare')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
