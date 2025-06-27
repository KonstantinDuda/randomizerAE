import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/view/create/add_cards_list_view.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../bloc/providers/provider_bloc.dart';
import '../../database/cards_stack.dart';
// import 'dialog_add_card.dart';

class CreateStackPage extends StatefulWidget {
  final int id;
  const CreateStackPage(this.id, {super.key});

  @override
  State<StatefulWidget> createState() => _CreateStackPageState();
}

class _CreateStackPageState extends State<CreateStackPage> {
  List<AECard> allCards = [];
  // List<String> allCardsNames = [];
  List<int> cardCounters = [];
  List<AECard> cards = [];

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
  Color curentColor = const Color.fromARGB(255, 255, 255, 255); //Colors.white;

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
        cards: cards);
    stack = newStack;
    print("CreateStackPage createNewStack stack == $stack");
  }

  addCard(int index) {
    print("CreateStackPage addCard id: $index");
    cards.add(allCards[index]);
    print("CreateStackPage addCard cards: $cards");
  }

  minusCard(int id) {
    print("CreateStackPage minusCard id: $id");
    for (var i = 0; i < cards.length; i++) {
      if(cards.isNotEmpty) {
        if (cards[i].id == id) {
          cards.removeAt(i);
          break;
        }
      }
    }
    print("CreateStackPage minusCard cards: $cards");
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
        allCards = state.cards;
        print("CreateStackPage state is CRUDStackSuccessActionState newStack == $stack allCards.length == ${allCards.length}");
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
            // Stack name
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
            // Is stack active?
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
            // Set stack Type
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
            // Set stack Color
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
            // Cards in stack
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 15, 57) ,
                //width: MediaQuery.of(context).size.width - 80,
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
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                        child: SizedBox(
                          child: AddCardsListView(stack, cards, cardCounters, addCard, minusCard),
                      // child: ListView.builder(
                      //   itemCount: cards.isEmpty ? 0 : cards.length,
                      //   itemBuilder: (_, index) =>
                      //       Text(cards[index].text.split(":")[0]),
                      // ),
                    ),),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       createNewStack();
                    //       showDialog(
                    //         context: context,
                    //         builder: (BuildContext context) =>
                    //             AddCardToStackDialog(stack: stack),
                    //       );
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.green,
                    //     ),
                    //     child: const Text(
                    //       "Add card",
                    //       style: TextStyle(fontSize: 16, color: Colors.black),
                    //     )),
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
              context
                  .read<ProviderBloc>()
                  .add(RootEvent());
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
