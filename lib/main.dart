import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer/bloc_provider.dart';
import 'package:randomizer/root_page.dart';

import 'add_page.dart';
import 'dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randomizer Aeons End',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => ProviderBloc(),
        child: const MyHomePage(title: 'Randomizer Aeons End'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;
  int _selectedIndex = 0;

  _onItemTapped(int index) {
    if (index == 1) {
      context.read<ProviderBloc>().add(AddEvent());
    } else {
      context.read<ProviderBloc>().add(RootEvent());
    }
    setState(() {
      //  _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<ProviderBloc, ProviderState>(
        builder: (_, state) {
          if (state is AddState) {
            return const AddPage();
          } else if (state is DialogState) {
            return MyDialog(state.list);
          } else {
            return const RootPage();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: 'Choose random heroes', icon: Icon(Icons.casino_outlined)),
          BottomNavigationBarItem(
              label: 'Add picture', icon: Icon(Icons.add_a_photo_outlined)),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
