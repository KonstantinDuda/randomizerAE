import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../bloc/providers/provider_bloc.dart';
import '../../database/cards_stack.dart';

class RootDrawer extends StatefulWidget {

  const RootDrawer({super.key});


  @override
  State<RootDrawer> createState() => _RootDrawerState();
}

class _RootDrawerState extends State<RootDrawer> {
  List<bool> boolList = [];
  List<CardsStack> stacks = [];
  
  // @override
  // void initState() {
  //   super.initState();
  //   if(db.isEmpty) {
  //     getData();
  //   }
  // }

  // getData() async {
  //   db = await dbObj.getStacks(); //getAvialableStacks();
  //   for (var i in db) {
  //     boolList.add(i.isActive);
  //     // if(i.isActive) {
  //     //   newAvList.add(i);
  //     // }
  //   }
    
  //   setState(() {});
  // }
    
  @override
  Widget build(BuildContext context) {
    return 
    BlocBuilder<CRUDStackBloc, CRUDStackState>(
        builder: (context, state) {
      if (state is CRUDStackSuccessActionState) {
        //stacks.clear();
        //boolList.clear();
        var allStacks = state.stacks;
        if(allStacks.isNotEmpty) {
          stacks = allStacks;
          for (var element in allStacks) {
            
              boolList.add(element.isActive);
            
          }
        }
      } else {
        print("RootAppBar state is NOT CRUDStackSuccessActionState");
      }
    return 


    Drawer(
      child: Column( children: <Widget> [
        const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(child: Text('Stack List')),
          ),
        Flexible(
          child: ListView.builder(
            //itemCount: db.length,
            itemCount: stacks.isNotEmpty ? stacks.length : 0,
            itemBuilder: (context, index) {
              
              return SizedBox(
                width: 250,
                child: 
                Row(
                  children: [
                    TextButton(
                      child: SizedBox(
                        width: 190,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          // db[index].name),
                          stacks[index].name),
                      ),
                      onPressed: () {
                        
                        Navigator.pop(context);
                      },),
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      width: 30,
                      height: 40,
                      decoration: BoxDecoration(
                        // color: db[index].stackColor,
                        color: stacks[index].stackColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                      ),
                    ),
                    ),
                    Checkbox(
                      value: boolList[index], 
                      onChanged: (bool? value) {
                        setState(() {
                          boolList[index] = value!;
                        });
                      }
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        TextButton(
          child: const Text('Save changes'),
          onPressed: () {
            List<int> idList = [];
            // for(var i = 0; i < db.length; i++) {
            //   if(db[i].isActive != boolList[i]) {
            //     idList.add(db[i].id);
            //   }
            // }
            for(var i = 0; i < stacks.length; i++) {
              if(stacks[i].isActive != boolList[i]) {
                idList.add(stacks[i].id);
              }
            }
            // context.read<TurnOrderBodyBloc>()
            //       .add(TurnOrderBodyChangeAvailableStackListEvent(idList));
            // context.read<CRUDStackBloc>()
            //       .add(CRUDStackInitialEvent());
              context.read<CRUDStackBloc>()
                  .add(CRUDStackUpdateAvailableListEvent(idList));
            context.read<ProviderBloc>().add(LoadingEvent());
          },
        ),
        const Divider(),
      TextButton(child: const Text('Update / Create  stack'),
        onPressed: () {
          Navigator.pop(context);

          context.read<ProviderBloc>().add(UpdateDeleteEvent());
        },
      ),],
    ),);  
  }
    );}
}