import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../database/cards_stack.dart';
import '../root/description.dart';
import 'dialog_add_card.dart';
import 'dialog_delete.dart';
import 'dialog_description.dart';

class StackWidget extends StatefulWidget {
  final CardsStack stack;
  const StackWidget(this.stack, {super.key});

  @override
  State<StatefulWidget> createState() => _StackWidgetState();
}

class _StackWidgetState extends State<StackWidget> {
//  List<CardsStack> stacks = [];
  CardsStack changedStack = const CardsStack.empty();
  List<String> stackTypes = const ["Turn order", "Friend", "Foe", "Other"];
  String stringType = "";
  List<Color> stackColors = const [
    Color.fromARGB(255, 76, 175, 80),
    Color.fromARGB(255, 33, 150, 243),
    Color.fromARGB(255, 244, 67, 54),
    Color.fromARGB(255, 158, 158, 158),
    Color.fromARGB(255, 255, 193, 7),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 255, 255, 255),
  ];
  String cardNames = "\n";
  String descriptionHtml = "";

  @override
  void initState() {
    super.initState();

    changedStack = widget.stack;

    if (changedStack.cards.isNotEmpty) {
      for (var i = 0; i < changedStack.cards.length; i++) {
        cardNames = "$cardNames ${changedStack.cards[i]} \n";
      }
    }

    if (changedStack.stackType == StackType.turnOrder) {
      stringType = "Turn order";
    } else if (changedStack.stackType == StackType.friend) {
      stringType = "Friend";
    } else if (changedStack.stackType == StackType.foe) {
      stringType = "Foe";
    } else {
      stringType = "Other";
    }

    descriptionHtml = widget.stack.description;
  }

  changeType(String value) {
    if (value != stringType) {
      print("StackWidget: ${changedStack.name} Stack type changed to $value");
      var newStackType = StackType.turnOrder;
      if (value == "Turn order") {
        newStackType = StackType.turnOrder;
      } else if (value == "Friend") {
        newStackType = StackType.friend;
      } else if (value == "Foe") {
        newStackType = StackType.foe;
      } else if (value == "Other") {
        newStackType = StackType.other;
      }
      if (mounted) {
        setState(() {
          changedStack = changedStack.copyWith(stackType: newStackType);
        });
      }
    } else {
      print("StackWidget: ${changedStack.name} Stack type not changed");
    }
  }

  changeColor(Color value) {
    if (value != changedStack.stackColor) {
      print("StackWidget: "
          "${changedStack.name} Stack color changed to ${value.toARGB32()}");
      if (mounted) {
        setState(() {
          changedStack = changedStack.copyWith(stackColor: value);
        });
      }
    } else {
      print("StackWidget: Stack color not changed");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = Size(
        350, MediaQuery.of(context).size.height); //MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 525, // screenSize.height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(5),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //changedStackName,
          Center(
            child: Text(
              "Stack name: ${changedStack.name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              // Cards in Stack part
              Column(
                children: [
                  const Text(
                    "Cards in stack: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 130,
                    height: screenSize.height / 3.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Text(
                            //widget.cardNames,
                            cardNames,
                            maxLines: 10,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    AddCardToStackDialog(stack: changedStack));
                            //widget.addCard();
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.green,
                            size: 22,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: screenSize.width - 200,
                  height: 270,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          // Is Active boolean
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Is Active: "),
                              Checkbox(
                                  value:
                                      // widget.checkbox,
                                      changedStack.isActive,
                                  onChanged: (value) {
                                    //widget.checkboxChange(value);
                                    print(
                                        "StackWidget: IsActive change to $value");
                                    var newIsActive = value;
                                    setState(() {
                                      changedStack = changedStack.copyWith(
                                          isActive: newIsActive);
                                    });
                                  }),
                            ],
                          ),
                          // StackType
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Stack Type: "),
                              DropdownButton<String>(
                                iconSize: 35,
                                value: stringType, //widget.curentType,
                                items: stackTypes.map((String type) {
                                  return DropdownMenuItem<String>(
                                    alignment: AlignmentDirectional.center,
                                    value: type,
                                    child: Text(type),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  changeType(value!);
                                  //widget.changeType(value);
                                },
                              ),
                            ],
                          ),
                          // Stack color
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Stack color: "),
                              SizedBox(
                                //width: 60,
                                //height: 25,
                                child: Builder(builder: (context) {
                                  Color? matchedColor;
                                  for (final c in stackColors) {
                                    if (c.toARGB32() ==
                                        changedStack.stackColor.toARGB32()) {
                                      //widget.curentColor.toARGB32()) {
                                      matchedColor = c;
                                      break;
                                    }
                                  }
                                  return DropdownButton<Color>(
                                    iconSize: 35,
                                    value: matchedColor, // widget.curentColor,
                                    hint: const Text("Select color"),
                                    items: stackColors.map((Color type) {
                                      return DropdownMenuItem<Color>(
                                        alignment: AlignmentDirectional.center,
                                        value: type,
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
                                    onChanged: (Color? value) {
                                      if (value != null) {
                                        changeColor(value);
                                        //widget.changeColor(value);
                                      }
                                    },
                                  );
                                }),
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
                                context.read<CRUDStackBloc>().add(
                                    CRUDStackUpdateStackEvent(changedStack));
                                //widget.saveStack();
                              },
                              child: const Text("Save"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print("Delete ${changedStack.name} stack");
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DeleteDialog(changedStack.name, false,
                                            true, changedStack.id));
                                //widget.deleteStack();
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
              ),
            ],
          ),
          const Center(
              child: Text(
            "Description:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          Expanded(
            child: Container(
              color: Colors.amber,
              margin: const EdgeInsets.fromLTRB(3, 2, 3, 2),
              child: Stack(
                children: [
                  Description(descriptionHtml),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    DescriptionDialog(stack: changedStack))
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              descriptionHtml = value;
                              changedStack = changedStack.copyWith(
                                  description: descriptionHtml);
                            });
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
