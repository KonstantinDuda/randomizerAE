import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/view/create/stack_widget.dart';
import 'package:randomizer_new/view/root/bodyes/my_card.dart';

import '/bloc/providers/provider_bloc.dart';
import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '/database/cards_stack.dart';

class UpdateDeleteStackPage extends StatefulWidget {
  const UpdateDeleteStackPage({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateDeleteStackPageState();
}

class _UpdateDeleteStackPageState extends State<UpdateDeleteStackPage> {
  List<AECard> cards = [];
  List<CardsStack> stacks = [];
  List<HeroStack> heroStacks = [];
  Size screenSize = Size(0, 0);

  /*List<DropdownMenuItem> cardsDMI = [];
  List<DropdownMenuItem> stacksDMI = [];
  List<DropdownMenuItem> heroStacksDMI = [];
  List<String> stackTypes = const [
    "Turn order",
    "Friend / Foe",
    "Gravehold",
    "Hero",
    "Nemesis",
    "Is empty"
  ];
  List<Color> stackColors = const [
    Color.fromARGB(255, 76, 175, 80),
    Color.fromARGB(255, 33, 150, 243),
    Color.fromARGB(255, 244, 67, 54),
    Color.fromARGB(255, 158, 158, 158),
    Color.fromARGB(255, 255, 193, 7),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 255, 255, 255),
  ];*/
  List<String> typesList = [];
  List<Color> colorsList = [];
  var curentColor = const Color.fromARGB(255, 255, 255, 255);

  stackColor(Color color) {
    return Container(
      width: 20,
      height: 20,
      color: color,
    );
  }

  cardWidget(int index) {
    //return Text("Card Item: ${cards[index].text}");
    return Column(
      children: [
        MyCard(
          Center(
            child: Text(
              cards[index].text,
              textAlign: TextAlign.center,
              maxLines: 9,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Size(150, 220),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Update card"),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text("Delete card"),
        ),
      ],
    );
  }

  /*myStack(
    //String stackName,
    Widget stackName,
    String cardNames,
    bool checkbox,
    String curentType,
    Color curentColor,
    Function changeName,
    Function addCard,
    Function checkboxChange,
    Function changeType,
    Function changeColor,
    Function saveStack,
    Function deleteStack,
  ) {
    return MyCard(
      Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          stackName,
          // Center(
          //   child: Text(
          //     "Stack name: $stackName",
          //     maxLines: 1,
          //     overflow: TextOverflow.ellipsis,
          //     style: const TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          Row(
            children: [
              Column(
                children: [
                  const Text(
                    "Cards in stack: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MyCard(
                    Column(
                      children: [
                        Expanded(
                          child: Text(
                            cardNames,
                            maxLines: 10,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            addCard();
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 22,
                          ),
                        )
                      ],
                    ),
                    const Size(100, 270),
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  ),
                ],
              ),
              Container(
                width: screenSize.width - 170,
                height: 270,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Is Active: "),
                            Checkbox(
                                value: checkbox, //stacks[index].isActive,
                                onChanged: (value) {
                                  checkboxChange(value);
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Stack Type: "),
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
                                changeType(value);
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Stack color: "),
                            SizedBox(
                              //width: 60,
                              //height: 25,
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
                                  changeColor(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.only(right: 5),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              saveStack();
                            },
                            child: const Text("Save"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              deleteStack();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text("Delete stack"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      Size(screenSize.width - 50, 320),
    );
  }*/

  stackWidget(int index) {
    String cardNames = "\n";
    curentColor = colorsList[index];
    if (stacks[index].cards.isNotEmpty) {
      for (var element in stacks[index].cards) {
        if (element.text.isNotEmpty) {
          var cardName = element.text.split(":");
          cardNames += "${cardName[0]}, \n";
        }
      }
    }

    var curentName = stacks[index].name;
    var checkboxState = stacks[index].isActive;
    var curentType = typesList[index];

    Widget nameStack = Center(
      child: Text(
        "Stack name: $curentName",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    void changeName() {
      print("ChangeName in $curentName stack");
    }

    void addCard() {
      print("Add card in $curentName stack");
    }

    void checkboxChange(bool value) {
      var newStack = CardsStack(
          id: stacks[index].id,
          name: stacks[index].name,
          isActive: !stacks[index].isActive,
          stackType: stacks[index].stackType,
          stackColor: stacks[index].stackColor,
          cards: stacks[index].cards);
      // context.read<CRUDStackBloc>().add(
      //       CRUDStackUpdateStackEvent(newStack),
      //     );
      setState(() {
        stacks.removeAt(index);
        stacks.insert(index, newStack);
        checkboxState = !checkboxState;
      });
      print(
          "UpdateDeleteStackPage stackWidget checkboxChange $value, ${stacks[index].isActive}");
    }

    changeType(String value) {
      if (value != typesList[index]) {
        print("${stacks[index].name} Stack type changed to $value");
        var newStackType = StackType.turnOrder;
        if (value == "Turn order") {
          newStackType = StackType.turnOrder;
        } else if (value == "Friend / Foe") {
          newStackType = StackType.friendFoe;
        } else if (value == "Gravehold") {
          newStackType = StackType.gravehold;
        } else if (value == "Hero") {
          newStackType = StackType.hero;
        } else if (value == "Nemesis") {
          newStackType = StackType.nemesis;
        } /*else {
          value = "Is empty";
        }*/
        var newStack = CardsStack(
            id: stacks[index].id,
            name: stacks[index].name,
            isActive: stacks[index].isActive,
            stackType: newStackType,
            stackColor: stacks[index].stackColor,
            cards: stacks[index].cards);
        setState(() {
          stacks.removeAt(index);
          stacks.insert(index, newStack);
          typesList[index] = value;
        });
      } else {
        print("${stacks[index].id} Stack type not changed");
      }
    }

    changeColor(Color value) {
      if (value != colorsList[index]) {
        print("${stacks[index].name} Stack color changed to $value");
        //var newStackColor = const Color.fromARGB(255, 158, 158, 158);
        var newStack = CardsStack(
            id: stacks[index].id,
            name: stacks[index].name,
            isActive: stacks[index].isActive,
            stackType: stacks[index].stackType,
            stackColor: value,
            cards: stacks[index].cards);
        setState(() {
          stacks.removeAt(index);
          stacks.insert(index, newStack);
          colorsList[index] = value;
        });
      } else {
        print("${stacks[index].id} Stack color not changed");
      }
    }

    saveStack() {
      print("Save $curentName stack");
      context.read<CRUDStackBloc>().add(CRUDStackUpdateStackEvent(stacks[index]));
    }

    deleteStack() {
      print("Delete $curentName stack");
      context.read<CRUDStackBloc>().add(CRUDStackDeleteStackEvent(index));
    }

    return StackWidget( //myStack(
      //curentName,
      nameStack,
      cardNames,
      checkboxState,
      curentType,
      curentColor,
      changeName,
      addCard,
      checkboxChange,
      changeType,
      changeColor,
      saveStack,
      deleteStack,
    );

    // return MyCard(
    //   Column(
    //     //mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Center(
    //         child: Text(
    //           "Stack name: ${stacks[index].name}",
    //           maxLines: 1,
    //           overflow: TextOverflow.ellipsis,
    //           style: const TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //       Row(
    //         children: [
    //           Column(
    //             children: [
    //               const Text(
    //                 "Cards in stack: ",
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               MyCard(
    //                 Column(
    //                   children: [
    //                     Expanded(
    //                       child: Text(
    //                         cardNames,
    //                         maxLines: 10,
    //                         textAlign: TextAlign.center,
    //                       ),
    //                     ),
    //                     ElevatedButton(
    //                       onPressed: () {
    //                         print("UpdateDeleteStackPage add card to stack");
    //                       },
    //                       child: const Icon(
    //                         Icons.add,
    //                         color: Colors.green,
    //                         size: 22,
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //                 const Size(100, 270),
    //                 margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
    //               ),
    //             ],
    //           ),
    //           Container(
    //             width: screenSize.width - 170,
    //             height: 270,
    //             alignment: Alignment.center,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Column(
    //                   children: [
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const Text("Is Active: "),
    //                         Checkbox(
    //                             value: stacks[index].isActive,
    //                             onChanged: (value) {
    //                               var newStack = CardsStack(
    //                                   id: stacks[index].id,
    //                                   name: stacks[index].name,
    //                                   isActive: !stacks[index].isActive,
    //                                   stackType: stacks[index].stackType,
    //                                   stackColor: stacks[index].stackColor,
    //                                   cards: stacks[index].cards);
    //                               // context.read<CRUDStackBloc>().add(
    //                               //       CRUDStackUpdateStackEvent(newStack),
    //                               //     );

    //                               setState(() {
    //                                 stacks.removeAt(index);
    //                                 stacks.insert(index, newStack);
    //                               });
    //                             }),
    //                       ],
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const Text("Stack Type: "),
    //                         DropdownButton<String>(
    //                           iconSize: 35,
    //                           value: typesList[index],
    //                           items: stackTypes.map((String type) {
    //                             return DropdownMenuItem<String>(
    //                               value: type,
    //                               child: Text(type),
    //                             );
    //                           }).toList(),
    //                           onChanged: (value) {
    //                             if (value != typesList[index]) {
    //                               print(
    //                                   "${stacks[index].name} Stack type changed to $value");
    //                               var newStackType = StackType.turnOrder;
    //                               if (value == "Turn order") {
    //                                 newStackType = StackType.turnOrder;
    //                               } else if (value == "Friend / Foe") {
    //                                 newStackType = StackType.friendFoe;
    //                               } else if (value == "Gravehold") {
    //                                 newStackType = StackType.gravehold;
    //                               } else if (value == "Hero") {
    //                                 newStackType = StackType.hero;
    //                               } else if (value == "Nemesis") {
    //                                 newStackType = StackType.nemesis;
    //                               } else {
    //                                 value = "Is empty";
    //                               }
    //                               var newStack = CardsStack(
    //                                   id: stacks[index].id,
    //                                   name: stacks[index].name,
    //                                   isActive: stacks[index].isActive,
    //                                   stackType: newStackType,
    //                                   stackColor: stacks[index].stackColor,
    //                                   cards: stacks[index].cards);
    //                               setState(() {
    //                                 stacks.removeAt(index);
    //                                 stacks.insert(index, newStack);
    //                                 typesList[index] = value!;
    //                               });
    //                             } else {
    //                               print(
    //                                   "${stacks[index].id} Stack type not changed");
    //                             }
    //                           },
    //                         ),
    //                       ],
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const Text("Stack color: "),
    //                         SizedBox(
    //                           //width: 60,
    //                           //height: 25,
    //                           child: DropdownButton<Color>(
    //                             iconSize: 35,
    //                             value: curentColor, //colorsList[index],
    //                             items: stackColors.map((Color type) {
    //                               return DropdownMenuItem<Color>(
    //                                 value: type, //type,
    //                                 child: Container(
    //                                     width: 60,
    //                                     height: 25,
    //                                     decoration: BoxDecoration(
    //                                       color: type,
    //                                       border: Border.all(
    //                                         color: Colors.black,
    //                                         width: 2,
    //                                       ),
    //                                     )),
    //                               );
    //                             }).toList(),
    //                             onChanged: (value) {
    //                               if (value != colorsList[index]) {
    //                                 print(
    //                                     "${stacks[index].name} Stack color changed to $value");
    //                                 //var newStackColor = const Color.fromARGB(255, 158, 158, 158);
    //                                 var newStack = CardsStack(
    //                                     id: stacks[index].id,
    //                                     name: stacks[index].name,
    //                                     isActive: stacks[index].isActive,
    //                                     stackType: stacks[index].stackType,
    //                                     stackColor: value!,
    //                                     cards: stacks[index].cards);
    //                                 setState(() {
    //                                   stacks.removeAt(index);
    //                                   stacks.insert(index, newStack);
    //                                   colorsList[index] = value;
    //                                 });
    //                               } else {
    //                                 print(
    //                                     "${stacks[index].id} Stack color not changed");
    //                               }
    //                             },
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 const Expanded(child: SizedBox()),
    //                 Container(
    //                   alignment: Alignment.bottomRight,
    //                   margin: const EdgeInsets.only(right: 5),
    //                   child: Column(
    //                     children: [
    //                       ElevatedButton(
    //                         onPressed: () {
    //                           print("UpdateDeleteStackPage save stack updates");
    //                           context.read<CRUDStackBloc>().add(
    //                                 CRUDStackUpdateStackEvent(stacks[index]),
    //                               );
    //                         },
    //                         child: const Text("Save"),
    //                       ),
    //                       ElevatedButton(
    //                         onPressed: () {},
    //                         style: ElevatedButton.styleFrom(
    //                           backgroundColor: Colors.red,
    //                         ),
    //                         child: const Text("Delete stack"),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    //   Size(screenSize.width - 50, 320),
    // );
  }

  box(String text, String buttonText, SizedBox sizedBox) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(margin: const EdgeInsets.fromLTRB(10, 0, 0, 0), child: Text(text, style: const TextStyle(fontSize: 20))),
                ElevatedButton(
                  onPressed: () {
                    // Add your stack creation logic here
                  },
                  child: Text(buttonText, style: const TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
          sizedBox,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CRUDStackBloc, CRUDStackState>(
        builder: (context, state) {
      if (state is CRUDStackSuccessActionState) {
        cards = state.cards;
        stacks = state.stacks;
        screenSize = MediaQuery.of(context).size;
        typesList.clear();
        colorsList.clear();
        for (var element in stacks) {
          //print("UpdateDeleteStackPage build element.name == ${element.name} element.stackType == ${element.stackType}");
          var stackType = "";
          if (element.stackType == StackType.turnOrder) {
            stackType = "Turn order";
          } else if (element.stackType == StackType.friendFoe) {
            stackType = "Friend / Foe";
          } else if (element.stackType == StackType.gravehold) {
            stackType = "Gravehold";
          } else if (element.stackType == StackType.hero) {
            stackType = "Hero";
          } else if (element.stackType == StackType.nemesis) {
            stackType = "Nemesis";
          } /*else {
            stackType = "Is empty";
          }*/
          if (stackType != "" && stacks.length > typesList.length) {
            typesList.add(stackType);
            colorsList.add(element.stackColor);
          }
        }
        print("UpdateDeleteStackPage build typesList == $typesList");
        print("UpdateDeleteStackPage build colorsList == ${colorsList.length}");
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
              const Text('Create / Update Stack'),
              ElevatedButton(
                onPressed: () {
                  context.read<ProviderBloc>().add(RootEvent());
                },
                child: const Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
        // body: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        body: ListView(
          children: <Widget>[
            // Cards
            box(
              'Cards: ',
              'Create card',
              SizedBox(
                height: 330,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: cards.isEmpty ? 0 : cards.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => cardWidget(index),
                ),
              ),
            ),

            // Stacks
            box(
              'Stacks: ',
              'Create stack',
              SizedBox(
                height: 330,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: stacks.isEmpty ? 0 : stacks.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) =>
                      stackWidget(index), // StackWidgetPage(index),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
