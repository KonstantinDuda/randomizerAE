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
  MyDatabase db = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: _buttonsColor(1),
              ),
              onPressed: () {
                print('1 Player pressed');
                _buttonIsActive(1)
                    ? _randomizer(context, 1)
                    : print('Button is not active');
                //_randomizer(context, 1);
              },
              child: const Text('1 Player'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: _buttonsColor(2),
              ),
              onPressed: () {
                print('2 Player pressed');
                _buttonIsActive(2)
                    ? _randomizer(context, 2)
                    : print('Button is not active');
                //_randomizer(context, 2);
              },
              child: const Text('2 Player'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: _buttonsColor(3),
              ),
              onPressed: () {
                print('3 Player pressed');
                _buttonIsActive(3)
                    ? _randomizer(context, 3)
                    : print('Button is not active');
                //_randomizer(context, 3);
              },
              child: const Text('3 Player'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: _buttonsColor(4),
              ),
              // MaterialStatePropertyAll<Color>(Colors.blue)),
              onPressed: () {
                print('4 Player pressed');
                _buttonIsActive(4)
                    ? _randomizer(context, 4)
                    : print('Button is not active');
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
      print('DBcount == ${db.getCount()}');
      for (var i = 0; i < results.length - 1; i++) {
        if (number == results.elementAt(i)) {
          uniq = false;
        }
      }
      if (uniq == true) {
        results.add(number);
      }
    }
    print(results);
    context.read<ProviderBloc>().add((DialogEvent(results)));
  }

  _buttonsColor(int number) {
    MaterialStatePropertyAll<Color> color;
    db.getCount() >= number
        ? color = const MaterialStatePropertyAll<Color>(Colors.blue)
        : color = const MaterialStatePropertyAll<Color>(Colors.grey);
    return color;
  }

  _buttonIsActive(int number) {
    bool isActive = false;
    db.getCount() >= number ? isActive = true : isActive = false;
    return isActive;
  }
}
