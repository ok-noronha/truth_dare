import 'ai trials/player_man.dart';
import 'ai trials/colors.dart';
import 'ai trials/images.dart';
import 'ai trials/ui_helpers.dart';
import 'ai trials/question_man.dart';
import 'ai trials/players_page.dart';
import 'package:flutter/material.dart';
import 'package:fancy_button_flutter/fancy_button_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Player _p = Player.getPlayerObj();
  String _name = "";
  String? _quest = "";
  bool _playButtonVisibility = true;
  bool _playerNameVisibility = false;
  bool _questionVisibility = false;
  bool _choiceButtonVisibility = false;
  bool _imageVisibility = true;
  bool _judgeVisibility = false;

  @override
  void initState() {
    getData();
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
      _imageVisibility = false;
      _questionVisibility = false;
      _playerNameVisibility = true;
      _choiceButtonVisibility = true;
      _playButtonVisibility = false;
      _judgeVisibility = false;
    });
  }

  void _setquest(int param) {
    setState(() {
      _quest = '${_p.name}, ${getRandomQuestion(param, _p, 0).question}';
      _questionVisibility = true;
      _choiceButtonVisibility = false;
      _judgeVisibility = true;
      _playerNameVisibility = true;
      _playButtonVisibility = false;
      _imageVisibility = false;
    });
  }

  void _deeddone(num scr) {
    _p.addScore(scr);
    setState(() {
      _choiceButtonVisibility = false;
      _judgeVisibility = false;
      _playButtonVisibility = true;
      _playerNameVisibility = false;
      _questionVisibility = false;
      _imageVisibility = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeManager.backgroundColor,
        appBar: AppBar(
          title: Text(
            widget.title,
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Black Cherry',
            ),
          ),
          backgroundColor: ThemeManager.appBarbg,
          //foregroundColor: ,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_box_rounded),
              //splashRadius: 10,
              alignment: const Alignment(0, 0),
              tooltip: 'Player Settings',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => getPLayersPage("Players")));
              },
            ),
          ],
        ),
        body: SizedBox(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: _playerNameVisibility,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        _name,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: MyColors.dark,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                          //fontFamilyFallback: Typography._helsinkiFontFallbacks,
                          fontFamily: 'Consolas',
                          color: MaterialColors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: _questionVisibility,
                  child: SizedBox(
                    width: 300,
                    height: 200,
                    child: Card(
                      borderOnForeground: true,
                      elevation: 10,
                      color: MyColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 250,
                          child: Text(
                            _quest!,
                            style: const TextStyle(
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _imageVisibility,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 84.0,
                    left: 15,
                    right: 15,
                  ),
                  child: Image.asset(
                    ImageManager.backgroundImage,
                    scale: 1 / 2,
                    //fit: BoxFit.cover,
                  ),
                ),
              ),
              Visibility(
                visible: _choiceButtonVisibility,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 205,
                        child: Image.asset(ImageManager.truthSide),
                      ),
                      SizedBox(
                        width: 205,
                        child: Image.asset(ImageManager.dareSide),
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
                                image:
                                    const AssetImage(ImageManager.truthImage),
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
              Visibility(
                visible: _playButtonVisibility,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 90,
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        _setplayer();
                      },
                      tooltip: 'Next Round',
                      child: const Icon(Icons.play_arrow_rounded),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
