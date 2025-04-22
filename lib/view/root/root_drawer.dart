import 'package:flutter/material.dart';

import '../../database/db_temporary.dart';

class RootDrawer extends StatefulWidget {
  RootDrawer({super.key});


  @override
  State<RootDrawer> createState() => _RootDrawerState();
}

class _RootDrawerState extends State<RootDrawer> {
  DbTemporary db = DbTemporary();
    
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
            itemCount: db.dbStacks.length,
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
                          db.dbStacks[index].name),
                      ),
                      onPressed: () {
                        // Handle stack selection
                        Navigator.pop(context);
                      },),
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      width: 20,
                      height: 40,
                      decoration: BoxDecoration(
                        color: db.dbStacks[index].stackColor,
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