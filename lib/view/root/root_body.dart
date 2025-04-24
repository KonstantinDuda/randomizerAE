import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/bloc/event_state/root_body_es.dart';
import 'package:randomizer_new/bloc/root_body_bloc.dart';
import 'package:randomizer_new/database/cards_stack.dart';

class RootBody extends StatefulWidget {
  const RootBody({super.key});

  @override
  State<RootBody> createState() => _RootBodyState();
}

class _RootBodyState extends State<RootBody> {

  @override
  Widget build(BuildContext context) {
    final Size bodyContainerSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height - 104.5,
    );

    return BlocBuilder<RootBodyBloc, RootBodyState>(builder: (context, state) {
      Color stackColor;
      late CardsStack stack;
      late CardsStack alrereadyPlayed;
      if(state is RootBodySuccessActionState) {
        stackColor = state.stack.stackColor;
        stack = state.stack;
        alrereadyPlayed = state.alreadyPlayed;
      } else {
        stackColor = Colors.white;
        stack = const CardsStack.empty();
        alrereadyPlayed = const CardsStack.empty();
      }

      gridObj(String text) {
        if(state is RootBodySuccessActionState) {
            return Container(
              width: 40,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Text(text, 
                style: const TextStyle(fontSize: 18),
              ),
            );
        }

        return const SizedBox(
          width: 0,
          height: 0,
        );
      }

      gridList() {
        List<Widget> gridList = [];
        if(alrereadyPlayed.id != 0) {
          for (var i = 0; i < alrereadyPlayed.cards.length ; i++) {
            gridList.add(gridObj(alrereadyPlayed.cards[i].text));
          }
        }
        return gridList;
      }


      return 
    
    
    Container(
      color: Colors.blue,
      height: bodyContainerSize.height,
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Column( 
      children: <Widget>[
        ColoredBox(
          color: Colors.blue,
          child: Row(
              children: <Widget>[
                 Expanded(
                  child: Center(
                    child: Text(stack.name, 
                      style: const TextStyle(fontSize: 30), 
                      overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Center(
                    child: Text('stack color', 
                        style: TextStyle(fontSize: 15, 
                        color: stackColor,)
                    ),
                  ),
                ),
              ],
            ),
        ),
            Container(
              height: bodyContainerSize.height - 60,
              width: bodyContainerSize.width - 20,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [


                  // Main object
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      child: Container(
                        width: 130,
                        height: 220,
                        decoration: BoxDecoration(
                          color: stackColor,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: Text(
                          stack.id != 0 ? stack.name : "X", 
                          style: TextStyle(fontSize: 30),
                        )),
                      ),
                      onTap: () {
                        print("Main object tapped");
                      },
                    ),
                  ),

                  GridView.count(crossAxisCount: 4, 
                    children: <Widget>[
                      ...gridList(),
                    ]),


                  // Discard wild
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child: Container(
                        width: 100,
                        height: 70,
                        decoration: BoxDecoration(
                          //color: stackColor,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(18),
                            topLeft: Radius.circular(18),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, top: 2),
                          child: const Text("Discard wild",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      onTap: () {
                        print("Discard wild tapped");
                      },
                    ),
                  ),

                  // Change sequance
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      child: Container(
                        width: 100,
                        height: 70,
                        decoration: BoxDecoration(
                          //color: stackColor,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, top: 2),
                          child: const Text("Change sequance",
                          style: TextStyle(fontSize: 18),)),
                      ),
                      onTap: () {
                        print("Change sequance tapped");
                      },
                    ),
                  ),
                ],
              ),
        ),
      ],
    ),
    );

});
  }
}