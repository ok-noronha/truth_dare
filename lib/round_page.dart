// ignore_for_file: prefer_const_constructors, dead_code

import 'colors.dart';
import 'images.dart';

import 'player_man.dart';
import 'question_man.dart';
import 'ui_helpers.dart';

import 'players_page.dart';
import 'quest_page.dart';

import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

dynamic getRoundPage(String n) => _RoundPage(
      title: n,
      //data: d,
    );

class _RoundPage extends StatefulWidget {
  //static Data data = getData();
  const _RoundPage({required this.title});
  final String title;

  @override
  State<_RoundPage> createState() => _RoundPageState();
}

class _RoundPageState extends State<_RoundPage> {
  Player _p = Player.getPlayerObj();
  //String _name = "";
  String? _quest = "";
  Color _questionColor = ThemeManager.gold;
  AssetImage _bgImg = AssetImage(ImageManager.getChoiceImg());
  bool _choiceButtonVisibility = true;
  bool _judgeVisibility = false;

  @override
  void initState() {
    _p = Player.getRandomPlayer()!;
    super.initState();
  }

  void _setplayer() {
    setState(() {
      //_name = _p.name;
      _choiceButtonVisibility = true;
      _judgeVisibility = false;
    });
  }

  void _setquest(int param) {
    setState(() {
      //_quest = 'hrt';
      _quest = '${_p.name}, ${getRandomQuestion(
        param,
        _p,
        0,
      ).question}';
      if (param == 0) {
        _questionColor = ThemeManager.gold;
        _bgImg = AssetImage(ImageManager.truthSide);
      } else {
        _questionColor = ThemeManager.blood;
        _bgImg = AssetImage(ImageManager.dareSide);
      }
      _choiceButtonVisibility = false;
      _judgeVisibility = true;
    });
  }

  // ignore: unused_element
  void _deeddone(num scr) {
    _p.addScore(scr);
    if (false) {
      setState(() {
        _choiceButtonVisibility = true;
        _judgeVisibility = false;
      });
    }
    //Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
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
                      builder: (context) => getQuestsPage("Add Questions")));
            },
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: _bgImg, fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //mainAxisSize: MainAxisSize.min,
          children: [
            GradientText(
              '  ${_p.name}  ',
              shaderRect: const Rect.fromLTWH(90.0, 28.0, 100.0, 90.0),
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
                    blurRadius: 7.0,
                    color: Color.fromARGB(172, 0, 0, 0),
                    offset: Offset(5.0, 5.0),
                  ),
                ],
                //fontFamilyFallback: Typography._helsinkiFontFallbacks,
                fontFamily: 'Black Cherry',
                //color: Color(0xFF250038),
              ),
            ),
            Spacer(flex: 2),
            Visibility(
              visible: _judgeVisibility,
              child: Card(
                borderOnForeground: true,
                elevation: 10,
                color: _questionColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  width: 550,
                  //height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      _quest!,
                      maxLines: 3,
                      style: TextStyle(
                        fontFamily: 'Black Cherry',
                        fontSize: 31,
                        fontWeight: FontWeight.w900,
                        color: getQColors(_questionColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
            Visibility(
              visible: _choiceButtonVisibility,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(flex: 1),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      _setquest(1);
                    },
                    child: Text(
                      'Dare',
                      style: const TextStyle(
                        fontSize: 80,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            blurRadius: 7.0,
                            color: Color.fromARGB(97, 167, 0, 0),
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                        //fontFamilyFallback: Typography._helsinkiFontFallbacks,
                        fontFamily: 'Black Cherry',
                        color: ThemeManager.blood,
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      _setquest(0);
                    },
                    child: Text(
                      'Truth',
                      style: const TextStyle(
                        fontSize: 80,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            blurRadius: 7.0,
                            color: Color.fromARGB(92, 255, 176, 7),
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                        fontFamily: 'Black Cherry',
                        color: ThemeManager.gold,
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
            //Spacer(flex: 1),
            Visibility(
              visible: _judgeVisibility,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(flex: 1),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      _deeddone(-2);
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      'Forfeited',
                      style: const TextStyle(
                        fontSize: 130,
                        fontFamily: 'Candy',
                        color: ThemeManager.blood,
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onLongPress: () {
                      _deeddone(5);
                      Navigator.pop(context, true);
                    },
                    onPressed: () {
                      _deeddone(2);
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      'Completed',
                      style: const TextStyle(
                        fontSize: 130,
                        fontFamily: 'Candy',
                        color: ThemeManager.gold,
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
