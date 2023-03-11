import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer/bloc_provider.dart';

class MyDialog extends StatelessWidget {
  Set<int> playerList;
  String result = '';
  MyDialog(this.playerList, {super.key}) {
    print(playerList);
    if (playerList.length > 0) {
      print('list isEmpty');
      if (playerList.length == 1) {
        result = 'Player One = ${playerList.elementAt(0)}';
      } else if (playerList.length == 2) {
        result =
            'Player One = ${playerList.elementAt(0)} \n Player Two = ${playerList.elementAt(1)}';
      } else if (playerList.length == 3) {
        result =
            'Player One = ${playerList.elementAt(0)} \n Player Two = ${playerList.elementAt(1)} \n Player Three = ${playerList.elementAt(2)}';
      } else if (playerList.length == 4) {
        result =
            'Player One = ${playerList.elementAt(0)} \n Player Two = ${playerList.elementAt(1)} \n Player Three = ${playerList.elementAt(2)} \n Player Four = ${playerList.elementAt(3)}';
      } else {
        result = 'Incorrect value';
      }
    } else {
      print('list is NOT Empty');
    }
    print('dialog results == $result');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text('$result'),
        ),
        TextButton(
          onPressed: () {
            context.read<ProviderBloc>().add((RootEvent()));
          },
          child: Text('Turn back to the main screen'),
        ),
      ],
    );
  }
}
