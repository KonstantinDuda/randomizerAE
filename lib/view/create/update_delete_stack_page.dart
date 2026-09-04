import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../root/bodyes/my_card.dart';
import '/bloc/providers/provider_bloc.dart';
import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '/database/cards_stack.dart';
import 'dialog_create_card.dart';
import 'dialog_delete.dart';
import 'stack_widget.dart';

class UpdateDeleteStackPage extends StatefulWidget {
  const UpdateDeleteStackPage({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateDeleteStackPageState();
}

class _UpdateDeleteStackPageState extends State<UpdateDeleteStackPage> {
  List<AECard> cards = [];
  List<CardsStack> stacks = [];
  Size screenSize = const Size(0, 0);

  List<String> typesList = [];
  List<Color> colorsList = [];
  var curentColor = const Color.fromARGB(255, 255, 255, 255);

  List<String> typeString = [
    "All",
    "Turn order",
    "Friends",
    "Foes",
    "Friends and Foes",
    "Other"
  ];
  String curentTypeString = "All";

  stackColor(Color color) {
    return Container(
      width: 20,
      height: 20,
      color: color,
    );
  }

  cardWidget(int index) {
    return Column(
      children: [
        MyCard(
          cards[index],
          const Size(150, 220),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    CreateCardDialog(cards[index]));
          },
          child: const Text("Update card"),
        ),
        ElevatedButton(
          onPressed: () {
            var text = cards[index].text.split(":")[0];
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    DeleteDialog(text, true, false, cards[index].id));
            //context.read<CRUDStackBloc>().add(CRUDStackDeleteCardEvent(cards[index].id));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text("Delete card"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CRUDStackBloc, CRUDStackState>(
        builder: (context, state) {
      if (state is CRUDStackSuccessActionState) {
        cards = state.cards;
        var allStacks = state.stacks;
        if (allStacks.isNotEmpty) {
          stacks = allStacks;
        }
        print("UpdateDeleteStackPage build state is CRUDStackSuccessActionState"
            " \n cards.length == ${cards.length} stacks.length == ${stacks.length}");
        screenSize = MediaQuery.of(context).size;
        typesList.clear();
        colorsList.clear();
        for (var element in stacks) {
          //print("UpdateDeleteStackPage build element.name == ${element.name} element.stackType == ${element.stackType}");
          var stackType = "";
          if (element.stackType == StackType.turnOrder) {
            stackType = "Turn order";
          } else if (element.stackType == StackType.friend) {
            stackType = "Friend";
          } else if (element.stackType == StackType.foe) {
            stackType = "Foe";
          } else if (element.stackType == StackType.other) {
            stackType = "Other";
          }
          if (stackType != "" && stacks.length > typesList.length) {
            typesList.add(stackType);
            colorsList.add(element.stackColor);
          }
        }
        curentTypeString = state.filterType;
        // print("UpdateDeleteStackPage build typesList == $typesList");
        // print("UpdateDeleteStackPage build colorsList.length == ${colorsList.length}");
      } else {
        print(
            "UpdateDeleteStackPage build state is not CRUDStackSuccessActionState \n");
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Create / Update page'),
              ElevatedButton(
                onPressed: () {
                  context.read<ProviderBloc>().add(RootEvent());
                  context
                      .read<CRUDStackBloc>()
                      .add(const CRUDStackFilterEvent("All", ""));
                },
                child: const Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Cards
              SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: const Text("Cards",
                                  style: TextStyle(fontSize: 20))),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Filter',
                              ),
                              onChanged: (value) {
                                context.read<CRUDStackBloc>().add(
                                    CRUDStackFilterEvent(
                                        curentTypeString, value));
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CreateCardDialog(
                                          AECard(id: 0, text: "", name: "")));
                            },
                            child: const Text("Create card",
                                style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 330,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: cards.isEmpty ? 0 : cards.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => cardWidget(index),
                      ),
                    ),
                  ],
                ),
              ),
              // Stacks
              SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: const Text("Stacks",
                                  style: TextStyle(fontSize: 20))),
                          DropdownButton<String>(
                            iconSize: 35,
                            iconEnabledColor: Colors.black,
                            value: curentTypeString,
                            hint: const Text("Select filter"),
                            items: typeString.map((String item) {
                              return DropdownMenuItem<String>(
                                alignment: AlignmentDirectional.center,
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              if (value != null) {
                                context
                                    .read<CRUDStackBloc>()
                                    .add(CRUDStackFilterEvent(value, ""));
                              }
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProviderBloc>()
                                  .add(const CreateEvent(0));
                            },
                            child: const Text("Create stack",
                                style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 525,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: stacks.isEmpty ? 0 : stacks.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => StackWidget(stacks[index],
                            key: Key(stacks[index].id.toString())),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
