import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/event_state/hero_es.dart';
import '../../bloc/hero_bloc.dart';
import '../../bloc/providers/provider_bloc.dart';
import '../../database/cards_stack.dart';

class HeroListPage extends StatefulWidget {
  const HeroListPage({super.key});

  @override
  State<StatefulWidget> createState() => _HeroListPageState();
}

class _HeroListPageState extends State<HeroListPage> {
   List<HeroStack> heroes = [];
    var index = 1;
    var id = 0;
    var name = "";
    var isFriend = false;
    var heroStack = const CardsStack.empty();
    var description = "";
    var feature = "";
    var ability = "";
    var energyClosetCount = 0;

  @override
  Widget build(BuildContext context) {
   
    return BlocBuilder<HeroBloc, HeroState>(builder: (context, state) {
      if (state is HeroSuccessState) {
        //ability = "Heroes length: ${state.heroStacks.length}";
         heroes = state.heroStacks;
         if(heroes.isNotEmpty) {
           index = 0; // Reset index to 0 for the first hero
             id = heroes[index].id;
           name = heroes[index].name;
           isFriend = heroes[index].isFriend;
           heroStack = heroes[index].heroStack;
           description = heroes[index].description;
           feature = heroes[index].feature;
           ability = heroes[index].ability;
           energyClosetCount = heroes[index].energyClosetCount;

         } else {
           ability = "No heroes available";
         }
      } else {
        ability = "Hero state error";
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
        body:
          ListView(
            children: [
        //    child: SingleChildScrollView(
        //         child: 
              SizedBox(
            height: 730,
            child:
              Column(
                children: [
                  // Previous? next buttons
                  Row(
                    spacing: 20,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // print(
                          //     "HeroListPage: Previous button pressed for hero ${heroes[index].name}");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: index > 0 ? Colors.blue : Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("Previous"),
                      ),
                      const Expanded(child: SizedBox()),
                      ElevatedButton(
                        onPressed: () {
                          // print(
                          //     "HeroListPage: Next button pressed for hero ${heroes[index].name}");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              index < heroes.length ? Colors.blue : Colors.grey,
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
                            // print(
                            //     "Hero name changed to $value for hero ${heroes[index].name}");
                          },
                          controller:
                              TextEditingController(text: name),
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
                      const Text("Hero stack: ", style: TextStyle(fontSize: 16)),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          heroStack.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
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
                        onPressed: () {},
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
                      Text("$energyClosetCount"),//("${heroes[index].energyClosetCount}"),
                      TextButton(
                          onPressed: () {},
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
                            // print(
                            //     "Ability changed to $value for hero ${heroes[index].name}");
                          },
                          controller:
                              TextEditingController(text: ability),
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
                            // print(
                            //     "Feature changed to $value for hero ${heroes[index].name}");
                          },
                          controller:
                              TextEditingController(text: feature),
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
                              // print(
                              //     "Description changed to $value for hero ${heroes[index].name}");
                            },
                            controller: TextEditingController(
                                text: description),
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
            ],),
            // );
          //          ),
          //  ),
         //),

        //   },
        //  ),
        // body: Center(
        //   child: Text(text),
        // ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            print("HeroListPage: Create Hero button pressed");
            //context.read<ProviderBloc>().add(HeroCreateEvent());
          },
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
          label: const Text("Create Hero"),
        ),
      );
    });
  }
}
