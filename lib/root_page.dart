import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer/database.dart';

import 'bloc_provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                print('1 Player pressed');
                _randomizer(context, 1);
              },
              child: const Text('1 Player'),
            ),
            TextButton(
              onPressed: () {
                print('2 Player pressed');
                _randomizer(context, 2);
              },
              child: const Text('2 Player'),
            ),
            TextButton(
              onPressed: () {
                print('3 Player pressed');
                _randomizer(context, 3);
              },
              child: const Text('3 Player'),
            ),
            TextButton(
              onPressed: () {
                print('4 Player pressed');
                _randomizer(context, 4);
              },
              child: const Text('4 Player'),
            ),
          ]),
    );
  }

  _randomizer(BuildContext context, int count) {
    Set<int> results = {};
    MyDatabase db = MyDatabase();

    while (results.length - 1 < count - 1) {
      var number = Random().nextInt(db.getCount());
      bool uniq = true;
      //print('number == $number');
      //print('DBcount == ${db.getCount()}');
      for (var i = 0; i < results.length - 1; i++) {
        if (number == results.elementAt(i)) {
          uniq = false;
        }
      }
      if (uniq == true) {
        results.add(number);
      }

      //uniq = true;
    }
    print(results);
    context.read<ProviderBloc>().add((DialogEvent(results)));

    /*for (var i = 0; i < count; i++) {
      var number = Random().nextInt(MyDatabase().getCount);
      print(number);
      for (var j = 0; j < results.length; j++) {
        if (number != results[j]) {

        }
      }
      results.add(Random().nextInt(MyDatabase().getCount));
    }*/
  }
}
