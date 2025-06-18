import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:randomizer_new/bloc/crud_stack_bloc.dart';
// import 'package:randomizer_new/bloc/event_state/crud_stack_es.dart';

// import '../../bloc/providers/provider_bloc.dart';

class RootDrawerPage extends StatelessWidget {
  const RootDrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Root Drawer Page");
  }
  
}

/*
class RootDrawerPage extends StatefulWidget {
  const RootDrawerPage({super.key});

  @override
  createState() => _RootDrawerPageState();
}

class _RootDrawerPageState extends State<RootDrawerPage> {
  // List<bool> boolList = [];
  // List<CardsStack> stacks = [];

  @override
  Widget build(BuildContext context) {
    // return

    // BlocBuilder<CRUDStackBloc, CRUDStackState>(
    //     builder: (context, state) {
    // if (state is CRUDStackSuccessActionState) {

    //   var allStacks = state.stacks;
    //   if(allStacks.isNotEmpty) {
    //     stacks = allStacks;
    //     for (var element in allStacks) {

    //         boolList.add(element.isActive);

    //     }
    //   }
    // } else {
    //   print("RootAppBar state is NOT CRUDStackSuccessActionState");
    // }
    return Container(
      color: Colors.blue.shade200,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: TextButton(
              child: const Text('Update / Create  stack'),
              onPressed: () {

                context.read<CRUDStackBloc>().add(CRUDStackInitialEvent());
                context.read<ProviderBloc>().add(UpdateDeleteEvent());
              },
            ),
          ),
          const SizedBox(),
        ],
      ),
      //);
      //}
    );
  }
}

/*
    Container(
      color: Colors.black,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: const Border(
            right: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
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
              for(var i = 0; i < stacks.length; i++) {
                if(stacks[i].isActive != boolList[i]) {
                  idList.add(stacks[i].id);
                }
              }
      
                context.read<CRUDStackBloc>()
                    .add(CRUDStackUpdateAvailableListEvent(idList));
              context.read<ProviderBloc>().add(LoadingEvent());
            },
          ),
          const Divider(),
        TextButton(child: const Text('Update / Create  stack'),
          onPressed: () {
            //Navigator.pop(context);
      
            //context.read<ProviderBloc>().add(UpdateDeleteEvent());
          },
        ),],
      ),),
    );  
  }
    );}
}*/
*/
