import 'dart:async';

import 'colors.dart';
import 'images.dart';

import 'players_page.dart';
//import 'round_page.dart';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:animations/animations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;
  final List<String> _backgroundImages = <String>[
    ImageManager.heaven,
    ImageManager.hell
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentPage == _backgroundImages.length - 1) {
        _currentPage = 0;
      } else {
        _currentPage++;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 1000),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => getPLayersPage("Players")));
            },
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 30),
        onEnd: () {
          setState(() {
            _currentPage = _pageController.page!.round();
          });
        },
        height: double.maxFinite,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            PageView.builder(
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
            Visibility(
              visible: true,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 90,
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      //_setplayer();
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
