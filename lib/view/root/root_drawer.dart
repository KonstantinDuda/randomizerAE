import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/bloc/event_state/root_body_es.dart';
import 'package:randomizer_new/bloc/providers/provider_bloc.dart';
import 'package:randomizer_new/bloc/root_body_bloc.dart';

import '../../database/cards_stack.dart';
import '../../database/db_temporary.dart';

class RootDrawer extends StatefulWidget {
  RootDrawer({super.key});


  @override
  State<RootDrawer> createState() => _RootDrawerState();
}

class _RootDrawerState extends State<RootDrawer> {
  DbTemporary dbObj = DbTemporary();
  List<CardsStack> db = [];
  
  @override
  void initState() {
    super.initState();
    if(db.isEmpty) {
      getData();
    }
  }

  getData() async {
    db = await dbObj.getAvialableStacks();
    setState(() {});
  }
    
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column( children: <Widget> [
        const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(child: Text('Stack List')),
          ),
        Flexible(
          child: ListView.builder(
            itemCount: db.length,
            itemBuilder: (context, index) {
              //var stackColor = textToColor(db.dbStacks[index].stackColor);
//print("stackColor is $stackColor");

              return SizedBox(
                width: 200,
                child: 
                Row(
                  children: [
                    TextButton(
                      child: SizedBox(
                        width: 190,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          db[index].name),
                      ),
                      onPressed: () {
                        // Handle stack selection
                        context.read<RootBodyBloc>().add(RootBodyChangeActiveStackEvent(db[index].id));
                        context.read<ProviderBloc>().add(RootEvent());
                        Navigator.pop(context);
                      },),
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      width: 30,
                      height: 40,
                      decoration: BoxDecoration(
                        color: db[index].stackColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                      ),
                    ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      TextButton(child: const Text('Add / Create  stack'),
        onPressed: () {},
      ),],
    ),);  
  }
}