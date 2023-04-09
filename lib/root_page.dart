import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer/database.dart';

import 'bloc_provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final MyDatabase _db = MyDatabase();
  List<FormView> formList = [FormView()];
  int _selectedIndex = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setState(() {
      if (_db.getLength() > 0) {
        for (int i = 0; i < _db.getLength(); i++) {
          print(_db.getObj(i));
          formList[i]._controllerName.text = _db.getObj(i).name;
          formList[i]._controllerMaximum.text =
              _db.getObj(i).maximum.toString();
          formList[i]._controllerNumberOfResults.text =
              _db.getObj(i).numberOfResults.toString();
          _addForm();
        }
      }
    });
  }

  _randomize() {
    bool uniq = true;
    for (var element in formList) {
      var name = element._controllerName.text;
      print(name);
      var max = int.parse(element._controllerMaximum.text);
      print(max);
      var number = int.parse(element._controllerNumberOfResults.text);
      print(number);
      FormDatabase fdb = FormDatabase(
        name,
        max,
        number,
      );
      for (int i = 0; i < _db.getLength(); i++) {
        if (_db.getObj(i).name == fdb.name) uniq = false;
      }
      if (uniq) {
        _db.addFDB(fdb);
      }
    }
    //context.read<ProviderBloc>().add((const DialogEvent()));
  }

  _onItemTapped(int index) {
    if (index == 1) {
      _randomize();
      context.read<ProviderBloc>().add(const DialogEvent());
    } else {
      _addForm();
    }
    setState(() {});
  }

  _addForm() {
    print('add obj...');
    setState(() {
      formList.add(FormView());
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randomizer Aeons End'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Scrollbar(
          thumbVisibility: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: formList,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              label: 'Add Form', icon: Icon(Icons.add_a_photo_outlined)),
          //label: 'Create form', icon: Icon(Icons.article_outlined)),
          //label: 'Choose random heroes', icon: Icon(Icons.casino_outlined)),
          BottomNavigationBarItem(
              label: 'Randomize', icon: Icon(Icons.casino_outlined)),
          //label: 'Add picture', icon: Icon(Icons.add_a_photo_outlined)),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class FormView extends StatelessWidget {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerMaximum = TextEditingController();
  final TextEditingController _controllerNumberOfResults =
      TextEditingController();

  FormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 1.5,
        ),
      ),
      margin: const EdgeInsets.fromLTRB(70, 10, 70, 30),
      //width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height - 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //const Divider(color: Colors.blue),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 32,
            child: TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                border: InputBorder.none,
                hintText: 'Enter the Object Name',
              ),
              controller: _controllerName,
              expands: true,
              maxLines: null,
              //keyboardType: TextInputType.number,
              autofocus: true,
              onChanged: (value) {
                print(_controllerName.text);
              },
              //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const Divider(),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 32,
            child: TextField(
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: InputBorder.none,
                  hintText: 'Enter maximum object count'),
              controller: _controllerMaximum,
              expands: true,
              maxLines: null,
              keyboardType: TextInputType.number,
              //autofocus: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const Divider(),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 32,
            child: TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                border: InputBorder.none,
                hintText: 'Enter the count of objects that you need',
              ),
              controller: _controllerNumberOfResults,
              expands: true,
              maxLines: null,
              keyboardType: TextInputType.number,
              //autofocus: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          //const Divider(),
        ],
      ),
    );
  }
}
