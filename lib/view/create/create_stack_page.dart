import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../bloc/providers/provider_bloc.dart';
import '../../database/cards_stack.dart';
import 'dialog_add_card.dart';

class CreateStackPage extends StatefulWidget {
  final int id;
  const CreateStackPage(this.id, {super.key});

  @override
  State<StatefulWidget> createState() => _CreateStackPageState();
}

class _CreateStackPageState extends State<CreateStackPage> {
  CardsStack stack = CardsStack(
      id: 0,
      name: "",
      isActive: false,
      stackType: StackType.turnOrder,
      stackColor: Colors.white,
      cards: []);
  String stackName = "";
  bool isActive = false;
  String curentType = "Turn order";
  Color curentColor = Colors.white;
  List<AECard> cards = [];

  List<String> stackTypes = const [
    "Turn order",
    "Friend / Foe",
    "Gravehold",
    "Hero",
    "Nemesis",
  ];
  List<Color> stackColors = const [
    Color.fromARGB(255, 76, 175, 80),
    Color.fromARGB(255, 33, 150, 243),
    Color.fromARGB(255, 244, 67, 54),
    Color.fromARGB(255, 158, 158, 158),
    Color.fromARGB(255, 255, 193, 7),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 255, 255, 255),
  ];

  void createNewStack() {
    var stackType = StackType.turnOrder;
    if (curentType == "Turn order") {
      stackType == StackType.turnOrder;
    } else if (curentType == "Friend / Foe") {
      stackType == StackType.friendFoe;
    } else if (curentType == "Gravehold") {
      stackType == StackType.gravehold;
    } else if (curentType == "Hero") {
      stackType == StackType.hero;
    } else if (curentType == "Nemesis") {
      stackType == StackType.nemesis;
    } else {
      print(
          "CreateStackPage stack type != Turn order && Friend / Foe && Gravehold && Hero && Nemesis");
    }
    var newStack = CardsStack(
        id: widget.id,
        name: stackName,
        isActive: isActive,
        stackType: stackType,
        stackColor: curentColor,
        cards: stack.cards);
    stack = newStack;
    print("CreateStackPage createNewStack stack == $stack");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CRUDStackBloc, CRUDStackState>(
        builder: (context, state) {
      if (state is CRUDStackSuccessActionState) {
        for (var element in state.stacks) {
          if (element.id == widget.id) {
            stack = element;
          }
        }
        print("CreateStackPage state is CRUDStackSuccessActionState newStack == $stack");
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: const Text("Create Stack")),
              ElevatedButton(
                onPressed: () {
                  context.read<ProviderBloc>().add(UpdateDeleteEvent());
                },
                child: const Icon(Icons.arrow_back_sharp),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: const Text(
                      "Stack name:",
                      style: TextStyle(fontSize: 18),
                    )),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      stackName = value;
                    },
                    controller: TextEditingController(text: stackName),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Is Active: ",
                  style: TextStyle(fontSize: 18),
                ),
                Checkbox(
                    splashRadius: 18,
                    value: isActive,
                    //stacks[index].isActive,
                    onChanged: (value) {
                      setState(() {
                        isActive = value!;
                      });
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Stack Type: ",
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton<String>(
                  iconSize: 35,
                  value: curentType, //typesList[index],
                  items: stackTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      alignment: AlignmentDirectional.center,
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      curentType = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Stack color: ",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  child: DropdownButton<Color>(
                    iconSize: 35,
                    value: curentColor, //colorsList[index],
                    items: stackColors.map((Color type) {
                      return DropdownMenuItem<Color>(
                        alignment: AlignmentDirectional.center,
                        value: type, //type,
                        child: Container(
                            width: 70,
                            height: 25,
                            decoration: BoxDecoration(
                              color: type,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            )),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        curentColor = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                  //stackColor,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Cards: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Expanded(
                        child: SizedBox(
                      child: ListView.builder(
                        itemCount: cards.isEmpty ? 0 : cards.length,
                        itemBuilder: (_, index) =>
                            Text(cards[index].text.split(":")[0]),
                      ),
                    )),
                    ElevatedButton(
                        onPressed: () {
                          createNewStack();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AddCardToStackDialog(stack: stack),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          "Add card",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: ElevatedButton(
            onPressed: () {
              createNewStack();
              context
                  .read<CRUDStackBloc>()
                  .add(CRUDStackUpdateStackEvent(stack));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              "Save",
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
      );
    });
  }
}
