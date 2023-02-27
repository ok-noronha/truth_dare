import 'colors.dart';

import 'question_man.dart';

import 'package:flutter/material.dart';

dynamic getQuestsPage(String n) => const _QuestsPage(
      title: 'n',
    );

class _QuestsPage extends StatefulWidget {
  // ignore: unused_element
  const _QuestsPage({super.key, required this.title});
  final String title;

  @override
  State<_QuestsPage> createState() => _Queststate();
}

class _Queststate extends State<_QuestsPage> {
  late TextEditingController _questController;
  //late TextEditingController _genc;
  String dropdownValue = 'None';
  String typeValue = 'Truth';
  List<String> _typeItems = <String>['Truth', 'Dare'];
  List<String> _dropdownItems = <String>['None', 'Male', 'Female'];

  @override
  void initState() {
    super.initState();
    _questController = TextEditingController();
  }

  @override
  void dispose() {
    _questController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Questions",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Black Cherry',
          ),
        ),
        backgroundColor: ThemeManager.appBarbg,
        foregroundColor: ThemeManager.appBarfg,
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        //height: 400,
        child: SizedBox(
          child: Column(children: [
            TextField(
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              controller: _questController,
              autofocus: true,
              decoration: const InputDecoration(hintText: "Question"),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              items:
                  _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: typeValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  typeValue = value!;
                });
              },
              items: _typeItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                Question.addQuestion(
                    _questController.text,
                    _getNumfrmGen(dropdownValue),
                    typeValue); //add new element to list
                Navigator.pop(context, true);
              },
              child: const Text('Done'),
            ),
          ]),
        ),
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
}
