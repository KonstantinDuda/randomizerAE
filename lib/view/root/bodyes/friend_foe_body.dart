import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:randomizer_new/database/cards_stack.dart';
import 'package:randomizer_new/database/db_temporary.dart';
import 'package:randomizer_new/view/root/bodyes/my_card.dart';

import '../../../bloc/event_state/friend_foe_body_es.dart';
import '../../../bloc/friend_foe_body_bloc.dart';
import '../../../bloc/providers/root_body_provider.dart';

class FriendFoeBody extends StatefulWidget {
  const FriendFoeBody({super.key});

  @override
  State<FriendFoeBody> createState() => _FriendFoeBody();
}

class _FriendFoeBody extends State<FriendFoeBody> {
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
    const Size mainObjSize = Size(170, 260);

    return BlocBuilder<FriendFoeBodyBloc, FriendFoeBodyState>(
        builder: (context, state) {
      var database = DbTemporary(); // TODO create hero table in db. Delete this
      HeroStack hero = HeroStack.empty();
      var isHeroEmpty = hero.id == 0 ? true : false;
      var abilityName = "";
      var abilityDescription = "";

      late CardsStack stack;
      late CardsStack alreadyPlayed;

      String cardNameText = "";
      bool isCardOptional = false;
      String cardTextBeforeOr = "";
      String cardTextAfterOr = "";

      List<String> alreadyCardNames = [];
      List<bool> isAlreadyCardOptional = [];
      List<String> alreadyTextsBeforOr = [];
      List<String> alreadyTextsAfterOr = [];

      List<Widget> widgetList = [];

      setData() {
        if (stack.cards.isNotEmpty) {
          List<String> nameText = stack.cards.last.text.split(":");
          if (nameText.length > 1) {
            cardNameText = stack.cards.last.text.split(":")[0];
            List<String> texts = nameText[1].split("OR");
            cardTextBeforeOr = texts[0];
            if (texts.length > 1) {
              //cardTextAfterOr = texts[1];
              cardTextAfterOr = texts.sublist(1, texts.length - 1).join(" \n OR \n ");
              isCardOptional = true;
            }
          }
        }

        if (alreadyPlayed.cards.isNotEmpty) {
          for (var i = 0; i < alreadyPlayed.cards.length; i++) {
            var alreadyNameText = alreadyPlayed.cards[i].text.split(":");
            if (alreadyNameText.length > 1) {
              alreadyCardNames.add(alreadyPlayed.cards[i].text.split(":")[0]);
              List<String> alreadyTexts = alreadyNameText[1].split("OR");
              if (alreadyTexts.length > 1) {
                alreadyTextsBeforOr.add(alreadyTexts[0]);
                //alreadyTextsAfterOr.add(alreadyTexts[1]);
                alreadyTextsAfterOr.add(alreadyTexts.sublist(1, alreadyTexts.length -1).join(" \n OR \n"));
                isAlreadyCardOptional.add(true);
              } else {
                alreadyTextsBeforOr.add(alreadyNameText[1]);
                alreadyTextsAfterOr.add("");
                isAlreadyCardOptional.add(false);
              }
            } else {
              alreadyCardNames.add("");
              alreadyTextsBeforOr.add("");
              alreadyTextsAfterOr.add("");
              isAlreadyCardOptional.add(false);
            }
          }
        }
      }

      if (state is FriendFoeBodySuccessActionState) {
        stack = state.stack;
        alreadyPlayed = state.alreadyPlayed;

        if(hero.id == 0) {
          hero = database.getHeroStackByStackId(stack.id);
        } else {
          
        }
        //hero = database.getHeroStackByStackId(stack.id);
        hero.id == 0 ? isHeroEmpty = true : isHeroEmpty = false;
        var abilList = hero.ability.split(":");
        abilityName = hero.ability.split(":")[0];
        if(abilList.length > 1) {
          abilityDescription = hero.ability.split(":")[1];
        }
        setData();
        //setState(() { });
      } else {
        print("FriendFoeBodyBloc state is not FriendFoeBodySuccessActionState");
        //stack = const CardsStack.empty();
        //alreadyPlayed = const CardsStack.empty();
        setState(() {});
      }

      energyClosets() {
        List<Widget> closets = [];

        var energyCC = isHeroEmpty ? 0 : hero.energyClosetCount;
        var energyPC = isHeroEmpty ? 0 : hero.energyPointCount;

        if (energyPC > energyCC) {
          energyPC -= energyCC;
        }
        if (energyCC > 0) {
          for (int i = 0; i < energyCC; i++) {
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
        }
        return closets;
      }

      myTextWidget(String text, double fontSize) {
        var localFontSize = fontSize;
        if (text.length > 70) {
          localFontSize -= 2;
          if (text.length > 100) {
            localFontSize -= 2;
          }
        }
        return Text(
          text,
          style: TextStyle(
            fontSize: localFontSize,
          ),
          textAlign: TextAlign.center,
        );
      }

      listWidgets() {
        if (alreadyPlayed.cards.isNotEmpty) {
          for (var i = 0; i < alreadyPlayed.cards.length; i++) {
            var element = alreadyPlayed.cards[i];
            widgetList.add(
              MyCard(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myTextWidget(element.text.split(":")[0], 14),
                    myTextWidget(element.text.split(":")[1].split("OR")[0], 12),
                    myTextWidget(isAlreadyCardOptional[i] ? "OR" : "", 14),
                    myTextWidget(
                        isAlreadyCardOptional[i]
                            ? element.text.split(":")[1].split("OR")[1]
                            : "",
                        12),
                  ],
                ),
                Size(mainObjSize.width - 40, mainObjSize.height - 40),
                margin: const EdgeInsets.all(5),
              ),
            );
          }
        }
        if(stack.cards.isEmpty) {
          widgetList.clear();
          context.read<FriendFoeBodyBloc>().add(FriendFoeBodyInitialEvent(hero.id));
        }
        return widgetList;
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
                      //isHeroEmpty ? "Empty data" : widget.stack.name,
                      isHeroEmpty ? "Empty data" : stack.name,
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
                    color: isHeroEmpty
                        ? Colors.white
                        //: widget.stack.heroStacks[0].stackColor, //stackColor,
                        : stack.stackColor,
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
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      context
                          .read<RootBodyProviderBloc>()
                          .add(const RootBodyTurnOrderEvent());
                    },
                    child: const Text(
                      "Back to Turn order deck",
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
                                child: Text(
                                  // cardNamesText.isNotEmpty
                                  //     ? cardNamesText.last
                                  //     : "",
                                  cardNameText,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: MyCard(
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      myTextWidget(
                                          // cardTextsBeforeOr.isEmpty
                                          //     ? "X"
                                          //     : cardTextsBeforeOr.last, //stack.cards.last.text.split(":")[0].split("OR")[0],
                                          stack.cards.isNotEmpty ?
                                          cardTextBeforeOr : "X",
                                          stack.cards.isNotEmpty ? 16 : 35),
//                                          16),
                                      myTextWidget(
                                          isCardOptional ? "OR" : "", 20),
                                      myTextWidget(
                                          // cardTextsAfterOr.isEmpty
                                          //     ? "X"
                                          //     : cardTextsAfterOr.last,
                                          cardTextAfterOr,
                                          16),
                                    ],
                                  ),
                                  Size(mainObjSize.width, mainObjSize.height),
                                  margin: const EdgeInsets.all(0),
                                ),
                                onTap: () {
                                  print(
                                      "FriendFoeBody onTap cardName == $cardNameText"); // ${cardNamesText.last}");
                                      if(stack.cards.isNotEmpty) {
                                        print(
                                      "FriendFoeBody onTap stack.cards.isNotEmpty == ${stack.cards}");
                                  context
                                      .read<FriendFoeBodyBloc>()
                                      .add(FriendFoeBodyNextEvent(hero.id));
                                      } else {
                                      
                                    print(
                                      "FriendFoeBody onTap stack.cards.isEmpty hero.id == ${hero.id} ");
                                        context.read<FriendFoeBodyBloc>().add(FriendFoeBodyInitialEvent(hero.id));
                                      }
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width -
                                mainObjSize.width -
                                50,
                            height: MediaQuery.of(context).size.height -
                                mainObjSize.height,
                            child: ListView(
                              children: <Widget>[
                                ...listWidgets(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Ability
                  Text(
                    isHeroEmpty ? "Ability name" : abilityName,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const Divider(),
                  Text(
                    isHeroEmpty ? "Ability description" : abilityDescription,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),

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
