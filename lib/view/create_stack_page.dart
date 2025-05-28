import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/view/root/bodyes/my_card.dart';

import '/bloc/providers/provider_bloc.dart';
import '/bloc/create_stack_bloc.dart';
import '/bloc/event_state/create_stack_es.dart';
import '/database/cards_stack.dart';

class CreateStackPage extends StatefulWidget {
  const CreateStackPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateStackPageState();
}

class _CreateStackPageState extends State<CreateStackPage> {
  List<AECard> cards = [];
  List<CardsStack> stacks = [];
  List<HeroStack> heroStacks = [];
  Size screenSize = Size(0, 0);

  List<DropdownMenuItem> cardsDMI = [];
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
  List<String> typesList = [];
  List<Color> stackColors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.grey,
    Colors.amberAccent,
    Colors.black,
    Colors.white
  ];

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

  stackWidget(int index) {
    String cardNames = "\n";
    if (stacks[index].cards.isNotEmpty) {
      for (var element in stacks[index].cards) {
        if (element.text.isNotEmpty) {
          var cardName = element.text.split(":");
          cardNames += "${cardName[0]}, \n";
        }
      }
    }
    return MyCard(
      Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Stack name: ${stacks[index].name}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                    Text(
                      cardNames,
                      maxLines: 11,
                      textAlign: TextAlign.center,
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
                                value: stacks[index].isActive,
                                onChanged: (value) {
                                  var newStack = CardsStack(
                                      id: stacks[index].id,
                                      name: stacks[index].name,
                                      isActive: !stacks[index].isActive,
                                      stackType: stacks[index].stackType,
                                      stackColor: stacks[index].stackColor,
                                      cards: cards);
                                  context.read<CreateStackBloc>().add(
                                        CreateStackUpdateStackEvent(newStack),
                                      );
                                  setState(() {
                                    // stacks[index].isActive = !stacks[index].isActive;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Stack Type: "),
                            DropdownButton<String>(
                              value: typesList[index], 
                              items: stackTypes.map((String type) {
                                print("CreateStackPage stackWidget DropdownButton type == $type");
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: (value) {
                                print("CreateStackPage stackWidget DropdownButton onChange value == $value, index == $index");
                                if (value != typesList[index]) {
                                  print(
                                      "${stacks[index].name} Stack type changed to $value");
                                  setState(() { // TODO move changes to BLOC
                                    //stackTypes[index] = value!;
                                    typesList[index] = value!;
                                  });
                                } else {
                                  print(
                                      "${stacks[index].id} Stack type not changed");
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Stack color: "),
                            /*DropdownButton<Color>(
                              value: stackColor,
                              items: const [
                                DropdownMenuItem(
                                  value: Colors.green,
                                  child: Text("Turn order"),
                                ),
                                DropdownMenuItem(
                                  value: Colors.blue,
                                  child: Text("Friend"),
                                ),
                                DropdownMenuItem(
                                  value: Colors.red,
                                  child: Text("Foe"),
                                ),
                                DropdownMenuItem(
                                  value: Colors.grey,
                                  child: Text("Gravehold"),
                                ),
                                DropdownMenuItem(
                                  value: Colors.amberAccent,
                                  child: Text("Hero"),
                                ),
                                DropdownMenuItem(
                                  value: Colors.black,
                                  child: Text("Nemesis"),
                                ),
                                DropdownMenuItem(
                                  value: Colors.white,
                                  child: Text("Is empty"),
                                ),
                              ],
                              onChanged: (value) {
                                print(
                                    "${stacks[index]} Stack color changed to $value");
                              },
                            ),*/
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
                            onPressed: () {},
                            child: const Text("Update stack"),
                          ),
                          ElevatedButton(
                      onPressed: () {},
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

  box(String text, String buttonText, SizedBox sizedBox) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: const TextStyle(fontSize: 20)),
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
    return BlocBuilder<CreateStackBloc, CreateStackState>(
        builder: (context, state) {
      if (state is CreateStackSuccessActionState) {
        cards = state.cards;
        stacks = state.stacks;
        screenSize = MediaQuery.of(context).size;
        typesList.clear();
        for (var element in stacks) {
          //print("CreateStackPage build element.name == ${element.name} element.stackType == ${element.stackType}");
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
          } else {
            stackType = "Is empty";
          }
          if (stackType != "" && stacks.length > typesList.length) {
            typesList.add(stackType);  
          }
          print("CreateStackPage build typesList == $typesList");
        }
      } else {
        print(
            "CreateStackPage build state is not CreateStackSuccessActionState \n");
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
                  itemBuilder: (_, index) => stackWidget(index),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
