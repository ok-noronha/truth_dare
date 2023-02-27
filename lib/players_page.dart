import 'colors.dart';

import 'player_man.dart';

import 'package:flutter/material.dart';

dynamic getPLayersPage(String n) => const _PlayersPage(
      title: 'n',
    );

class _PlayersPage extends StatefulWidget {
  // ignore: unused_element
  const _PlayersPage({super.key, required this.title});
  final String title;

  @override
  State<_PlayersPage> createState() => _PlayerState();
}

class _PlayerState extends State<_PlayersPage> {
  late TextEditingController _playerController;
  //late TextEditingController _genc;
  String dropdownValue = 'None';
  // ignore: prefer_final_fields
  List<String> _dropdownItems = <String>['None', 'Male', 'Female'];

  @override
  void initState() {
    super.initState();
    if (Player.getPlayers().isEmpty) {
      Player.addPlayer(Player.getPlayers().length + 1, 'Player 1', 0);
    }
    _playerController = TextEditingController();
    //_genc = TextEditingController();
  }

  @override
  void dispose() {
    _playerController.dispose();
    //_genc.dispose();
    super.dispose();
  }

  String _genGender(var p) {
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
        title: const Text(
          "Players",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Black Cherry',
          ),
        ),
        backgroundColor: ThemeManager.appBarbg,
        foregroundColor: ThemeManager.appBarfg,
      ),
      body: Column(
        children: [
          SizedBox(
            //height: 400,
            child: SingleChildScrollView(
              child: Column(
                children: Player.getPlayers().map((player) {
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
                          setState(() {});
                        },
                      ),
                      title: Text('${player.id}. ${player.name}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${player.score} Souls       '),
                          //Spacer(),
                          ElevatedButton(
                            child: const Icon(Icons.delete),
                            onPressed: () {
                              //delete action for this button
                              Player.getPlayers().removeWhere((element) {
                                return element.id == player.id;
                              }); //go through the loop and match content to delete from list
                              setState(() {
                                //refresh UI after deleting element from list
                              });
                            },
                          ),
                          //Spacer(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Spacer(flex: 4),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Done'),
            ),
          ),
          const Spacer(flex: 1),
        ],
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

  int _getNumfrmGen(String g) {
    if (g.startsWith('M')) {
      return 1;
    } else if (g.startsWith('F')) {
      return -1;
    } else {
      return 0;
    }
  }

  Future _openNewPlayer() => showDialog(
        useSafeArea: true,
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Add Player",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: SizedBox(
            height: 90,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic),
                    controller: _playerController,
                    autofocus: true,
                    decoration: const InputDecoration(hintText: "Player Name"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic),
                    //underline: Container(),
                    onChanged: (String? value) async {
                      dropdownValue = value!;
                      Navigator.pop(context);
                      await _openNewPlayer();
                      // This is called when the user selects an item.
                      setState(() {});
                    },
                    items: _dropdownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                Player.addPlayer(Player.getPlayers().length + 1,
                    _playerController.text, _getNumfrmGen(dropdownValue));
                _playerController.clear();
                //_genc.clear();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
}
