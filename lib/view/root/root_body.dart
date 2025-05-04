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
    final Size contentContainerSize = Size(
      bodyContainerSize.width - 20,
      bodyContainerSize.height - 60,
    );

    return BlocBuilder<RootBodyBloc, RootBodyState>(builder: (context, state) {
      Color stackColor;
      late CardsStack stack;
      late CardsStack alrereadyPlayed;
      List<Widget> varGridList = [];
      if(state is RootBodySuccessActionState) {
        stackColor = state.stack.stackColor;
        stack = state.stack;
        alrereadyPlayed = state.alreadyPlayed;
      } else {
        print("RootBody Page state is NOT RootBodySuccessActionState");
        stackColor = Colors.white;
        stack = const CardsStack.empty();
        alrereadyPlayed =  const CardsStack.empty();
        setState(() {
        //   stackColor = Colors.white;
        //   stack = const CardsStack.empty();
        //   alrereadyPlayed =  const CardsStack.empty();
        });
      }

      gridObj(String text) {
        if(state is RootBodySuccessActionState) {
            return Container(
              height: 200,
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(text, 
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            );
        }

        return const SizedBox(
          width: 0,
          height: 0,
        );
      }

      gridList() {
        print("root_body.dart gridList()");
        if(alrereadyPlayed.id != 0) {
          for (var i = 0; i < alrereadyPlayed.cards.length; i++) {
            varGridList.add(gridObj(alrereadyPlayed.cards[i].text));
          }
          print("root_body.dart gridList() varGridList == ${varGridList.length} \n");
        } else {
          print("root_body.dart gridList() else \n");
          varGridList.clear();
        }
        return varGridList;
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
                  height: 28,
                  width: 80,
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  //alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    color: stackColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Align(
                    //alignment: Alignment.topCenter,
                    child: Text('stack color',
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
            Container(
              height: contentContainerSize.height,
              width: contentContainerSize.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(children: [

              
              Container(
                margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                height: contentContainerSize.height - 225,
                child: GridView.count(
                  crossAxisCount: 4, 
                  children: <Widget>[
                    ...gridList(),
                  ]),
              ),
              
                

              
              
              Stack(
                    children: [

                  
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
                      ),),


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
                              textAlign: TextAlign.center,
                              stack.cards.isNotEmpty ? stack.name : "X", 
                              style: TextStyle(
                                fontSize: 30,
                                color: stackColor == Colors.black ? Colors.white : Colors.black),
                            )),
                          ),
                          onTap: () {
                            print("Main object tapped");
                            context.read<RootBodyBloc>().add(const RootBodyNextEvent());
                          },
                        ),
                      ),


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
                    ],
              ),
              ],),
        ),
      ],
    ),
    );

});
  }
}