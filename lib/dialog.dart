import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer/bloc_provider.dart';
import 'package:randomizer/database.dart';

class MyDialog extends StatefulWidget {
  //Set<int> playerList;

  MyDialog(/*this.playerList,*/ {super.key}) {}

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  //List<Set<int>> results = [];
  String stringResults = '';

  @override
  void initState() {
    super.initState();

    MyDatabase _db = MyDatabase();

    for (var i = 0; i < _db.getLength(); i++) {
      Set<int> mySet = {};
      String outputText = '';
      bool uniq = true;

      for (var j = 0; j < _db.getObj(i).numberOfResults; j++) {
        var randomNumber = Random().nextInt(_db.getObj(i).maximum);
        for (var y = 0; y < mySet.length; y++) {
          if (randomNumber == mySet.elementAt(y)) {
            uniq = false;
          }
        }
        if (uniq) {
          mySet.add(randomNumber);
        }

        print('i==$i, j==$j, randome==$randomNumber');
      }

      outputText = '${_db.getObj(i).name} = ${mySet.toString()}';
      setState(() {
        stringResults += '$outputText \n';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(stringResults),
        ),
        TextButton(
          onPressed: () {
            stringResults = '';
            context.read<ProviderBloc>().add((RootEvent()));
          },
          child: const Text('Turn back to the main screen'),
        ),
      ],
    );
  }
}
