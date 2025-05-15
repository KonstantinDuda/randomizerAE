import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/database/cards_stack.dart';

import '../../../bloc/event_state/friend_foe_body_es.dart';
import '../../../bloc/friend_foe_body_bloc.dart';

class FriendFoeBody extends StatefulWidget {
  final HeroStack stack;

  const FriendFoeBody(this.stack, {super.key});

  @override
  State<FriendFoeBody> createState() => _FriendFoeBody();
}

class _FriendFoeBody extends State<FriendFoeBody> {
  @override
  Widget build(BuildContext context) {
    bool isHeroEmpty = widget.stack.id == 0 ? true : false;
    bool isCardOptional = true;

    var ability = widget.stack.ability.split(":");
    var abilityName = ability[0];
    var abilityDescription = ability[1];

    final Size bodyContainerSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height - 104.5,
    );
    final Size contentContainerSize = Size(
      bodyContainerSize.width - 20,
      bodyContainerSize.height - 60,
    );
    const Size mainObjSize = Size(130, 220);

    energyClosets() {
      List<Widget> closets = [];
      var energyPC = widget.stack.energyPointCount;
      if(energyPC > widget.stack.energyClosetCount) {
        energyPC -= widget.stack.energyClosetCount;
      }
      for (int i = 0; i < widget.stack.energyClosetCount; i++) {
        closets.add(
          Container(
              width: 40,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              decoration: BoxDecoration(
                color: i < energyPC ? Colors.blue : Colors.white,
                border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          
        );
      }
      return closets;
    }

    return BlocBuilder<FriendFoeBodyBloc, FriendFoeBodyState>(builder: (context, state) {
      //List<AECard> cards = widget.stack.heroStacks[0].cards;
      //var cardNameText = cards[0].text.split(":");
      //var cardTexts = cardNameText[1].split("OR");

      late CardsStack stack;
      late CardsStack alreadyPlayed;
      List<String> cardNameText = [];
      List<String> cardTexts = [];

      List<Widget> widgetList = [];

      if(state is FriendFoeBodySuccessActionState) {
        stack = state.stack;
        alreadyPlayed = state.alreadyPlayed;
        cardNameText = stack.cards[0].text.split(":");
        cardTexts = cardNameText[1].split("OR");
      } else {
        stack = const CardsStack.empty();
        alreadyPlayed = const CardsStack.empty();
      }



    return Container(
      width: bodyContainerSize.width,
      height: bodyContainerSize.height,
      color: Colors.blue,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    isHeroEmpty ?  "Empty data" : widget.stack.name,
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
                  color: isHeroEmpty ? Colors.white : widget.stack.heroStacks[0].stackColor, //stackColor,
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

          // Back to turn order deck
          Container(
            width: contentContainerSize.width,
            height: contentContainerSize.height,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget> [
                TextButton(
                  onPressed: () {}, 
                  child: const Text("Back to Turn order deck",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                
                // Body
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: mainObjSize.width,
                              height: 70,
                              child: Text("${cardNameText[0]} and some text to watch result with so long card name",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              width: mainObjSize.width,
                              height: mainObjSize.height,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  
                                    Text(isHeroEmpty ? "X" : cardTexts[0],//widget.stack.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                    ),
                                    Text(isCardOptional ? "OR" : "",
                                      style: const TextStyle(
                                        fontSize: 22,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(isHeroEmpty ? "X" : cardTexts[1],//widget.stack.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(),
                        Container(

                        ),
                      ],
                    ),
                  ),
                ),


                // Ability
                Text(abilityName, 
                  style: const TextStyle(fontSize: 24),),
                const Divider(),
                Text(abilityDescription, textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),),
                
                // Energy closets
                Container(
                  width: contentContainerSize.width,
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: //Text("Energy closets: ${widget.stack.energyClosetCount}", textAlign: TextAlign.center,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: energyClosets(),
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
