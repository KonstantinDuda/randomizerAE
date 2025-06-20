import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_state/turn_order_body_es.dart';
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

class _TurnOrderBodyState extends State<TurnOrderBody> {
  ScrollController myController = ScrollController();

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
    const Size mainObjSize = Size(130, 220);
    final contetnBodySize = Size(
      contentContainerSize.width - 10,
      contentContainerSize.height - mainObjSize.height - 5,
    );
    

    return BlocBuilder<TurnOrderBodyBloc, TurnOrderBodyState>(builder: (context, state) {

      Color stackColor;
      late CardsStack stack;
      late CardsStack alreadyPlayed;
      late List<AECard> even = [];
      late List<AECard> odd = [];
      List<Widget> varGridList = [];
      late Widget gridListSecondObj;


      gridObj(String text, bool newObj) {
        //print("root_body.dart gridObj()");
        return GestureDetector(
          child:
          MyCard(
            Center(
              child: Text(text,
                style: const TextStyle(fontSize: 23),
              ),
            ), Size(contetnBodySize.height / 3 - 10, contetnBodySize.height / 2 -10),
            borderWidth:  newObj ? 4 : 2, 
            borderColor: newObj ? Colors.lightGreen : Colors.black
          ),
          onLongPress: () {
            context.read<TurnOrderBodyBloc>().add(TurnOrderBodyShuffleInStackEvent(text));
            if(mounted) {
              setState(() {});
            }
          },
        );
      }

      Widget gridListLastObj = Column(
          children: [
            Container(
              height: contetnBodySize.height / 2 -10,
              width: contetnBodySize.height / 3 - 10,
              margin: const EdgeInsets.only(top: 5, left: 10),
            ),
            Container(
              height: contetnBodySize.height / 2 -10,
              width: contetnBodySize.height / 3 - 10,
              margin: const EdgeInsets.only(top: 5, left: 10),
            ),
          ],
        );
      

      gridObjLimiter(String text) {
        return Column(
          children: [
            gridObj(text, true),
            Container(
              height: contetnBodySize.height / 2 -10,
              width: contetnBodySize.height / 3 - 10,
              margin: const EdgeInsets.only(top: 5, left: 10),
            ),
          ],
        );
      }

      gridColumnObj(int id, bool topObjIsNew, bool bottomObjIsNew) {
        var firstText = '';
        var secondText = '';
        if(even.isNotEmpty) {
          firstText = even.last.text;
        }
        if(odd.isNotEmpty) {
          secondText = odd.last.text;
        }

        if(state is TurnOrderBodySuccessActionState) {
            return Container(
              //color: Colors.green,
              //padding: const EdgeInsets.only(right: 10, left: 10),
              child: Column(
                children: [
                  gridObj(secondText, topObjIsNew),
                  gridObj(firstText, bottomObjIsNew),
                  
                ],
              ),
            );
        }

        return const SizedBox(
          width: 0,
          height: 0,
        );
      }

      gridList() {
        // Функція повертає список віджетів що потім відобразиться на екрані     
          //print("root_body.dart gridList()");
        // alreadyPlayed ініціалізується empty обьєктом або тим що приходить з
        // блоку, тому перевірка саме по ідентифікатору.
        // пустий обьєкт завжди має id == 0. 
        if(alreadyPlayed.id != 0) {
          // Проходжусь по списку карток що вже розіграні
          for (var i = 0; i < alreadyPlayed.cards.length; i++) {
            // Розділяю картки на парні і непарні Тому що відмальовую по 2 карти в 
            // одному віджеті. 
            if(i % 2 == 0) {
              even.add(alreadyPlayed.cards[i]);
                //print("turn_order gridList() $i % 2 == 0");
              
              if(varGridList.isNotEmpty) {
                if(varGridList.last == gridListLastObj) {
                  // Якщо список віджетів не пустий і якщо останній віджет це пустий 
                  // віджет що створений для коректної прокрутки екрану ( список 
                  // прокручувався до останнього елемента) тільки коли створювався 
                  // другий віджет в парі. Мене це не влаштовувало тож я створив таку 
                  // пустишку що заповнює список і він прокручується як мені потрібно. 
                  // Та мені треба видаляти цю пустишку щоб вона не займала місце 
                  // між картками на екрані користувача
                  varGridList.removeLast();
                }
              }
              // Список непарних елементів списку створюється коли вже є повноцінний 
              // парний елемент. І якщо такий є, а я планую відмалювати ще один 
              // віджет то старий мені треба перемалювати так щоб у ньому не було 
              // картки з зеленим бортиком, що вказує на останню розіграну картку.
              // Замінюю її заздалегідь створеним парним віджетом але зі звичайними 
              // чорними бортиками.
              if(odd.isNotEmpty) {
                varGridList.removeAt(varGridList.length - 1);
                varGridList.add(gridListSecondObj);
              }
              // Потім додаю не звичайний віджет, а лімітер (обмежувач) що не має 
              // нижньої картки, а має тільки верхню і пустий простір знизу
              varGridList.add(gridObjLimiter(alreadyPlayed.cards[i].text));
              
            } else {
              odd.add(alreadyPlayed.cards[i]);
                //print("turn_order gridList() i % 2 != 0");
              
              // Щоразу після того як я додав до непарного списку хоч один елемент
              // в умові з парними я починаю створювати по 2 віджета. Правильний та
              // пустий. Пустий віджет я видаляю тут, перш ніж додавати новий.
              // Якщо останній віджет пустишка АБО в списку непарних карт довжина
              // менше 2 то я видаляю останній, тому що мені треба видалити лімітер 
              // що я створив раніше і замінити його на повноцінний парний елемент
              if(varGridList.length > 1)
                {varGridList.removeLast();}
              if(varGridList.last == gridListLastObj || odd.length < 2) {
                varGridList.removeLast();
              }
              varGridList.add(gridColumnObj(alreadyPlayed.cards[i].id, 
                true, false));
              // Мені не потрібно створювати пустишку для прокрутки якщо в секу вже 
              // 1 або менше карт.
              if(stack.cards.length > 1) {
                varGridList.add(gridListLastObj);
              }
             
             // Потім я записую такий самий парний елемент, але без зеленої рамки
              gridListSecondObj = gridColumnObj(
                alreadyPlayed.cards[i].id, false, false);        
            }
            if (myController.hasClients) {
              myController.jumpTo(myController.position.maxScrollExtent);  
            }
            
            
           }
        }
        return varGridList;
      }

      if(state is TurnOrderBodySuccessActionState) {
        //print("TurnOrderBody Page state IS TurnOrderBodySuccessActionState");
        stackColor = state.stack.stackColor;
        stack = state.stack;
        alreadyPlayed = state.alreadyPlayed;
        
      } else {
        //print("TurnOrderBody Page state is NOT TurnOrderBodySuccessActionState");
        stackColor = Colors.white;
        stack = const CardsStack.empty();
        alreadyPlayed =  const CardsStack.empty();
        if(mounted) {
          setState(() { });
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
                      color: stack.stackColor, //stackColor,
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
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                    margin: const EdgeInsets.only(left: 5, right: 5, bottom: 220),
                    alignment: Alignment.center,
                    child: ListView(
                      //shrinkWrap: true,
                      controller: myController,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ...gridList(),
                      ],
                    ),
                  ),
                  
                    
                      
                  
                  // Change sequance
                  Stack(
                        children: [
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ChangeSequanceDialog(list: stack.cards);
                                  },
                                );
                              },
                          ),),
                      
                      
                          // Main object
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              child:
                              MyCard( 
                                Center(
                                  child: Text(
                                  textAlign: TextAlign.center,
                                  stack.cards.isNotEmpty ? stack.name : "X", 
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: stackColor == Colors.black ? Colors.white : Colors.black),
                                  )
                                ), Size(mainObjSize.width, mainObjSize.height), 
                                bodyColor: stack.stackColor, margin: const EdgeInsets.all(0),),
                              onTap: () {
                                //print("Main object tapped");
                                if(stack.cards.isEmpty) {
                                  context.read<TurnOrderBodyBloc>().add(const TurnOrderBodyShuffleEvent());
                                } else {
                                  context.read<TurnOrderBodyBloc>().add(const TurnOrderBodyNextEvent());
                                }
                              },
                              onLongPress: () {
                                //print("Main object long pressed");
                                if(stack.cards.isNotEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return TopCardDialog(id: stack.cards.last.id , list: stack.cards);
                                  },
                                );
                                }
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
                                if(alreadyPlayed.cards.isEmpty) {
                                  context.read<TurnOrderBodyBloc>().add(const TurnOrderBodyDelWildEvent());
                                }
                                print("Discard wild tapped");
                              },
                            ),
                          ),
                        ],
                  ),
                  ],),
                          ),
              ),
        ],
      ),
      ),
    );

});
  }
}