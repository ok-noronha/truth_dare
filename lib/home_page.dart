// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'colors.dart';
import 'images.dart';

import 'player_man.dart';
import 'question_man.dart';

import 'players_page.dart';
import 'round_page.dart';

import 'package:flutter/material.dart';
//import 'package:getwidget/getwidget.dart';
//import 'package:animations/animations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pageController = PageController();
  int _currentPage = 0;
  int _rounds = 0;
  int c = 0;
  final String _labelImage = ImageManager.backgroundImage;
  late Timer _timer;
  bool _playButtonVisibility = true;
  bool _imageVisibility = true;
  final List<String> _backgroundImages = <String>[
    ImageManager.heaven,
    ImageManager.hell
  ];

  @override
  void initState() {
    super.initState();
    c++;
    Data d = getData();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_currentPage == _backgroundImages.length - 1) {
        _currentPage = 0;
      } else {
        _currentPage++;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 5000),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.backgroundColor,
      appBar: AppBar(
        title: Text(
          '$widget.title - $c',
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
              _rounds++;
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
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 1),
        onEnd: () {
          setState(() {
            _currentPage = _pageController.page!.round();
          });
        },
        height: double.maxFinite,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Visibility(
              visible: _imageVisibility,
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    _backgroundImages[index],
                    fit: BoxFit.cover,
                  );
                },
                itemCount: _backgroundImages.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
            Visibility(
              visible: _imageVisibility,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  _labelImage,
                  scale: 1 / 2,
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
                      _rounds++;
                      if (Player.getRandomPlayer() == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    getPLayersPage("Players")));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    getRoundPage('Round $_rounds')));
                      }
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
    );
  }
}
