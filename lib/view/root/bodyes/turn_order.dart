import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import '/view/root/bodyes/dialog_shuffle_put.dart';
import '../../../bloc/event_state/history_es.dart';
import '../../../bloc/event_state/turn_order_body_es.dart';
import '../../../bloc/providers/provider_bloc.dart';
//import '../../../bloc/providers/root_body_provider.dart';
import '../../../bloc/history_bloc.dart';
import '../../../bloc/turn_order_body_bloc.dart';
import '../../../database/cards_stack.dart';
import 'dialog_ch_seq.dart';
import 'dialog_top_card.dart';
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
    final Size bodyContainerSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height - 104.5,
    );
    const Size mainObjSize = Size(130, 220);

    return BlocBuilder<TurnOrderBodyBloc, TurnOrderBodyState>(
        builder: (context, state) {
      Color stackColor;
      late CardsStack stack;
      late CardsStack alreadyPlayed;

      var clickCounter = 0;
      Widget lastPlayedCard = const Text("");

      if (state is TurnOrderBodySuccessActionState) {
        //print("TurnOrderBody Page state IS TurnOrderBodySuccessActionState");
        stackColor = state.stack.stackColor;
        stack = state.stack;
        alreadyPlayed = state.alreadyPlayed;
      } else {
        //print("TurnOrderBody Page state is NOT TurnOrderBodySuccessActionState");
        stackColor = Colors.white;
        stack = const CardsStack.empty();
        alreadyPlayed = const CardsStack.empty();
        if (mounted) {
          setState(() {});
        }
      }

      Widget lastPlayedAlreadyCard() {
        AECard lastPlayed = AECard(id: 0, name: "", text: "");
        if (alreadyPlayed.id != 0) {
          lastPlayed = alreadyPlayed.cards.last;
        }
        TextStyle nameStyle = const TextStyle(
          fontSize: 30.0,
        );

        lastPlayedCard = Column(
          children: [
            Text(
              lastPlayed.name,
              style: nameStyle,
            ),
            const Divider(
              height: 1,
            ),
            Text(lastPlayed.text),
          ],
        );
        if (lastPlayed.text == "") {
          lastPlayedCard = Center(
            child: Text(
              lastPlayed.name,
              style: nameStyle,
            ),
          );
        }

        return lastPlayedCard;
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
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 20,
                          height: MediaQuery.of(context).size.height - 20,
                          child: Row(
                            children: [
                              // Last played Card
                              Container(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    30,
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                margin: EdgeInsets.fromLTRB(2, 0, 2,
                                    MediaQuery.of(context).size.height / 5),
                                decoration: BoxDecoration(
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: FadeTransition(
                                  opacity: _lastPlayedOpacity ??
                                      const AlwaysStoppedAnimation(1.0),
                                  key: ValueKey(clickCounter),
                                  child: lastPlayedAlreadyCard(),
                                ), //Center(child: lastPlayedAlreadyCard()),
                              ),
                              // Divider
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 240),
                                width: 1.5,
                                color: Colors.black,
                              ),
                              // Already played List
                              Expanded(
                                child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          30,
                                  height: MediaQuery.of(context).size.height,
                                  margin:
                                      const EdgeInsets.fromLTRB(2, 10, 2, 200),
                                  //color: Colors.amber,
                                  child: const Text("already played ListView"),
                                ),
                              ),
                            ],
                          ),
                        )
                        /*Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 0, right: 0, bottom: 200),
                            alignment: Alignment.center,
                            child: ListView(
                              controller: myController,
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                // ...gridList(),
                                ...gridListNew(),
                              ],
                            ),
                          ),
                        ],
                      ),*/
                        ),

                    // About Stack
                    Positioned(
                      bottom: 80,
                      left: 2,
                      child: GestureDetector(
                        child: Container(
                          width: 100,
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
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return ChangeSequanceDialog(list: stack.cards);
                          //   },
                          // );
                        },
                      ),
                    ),

                    // Change sequance
                    Positioned(
                      bottom: 2,
                      left: 2,
                      child: GestureDetector(
                        child: Container(
                          width: 100,
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ChangeSequanceDialog(list: stack.cards);
                            },
                          );
                        },
                      ),
                    ),

                    // Main object
                    Positioned(
                      bottom: -15,
                      left: (bodyContainerSize.width - mainObjSize.width) / 2,
                      child: GestureDetector(
                        child: MyCard(
                          Center(
                              child: Text(
                            textAlign: TextAlign.center,
                            stack.cards.isNotEmpty ? stack.name : "X",
                            style: TextStyle(
                                fontSize: 30,
                                color: stackColor == Colors.black
                                    ? Colors.white
                                    : Colors.black),
                          )),
                          Size(mainObjSize.width, mainObjSize.height),
                          bodyColor: stack.stackColor,
                          margin: const EdgeInsets.all(0),
                        ),
                        onTap: () {
                          print("Main object tapped");
                          if (stack.cards.isEmpty) {
                            context
                                .read<TurnOrderBodyBloc>()
                                .add(const TurnOrderBodyShuffleEvent());
                          } else {
                            context
                                .read<TurnOrderBodyBloc>()
                                .add(const TurnOrderBodyNextEvent());
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
                                    id: stack.cards.last.id, list: stack.cards);
                              },
                            );
                          }
                        },
                      ),
                    ),

                    // Discard wild TODO: make it Discard a card
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: GestureDetector(
                        child: Container(
                          width: 100,
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
                                "Discard wild",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (alreadyPlayed.cards.isEmpty) {
                            context
                                .read<TurnOrderBodyBloc>()
                                .add(const TurnOrderBodyDelWildEvent());
                          }
                          print("Discard wild tapped");
                        },
                      ),
                    ),

                    // Watch story
                    Positioned(
                      bottom: 80,
                      right: 2,
                      child: GestureDetector(
                        child: Container(
                          //color: Colors.white,
                          width: 100,
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
