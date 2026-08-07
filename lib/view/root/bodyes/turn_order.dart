import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_state/history_es.dart';
import '../../../bloc/event_state/turn_order_body_es.dart';
import '../../../bloc/providers/provider_bloc.dart';
import '../../../bloc/history_bloc.dart';
import '../../../bloc/turn_order_body_bloc.dart';
import '../../../database/cards_stack.dart';
import 'dialog_ch_seq.dart';
import 'dialog_top_card.dart';
import 'dialog_link.dart';
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
    const Size mainObjSize = Size(130, 220);

    return BlocBuilder<TurnOrderBodyBloc, TurnOrderBodyState>(
        builder: (context, state) {
      late CardsStack stack;
      late CardsStack alreadyPlayed;

      var clickCounter = 0;

      if (state is TurnOrderBodySuccessActionState) {
        stack = state.stack;
        alreadyPlayed = state.alreadyPlayed;
      } else {
        stack = const CardsStack.empty();
        alreadyPlayed = const CardsStack.empty();
        if (mounted) {
          setState(() {});
        }
      }

      return Expanded(
        child: Container(
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
                      child: LayoutBuilder(
                        builder: ((context, constraints) {
                          double width = constraints.maxWidth;
                          double height = constraints.maxHeight;

                          return Row(
                            children: [
                              // Last played Card
                              FadeTransition(
                                opacity: _lastPlayedOpacity ??
                                    const AlwaysStoppedAnimation(1.0),
                                key: ValueKey(clickCounter),
                                child: GestureDetector(
                                  child: MyCard(
                                      alreadyPlayed.cards.isNotEmpty
                                          ? alreadyPlayed.cards.first
                                          : AECard(id: 0, name: "", text: ""),
                                      Size(width / 2.2, height / 2.5),
                                      bodyColor: Colors.white,
                                      borderColor: Colors.black,
                                      borderWidth: 2,
                                      margin: EdgeInsets.fromLTRB(
                                          2, 0, 2, height / 5)),
                                  // TODO: add Functions to onTap and onLongPress, to this card and cards in the already played list
                                  onTap: () {},
                                  onLongPress: () {},
                                ),
                              ),
                              // Divider. Don't sure I need it
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 240),
                                width: 1.5,
                                color: Colors.black,
                              ),
                              // Already played List
                              Expanded(
                                child: Container(
                                  //color: Colors.yellow,
                                  //width: width / 2 - 30,
                                  // (MediaQuery.of(context).size.width / 2) -
                                  //     30,
                                  // height:
                                  //     height, //MediaQuery.of(context).size.height,
                                  margin:
                                      const EdgeInsets.fromLTRB(2, 10, 2, 200),
                                  //color: Colors.amber,
                                  child: ListView.builder(
                                    controller: myController,
                                    //reverse: true,
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
                                          // TODO: move to linked Stack, if it is linked, or show dialog to chose the Stack to link it
                                        },
                                        onLongPress: () {
                                          print(
                                              "Already played card long pressed: ${alreadyPlayed.cards[index].name}");
                                          // TODO: show dialog with options: Shufle in stack, Put on top of stack, Put on bottom of stack, Link card to stack
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    // To the Main Stack
                    // TODO: Move other buttons to the left of the screen,
                    // and make here ListView and button to add buttons to the list
                    // Each button may be linked to a stack from the list in the dialog by long press
                    Positioned(
                      bottom: 74,
                      left: 22,
                      child: GestureDetector(
                        child: Container(
                          width: 140,
                          height: 70,
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
                              "To the Main stack",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onTap: () {
                          print("To Main Stack was tapped");
                          // TODO: if id is 0, show dialog with all stacks names
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return ChangeSequanceDialog(list: stack.cards);
                          //   },
                          // );
                        },
                      ),
                    ),

                    // About Stack
                    Positioned(
                      bottom: 2,
                      left: 2,
                      child: GestureDetector(
                        child: Container(
                          width: 90,
                          height: 70,
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
                          // TODO: send stack id to show dialog with stack info
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return ChangeSequanceDialog(list: stack.cards);
                          //   },
                          // );
                        },
                      ),
                    ),

// TODO: Move Change sequence, About Stack, History, Discard a card to More options button
// and make them as a list in a dialog, to save space on the screen
// To the main stack change on 3 buttons like To the stack ... Where user can select the stacks to fast access them,
// and if user want to select another stack, he can select it from the list in the dialog by long press
                    // Change sequance
                    Positioned(
                      bottom: 2,
                      left: 94,
                      child: GestureDetector(
                        child: Container(
                          width: 90,
                          height: 70,
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
                          // TODO: sequence showing from end to start, change it to show from start to end
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

                    // Main object
                    Positioned(
                      bottom: -15,
                      right:
                          94, //(bodyContainerSize.width - mainObjSize.width) / 2,
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
                          print("Main object tapped");
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
                          //print("Main object long pressed");
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

                    // Discard wild
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: GestureDetector(
                        child: Container(
                          width: 90,
                          height: 70,
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
                                "Discard \n(a) card(s)",
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
                                list: stack.cards.map((e) => e.name).toList(),
                                name: stack.name,
                                discard: true,
                              );
                            },
                          );
                          print("Discard a card tapped");
                        },
                      ),
                    ),

                    // Watch story
                    Positioned(
                      bottom: 74,
                      right: 2,
                      child: GestureDetector(
                        child: Container(
                          //color: Colors.white,
                          width: 90,
                          height: 70,
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
                          context.read<HistoryBloc>().add(HistoryGetEvent());
                          context
                              .read<ProviderBloc>()
                              .add(HistoryProviderEvent());
                          print("History tapped");
                        },
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
