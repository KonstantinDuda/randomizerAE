import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/crud_stack_bloc.dart';
import '../../../bloc/event_state/crud_stack_es.dart';
import '../../../bloc/event_state/history_es.dart';
import '../../../bloc/event_state/turn_order_body_es.dart';
import '../../../bloc/providers/provider_bloc.dart';
import '../../../bloc/history_bloc.dart';
import '../../../bloc/turn_order_body_bloc.dart';
import '../../../database/cards_stack.dart';
import '../dialogs/dialog_about_stack.dart';
import '../dialogs/dialog_ch_seq.dart';
import '../dialogs/dialog_shuffle_put.dart';
import '../dialogs/dialog_top_card.dart';
import '../dialogs/dialog_link.dart';
import 'my_card.dart';

class TurnOrderBody extends StatefulWidget {
  const TurnOrderBody({super.key});

  @override
  State<TurnOrderBody> createState() => _TurnOrderBodyState();
}

class _TurnOrderBodyState extends State<TurnOrderBody>
    with SingleTickerProviderStateMixin {
  ScrollController myController = ScrollController();

  late AnimationController? _lastPlayedController;
  late Animation<double>? _lastPlayedOpacity;

  @override
  void initState() {
    super.initState();
    _lastPlayedController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _lastPlayedOpacity = Tween<double>(begin: 0.1, end: 10).animate(
        CurvedAnimation(parent: _lastPlayedController!, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _lastPlayedController?.dispose();
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //const Size mainObjSize = Size(130, 220);

    return BlocBuilder<TurnOrderBodyBloc, TurnOrderBodyState>(
        builder: (context, state) {
      late CardsStack stack;
      late CardsStack alreadyPlayed;
      late List<CardsStack> allStacks;
      late Map<String, int> links;
      List<String> lokalLinks = [];

      var clickCounter = 0;

      if (state is TurnOrderBodySuccessActionState) {
        stack = state.stack;
        alreadyPlayed = state.alreadyPlayed;
        allStacks = state.allStacks;
        links = state.links;
        for (var entry in links.entries) {
          if (entry.key != "Friend" && entry.key != "Foe") {
            lokalLinks.add(entry.key);
          }
        }
        //print("TurnOrderBody: links == $links");
      } else {
        stack = const CardsStack.empty();
        alreadyPlayed = const CardsStack.empty();
        if (mounted) {
          setState(() {});
        }
      }

      return Expanded(
        child: LayoutBuilder(
          builder: ((context, constraints) {
            double lbWidth = constraints.maxWidth;
            double lbHeight = constraints.maxHeight;

            Size mainObjSize = const Size(120, 200);

            return Container(
              color: Colors.blue,
              //height: bodyContainerSize.height,
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                children: <Widget>[
                  ColoredBox(
                    color: Colors.blue,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text(
                              stack.name,
                              style: const TextStyle(fontSize: 30),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          height: 28,
                          width: 80,
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          //alignment: Alignment.topRight,
                          decoration: BoxDecoration(
                            color: stack.stackColor, //stackColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Align(
                            //alignment: Alignment.topCenter,
                            child: Text(
                              'stack color',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                height: -0.7,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      //child: Container(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(2, 0, 2, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              //
                              // Last played Card
                              //
                              FadeTransition(
                                opacity: _lastPlayedOpacity ??
                                    const AlwaysStoppedAnimation(1.0),
                                key: ValueKey(clickCounter),
                                child: GestureDetector(
                                  child: MyCard(
                                    alreadyPlayed.cards.isNotEmpty
                                        ? alreadyPlayed.cards.first
                                        : AECard(id: 0, name: "", text: ""),
                                    Size(lbWidth / 2.2, lbHeight / 2.5),
                                    bodyColor: Colors.white,
                                    borderColor: Colors.black,
                                    borderWidth: 2,
                                    margin: EdgeInsets.fromLTRB(
                                        2, 0, 2, lbHeight / 5),
                                  ),
                                  onTap: () {
                                    print("Last played card tapped");
                                    if (alreadyPlayed.cards.isNotEmpty &&
                                        links.keys.contains(
                                            alreadyPlayed.cards.first.name)) {
                                      context.read<TurnOrderBodyBloc>().add(
                                          TurnOrderBodyChangeActiveStackEvent(
                                              links[alreadyPlayed
                                                  .cards.first.name]!));
                                    }
                                  },
                                  onLongPress: () {
                                    if (alreadyPlayed.cards.isNotEmpty) {
                                      _dialogShuffleLink(
                                          stack.id,
                                          alreadyPlayed.cards.first /*.name*/,
                                          allStacks);
                                    }
                                  },
                                ),
                              ),
                              //
                              // Divider
                              //
                              Container(
                                margin: EdgeInsets.only(
                                    top: 20, bottom: lbHeight / 3.5),
                                width: 1.5,
                                color: Colors.black,
                              ),
                              //
                              // Already played List
                              //
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(2, 10, 2, 200),
                                  child: ListView.builder(
                                    controller: myController,
                                    itemCount: alreadyPlayed.cards.isNotEmpty
                                        ? alreadyPlayed.cards.length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      var text =
                                          alreadyPlayed.cards[index].name;
                                      return GestureDetector(
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 0, 2, 5),
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(text,
                                                  style: const TextStyle(
                                                      fontSize: 20))),
                                        ),
                                        onTap: () {
                                          print(
                                              "Already played card tapped: ${alreadyPlayed.cards[index].name}");
                                          if (links.keys.contains(text)) {
                                            context.read<TurnOrderBodyBloc>().add(
                                                TurnOrderBodyChangeActiveStackEvent(
                                                    links[text]!));
                                          }
                                        },
                                        onLongPress: () {
                                          print(
                                              "Already played card long pressed: ${alreadyPlayed.cards[index].name}");
                                          _dialogShuffleLink(
                                              stack.id,
                                              alreadyPlayed
                                                  .cards[index] /*.name*/,
                                              allStacks);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                            //);
                            // }),
                          ),
                        ),

                        //
                        // Fast Links
                        Positioned(
                          bottom: 2,
                          left: 2,
                          // child: Expanded(
                          child: Container(
                            height: lbHeight / 3,
                            color: const Color.fromARGB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                // Button List
                                Expanded(
                                  child: SizedBox(
                                    width: lbWidth / 3,
                                    //color: Colors.amber,
                                    child: ListView.builder(
                                        itemCount: lokalLinks.isNotEmpty
                                            ? lokalLinks.length
                                            : 0,
                                        itemBuilder: ((context, index) {
                                          return GestureDetector(
                                            child: Container(
                                              margin: const EdgeInsets.all(2),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                lokalLinks[index],
                                                style: const TextStyle(
                                                    fontSize: 18),
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                            onTap: () {
                                              if (links.keys.contains(
                                                  lokalLinks[index])) {
                                                context
                                                    .read<TurnOrderBodyBloc>()
                                                    .add(
                                                        TurnOrderBodyChangeActiveStackEvent(
                                                            links[lokalLinks[
                                                                index]]!));
                                              }
                                            },
                                          );
                                        })),
                                  ),
                                ),
                                //
                                // Add button to Button List
                                GestureDetector(
                                  child: Container(
                                    width: lbWidth / 3 + 4,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(18)),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "+",
                                        style: TextStyle(fontSize: 30),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    print("Add button to List onTap");
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return LinkDialog(
                                          list: allStacks
                                              .map((e) => e.name)
                                              .toList(),
                                          name: stack.name,
                                          discard: false,
                                          stackId: stack.id,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Main object
                        Positioned(
                          bottom: -15,
                          left: lbWidth / 3 + 8,
                          child: GestureDetector(
                            child: Container(
                              width: mainObjSize.width,
                              height: mainObjSize.height,
                              decoration: BoxDecoration(
                                color: stack.stackColor,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(18)),
                              ),
                              margin: const EdgeInsets.all(0),
                              child: Center(
                                child: Text(
                                  stack.cards.isEmpty ? "X" : stack.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: stack.stackColor == Colors.black
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (stack.cards.isEmpty) {
                                context
                                    .read<TurnOrderBodyBloc>()
                                    .add(TurnOrderBodyShuffleEvent(stack.id));
                              } else {
                                context
                                    .read<TurnOrderBodyBloc>()
                                    .add(TurnOrderBodyNextEvent(stack.id));
                              }
                              _lastPlayedController?.forward(from: 0);
                            },
                            onLongPress: () {
                              if (stack.cards.isNotEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return TopCardDialog(
                                        cardId: stack.cards.last.id,
                                        list: stack.cards,
                                        stackId: stack.id);
                                  },
                                );
                              }
                            },
                          ),
                        ),

                        // Discard (a) card(s)
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: GestureDetector(
                            child: Container(
                              width: lbWidth / 3 + 4,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(top: 2),
                                child: const Center(
                                  child: Text(
                                    "Discard (a) card(s)",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LinkDialog(
                                    list:
                                        stack.cards.map((e) => e.name).toList(),
                                    name: stack.name,
                                    discard: true,
                                    stackId: stack.id,
                                  );
                                },
                              );
                              //print("Discard a card tapped");
                            },
                          ),
                        ),

                        // Watch story
                        Positioned(
                          bottom: 54,
                          right: 2,
                          child: GestureDetector(
                            child: Container(
                              width: lbWidth / 3 + 4,
                              height: 50,
                              //margin: const EdgeInsets.only(bottom: 80),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(left: 10, top: 2),
                                child: const Center(
                                  child: Text(
                                    "History",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              context
                                  .read<HistoryBloc>()
                                  .add(HistoryGetEvent(stack.id));
                              context
                                  .read<ProviderBloc>()
                                  .add(HistoryProviderEvent());
                              print("History tapped");
                            },
                          ),
                        ),

                        // Change sequance
                        Positioned(
                          bottom: 106,
                          right: 2,
                          child: GestureDetector(
                            child: Container(
                              width: lbWidth / 3 + 4,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(18)),
                              ),
                              child: const Center(
                                child: Text(
                                  "Change sequance",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            onTap: () {
                              print("Change sequance tapped");
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ChangeSequanceDialog(
                                      stackId: stack.id, list: stack.cards);
                                },
                              );
                            },
                          ),
                        ),

                        // About Stack
                        Positioned(
                          bottom: 158,
                          right: 2,
                          child: GestureDetector(
                            child: Container(
                              width: lbWidth / 3 + 4,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(18)),
                              ),
                              child: const Center(
                                child: Text(
                                  "About Stack",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            onTap: () {
                              print("About Stack was tapped");
                              if (stack.id > 0) {
                                var stackCards = stack.cards;
                                stackCards.addAll(alreadyPlayed.cards);
                                stackCards
                                    .sort(((a, b) => a.id.compareTo(b.id)));
                                _dialogAboutStack(
                                    stack.copyWith(cards: stackCards), context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }

  _dialogAboutStack(CardsStack stack, BuildContext context) async {
    String collback = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAboutStack(stack);
      },
    );
    if (collback == "edit" && mounted) {
      context.read<CRUDStackBloc>().add(CRUDDataFromDBEvent());
      context.read<ProviderBloc>().add(UpdateDeleteEvent());
    }
  }

  _dialogShuffleLink(int stackId, AECard card, List<CardsStack> stacks) async {
    String collback = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShufflePutBackDialog(stackId, card);
      },
    );
    if (!mounted) return;
    print("ShuffleLink dialog return $collback");
    if (collback == "link") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return LinkDialog(
            list: stacks.map((e) => e.name).toList(),
            name: card.name,
            discard: false,
            stackId: stackId,
          );
        },
      );
    }
  }
}
