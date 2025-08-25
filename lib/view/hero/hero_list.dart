import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/event_state/hero_es.dart';
import '../../bloc/hero_bloc.dart';
import '../../bloc/providers/provider_bloc.dart';
import '../../database/cards_stack.dart';
import 'change_stack.dart';

class HeroListPage extends StatefulWidget {
  const HeroListPage({super.key});

  @override
  State<StatefulWidget> createState() => _HeroListPageState();
}

class _HeroListPageState extends State<HeroListPage> {
  //int eCCAdded = 0;
  var id = 0;
  var name = "";
  var isFriend = false;
  var energyClosetCount = 0;
    var heroStack = const CardsStack.empty();
      var description = "";
      var feature = "";
      var ability = "";

      @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeroBloc, HeroState>(builder: (context, state) {
      //List<HeroStack> heroes = [];
      HeroStack hero = const HeroStack.empty();
      var index = 0;
      //var id = 0;

      if (state is HeroSuccessState) {
        index = state.index;
        hero = state.heroStack;
        if(hero.id != id) {
          id = hero.id;
          name = hero.name;
          isFriend = hero.isFriend;
          energyClosetCount = hero.energyClosetCount;
          heroStack = hero.heroStack; //.name;
          description = hero.description;
          feature = hero.feature;
          ability = hero.ability;
        } else {
          heroStack = hero.heroStack;
          print("HeroListPage: state is HeroSuccessState. hero.id == id");
        }
      } else {
        print("HeroListPage: Error in HeroBloc state: $state");
        //ability = "Hero state error";
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Hero List'),
              ElevatedButton(
                onPressed: () {
                  context.read<ProviderBloc>().add(RootEvent());
                },
                child: const Icon(Icons.home, size: 30),
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 730,
              child: Column(
                children: [
                  // Previous next buttons
                  Row(
                    spacing: 20,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if(index > 0) {
                            context.read<HeroBloc>().add(HeroNextPrevEvent(--index));
                          }
                          // print(
                          //     "HeroListPage: Previous button pressed for hero ${heroes[index].name}");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              index > 0 ? Colors.blue : Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("Previous"),
                      ),
                      const Expanded(child: SizedBox()),
                      ElevatedButton(
                        onPressed: () {
                          context.read<HeroBloc>().add(HeroNextPrevEvent(++index));
                          // if (index < heroes.length) {
                          //   changeHero(index + 1);
                          // }
                          // print(
                          //     "HeroListPage: Next button pressed for hero ${heroes[index].name}");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              //index < heroes.length ? Colors.blue : Colors.grey,
                              Colors.blue,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                  // Hero name
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const Text(
                          "Hero name: ",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 1,
                          onChanged: (value) {
                            //setState(() {
                              name = value;
                            //});
                            // print(
                            //     "Hero name changed to $value for hero ${heroes[index].name}");
                          },
                          controller: TextEditingController(text: name),
                        ),
                      ),
                    ],
                  ),
                  // Is Friend?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Is Friend: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                          splashRadius: 18,
                          value: isFriend,
                          //stacks[index].isActive,
                          onChanged: (value) {
                            setState(() {
                              isFriend = value!;
                            });
                            
                            print("HeroListPage: Checkbox changed to $value. isFriend $isFriend");
                            // print(
                            //     "Checkbox changed to $value for hero ${heroes[index].name}");
                            // setState(() {
                            //   heroes[index].isFriend = value!;
                            // });
                          }),
                    ],
                  ),
                  // Hero Stack
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hero stack: ",
                          style: TextStyle(fontSize: 16)),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          //heroStack.name,
                          heroStack.id > 0 ? heroStack.name : "No stack",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            var newHero = HeroStack(
                              id: id,
                              name: name,
                              isFriend: isFriend,
                              heroStack: heroStack,
                              energyClosetCount: energyClosetCount,
                              ability: ability,
                              feature: feature,
                              description: description);
                            showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ChangeStackDialog(newHero); //TopCardDialog(id: stack.cards.last.id , list: stack.cards);
                                  },
                                );
                            // print(
                            //     "Hero stack button pressed for hero ${heroes[index].name}");
                          },
                          child: const Icon(Icons.edit))
                    ],
                  ),
                  // Energy Closet Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Energy closet count: ",
                          style: TextStyle(fontSize: 16)),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            energyClosetCount--;
                            //eCCAdded--;
                          });
                        },
                        style: TextButton.styleFrom(
                          iconColor: Colors.black,
                          backgroundColor: Colors.blue,
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.remove_outlined,
                          size: 16,
                        ),
                      ),
                      Text(
                          "$energyClosetCount"),
                          //"${energyClosetCount + eCCAdded}"),
                      TextButton(
                          onPressed: () {
                            setState(() {
                               //eCCAdded++;
                              energyClosetCount++;
                            });
                            print("HeroListPage: Add energy closet count $energyClosetCount");
                          },
                          style: TextButton.styleFrom(
                            iconColor: Colors.black,
                            backgroundColor: Colors.blue,
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 16,
                          )),
                    ],
                  ),
                  // Ability
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const Text(
                          "Ability: ",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 5,
                          onChanged: (value) {
                            //setState(() {
                              ability = value;
                            //});
                            // print(
                            //     "Ability changed to $value for hero ${heroes[index].name}");
                          },
                          controller: TextEditingController(text: ability),
                        ),
                      ),
                    ],
                  ),
                  // Feature
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const Text(
                          "Feature: ",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                          onChanged: (value) {
                            //setState(() {
                              feature = value;
                            //});
                            // print(
                            //     "Feature changed to $value for hero ${heroes[index].name}");
                          },
                          controller: TextEditingController(text: feature),
                        ),
                      ),
                    ],
                  ),
                  // Description
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Description: ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 4,
                            onChanged: (value) {
                              //setState(() {
                                description = value;
                              //});
                              // print(
                              //     "Description changed to $value for hero ${heroes[index].name}");
                            },
                            controller:
                                TextEditingController(text: description),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Buttons
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      spacing: 30,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            var newData = HeroStack(
                              id: id,
                              name: name,
                              isFriend: isFriend,
                              heroStack: heroStack,
                              energyClosetCount: energyClosetCount,
                              ability: ability,
                              feature: feature,
                              description: description,
                            );
                            context.read<HeroBloc>().add(HeroSaveEvent(newData));
                            // print(
                            //     "HeroListPage: Save button pressed for hero ${heroes[index].name}");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text("Save"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<HeroBloc>().add(HeroDeleteEvent(id));
                            // print(
                            //     "HeroListPage: Delete button pressed for hero ${heroes[index].name}");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            print("HeroListPage: Create Hero button pressed");
            context.read<HeroBloc>().add(HeroCreateEvent());
          },
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
          label: const Text("Create Hero"),
        ),
      );
    });
  }
}
