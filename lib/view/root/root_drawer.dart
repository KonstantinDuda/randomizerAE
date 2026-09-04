import 'package:card_randomizer/bloc/event_state/turn_order_body_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_stack_bloc.dart';
import '/bloc/turn_order_body_bloc.dart';
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
  List<String> type = [
    "All",
    "Turn order",
    "Friends",
    "Foes",
    "Friends and Foes",
    "Other"
  ];
  String curentType = "All";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CRUDStackBloc, CRUDStackState>(
        builder: (context, state) {
      if (state is CRUDStackSuccessActionState) {
        //stacks.clear();
        //boolList.clear();
        var allStacks = state.stacks;
        curentType = state.filterType == "" ? "All" : state.filterType;
        if (allStacks.isNotEmpty) {
          stacks = allStacks;
          //boolList.clear();
          for (var element in allStacks) {
            boolList.add(element.isActive);
          }
        }
      } else {
        print("RootAppBar state is NOT CRUDStackSuccessActionState");
      }
      return Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  const Expanded(child: Center(child: Text('Stack List'))),
                  // Filter dropdown
                  DropdownButton<String>(
                    iconSize: 35,
                    iconEnabledColor: Colors.black,
                    value: curentType,
                    hint: const Text("Select filter"),
                    items: type.map((String item) {
                      return DropdownMenuItem<String>(
                        alignment: AlignmentDirectional.center,
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      if (value != null) {
// Change Available list before changing filter, so that the changes are saved before filtering
                        List<int> idList = [];
                        for (var i = 0; i < stacks.length; i++) {
                          if (stacks[i].isActive != boolList[i]) {
                            idList.add(stacks[i].id);
                          }
                        }
                        boolList.clear();
                        context
                            .read<CRUDStackBloc>()
                            .add(CRUDStackUpdateAvailableListEvent(idList));
                        context
                            .read<TurnOrderBodyBloc>()
                            .add(TurnOrderAddDeleteStackEvent(idList));
                        // Change filter after saving changes
                        context
                            .read<CRUDStackBloc>()
                            .add(CRUDStackFilterEvent(value, ""));
//                        changeFilter(value, context);
                        //widget.changeColor(value);
                      }
                    },
                  ),
                ],
              ),
            ),
            // Stacks list
            Flexible(
              child: ListView.builder(
                //itemCount: db.length,
                itemCount: stacks.isNotEmpty ? stacks.length : 0,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 250,
                    child: Row(
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
                          },
                        ),
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
                            }),
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
                for (var i = 0; i < stacks.length; i++) {
                  if (stacks[i].isActive != boolList[i]) {
                    idList.add(stacks[i].id);
                  }
                }
                context
                    .read<CRUDStackBloc>()
                    .add(CRUDStackUpdateAvailableListEvent(idList));
                context
                    .read<TurnOrderBodyBloc>()
                    .add(TurnOrderAddDeleteStackEvent(idList));
                context
                    .read<CRUDStackBloc>()
                    .add(const CRUDStackFilterEvent("All", ""));
                //context.read<CRUDStackBloc>().add(CRUDStackInitialEvent());
                context.read<ProviderBloc>().add(LoadingEvent());
                Navigator.pop(context);
              },
            ),
            const Divider(),
            TextButton(
              child: const Text('Update / Create  stack'),
              onPressed: () {
                Navigator.pop(context);

                context.read<CRUDStackBloc>().add(CRUDDataFromDBEvent());
                context.read<ProviderBloc>().add(UpdateDeleteEvent());
              },
            ),
          ],
        ),
      );
    });
  }
}
