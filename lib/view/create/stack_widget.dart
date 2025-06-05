import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../bloc/create_stack_bloc.dart';
// import '../../bloc/event_state/create_stack_es.dart';
// import '../../database/cards_stack.dart';
import '../root/bodyes/my_card.dart';

class StackWidget extends StatefulWidget {
  final Widget stackName;
  final String cardNames;
  final bool checkbox;
  final String curentType;
  final Color curentColor;
  final Function changeName;
  final Function addCard;
  final Function checkboxChange;
  final Function changeType;
  final Function changeColor;
  final Function saveStack;
  final Function deleteStack;
  const StackWidget(
      this.stackName,
      this.cardNames,
      this.checkbox,
      this.curentType,
      this.curentColor,
      this.changeName,
      this.addCard,
      this.checkboxChange,
      this.changeType,
      this.changeColor,
      this.saveStack,
      this.deleteStack,
      {super.key});

  // final int index;
  // const StackWidgetPage(this.index, {super.key});

  @override
  State<StatefulWidget> createState() => _StackWidgetState();
}

class _StackWidgetState extends State<StackWidget> {
//  List<CardsStack> stacks = [];
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return MyCard(
      Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.stackName,
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
                            widget.cardNames,
                            maxLines: 10,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            widget.addCard();
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
                                value:
                                    widget.checkbox, //stacks[index].isActive,
                                onChanged: (value) {
                                  widget.checkboxChange(value);
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Stack Type: "),
                            DropdownButton<String>(
                              iconSize: 35,
                              value: widget.curentType, //typesList[index],
                              items: stackTypes.map((String type) {
                                return DropdownMenuItem<String>(
                                  alignment: AlignmentDirectional.center,
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: (value) {
                                widget.changeType(value);
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
                                value: widget.curentColor, //colorsList[index],
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
                                  widget.changeColor(value);
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
                              widget.saveStack();
                            },
                            child: const Text("Save"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              widget.deleteStack();
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
  }

}
