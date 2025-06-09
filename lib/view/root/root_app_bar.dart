import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/bloc/event_state/friend_foe_body_es.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../bloc/event_state/turn_order_body_es.dart';
import '../../bloc/friend_foe_body_bloc.dart';
import '../../bloc/providers/root_body_provider.dart';
import '../../bloc/turn_order_body_bloc.dart';
import '../../database/cards_stack.dart';
//import '../../database/db_temporary.dart';

class RootAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  const RootAppBar(this._scaffoldKey, {super.key});

  @override
  State<RootAppBar> createState() => _RootAppBarState();
}

class _RootAppBarState extends State<RootAppBar> {
  // DbTemporary dbObj = DbTemporary();
  // /*late */ List<CardsStack> db = [];
  List<CardsStack> stacks = [];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //db = dbObj.getAvialableStacks();
  //   getData();
  // }

  // getData() async {
  //   db = await dbObj.getAvialableStacks();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<CRUDStackBloc, CRUDStackState>(
        builder: (context, state) {
      if (state is CRUDStackSuccessActionState) {
          stacks.clear();
        var allStacks = state.stacks;
        if(allStacks.isNotEmpty) {
          for (var element in allStacks) {
          if(element.isActive) {
              stacks.add(element);
            }
          }
        }
        print("RootAppBar stacks == $stacks \n");
      } else {
        print("RootAppBar state is NOT CRUDStackSuccessActionState");
      }
    return 

    Container(
      width: size.width,
      color: Colors.blue,
      child: Container(
        //width: size.width,
        margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Aeons End Randomizer'),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Stack(children: [
                    const Icon(Icons.circle_outlined),
                    Container(
                      margin: const EdgeInsets.fromLTRB(4, 3, 0, 0),
                      child: const Icon(Icons.question_mark, size: 16),
                    ),
                  ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Stack(
                    children: [
                      Container(
                        width: 70,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Icon(Icons.arrow_right, size: 50),
                      ),
                    ],
                  ),
                  onTap: () {
                    widget._scaffoldKey.currentState?.openDrawer();
                  },
                ),
                SizedBox(
                  width: size.width - 80,
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    //itemCount: db.length,
                    itemCount: stacks.isEmpty ? 0 : stacks.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          width: 30,
                          height: 40,
                          decoration: BoxDecoration(
                            //color: db[index].stackColor,
                            color: stacks[index].stackColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        onTap: () {
                          //if (db[index].stackType == StackType.turnOrder) {
                            if (stacks[index].stackType == StackType.turnOrder) {
                            context.read<TurnOrderBodyBloc>().add(
                                TurnOrderBodyChangeActiveStackEvent(
                                    // db[index].id));
                                    stacks[index].id));
                            context.read<RootBodyProviderBloc>().add(
                                const RootBodyTurnOrderEvent(
                                    ));
                          //} else if (db[index].stackType == StackType.friendFoe) {
                            } else if (stacks[index].stackType == StackType.friendFoe) {
                            var heroStack =
                                // dbObj.getHeroStackByStackId(db[index].id);
                                  stacks[index];
                                print("RootAppBar heroStack == $heroStack \n");
                            context.read<FriendFoeBodyBloc>().add(FriendFoeBodyInitialEvent(heroStack.id));
                            context
                                .read<RootBodyProviderBloc>()
                                .add(RootBodyFriendFoeEvent());
                          } else {
                            context
                                .read<RootBodyProviderBloc>()
                                .add(RootBodyLoadingEvent());
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
    );
    }
}
