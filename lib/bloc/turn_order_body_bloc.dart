import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/database/db_provider.dart';

import 'event_state/turn_order_body_es.dart';
import '../database/cards_stack.dart';
//import '../database/db_temporary.dart';

class TurnOrderBodyBloc extends Bloc<TurnOrderBodyEvent, TurnOrderBodyState> {
  late CardsStack stack = const CardsStack.empty();
  late CardsStack alreadyPlayed = const CardsStack.empty();
  //final database = DbTemporary();
  final db = DBProvider();
  
  TurnOrderBodyBloc() : super(const TurnOrderBodySuccessActionState()) {
    on<TurnOrderInitialEvent>(_onInit);
    on<TurnOrderBodyNextEvent>(_onNext);
    on<TurnOrderBodyDelWildEvent>(_onDelWild);
    on<TurnOrderBodyShuffleEvent>(_onShuffle);
    on<TurnOrderBodyShuffleInStackEvent>(_onShuffleIn);
    on<TurnOrderBodyChangeSequenceEvent>(_onChangeSequence);
    on<TurnOrderBodyChangeActiveStackEvent>(_onChangeActiveStack);
    //on<TurnOrderBodyChangeAvailableStackListEvent>(_onChangeAvailableList);
  }

   void _onInit(TurnOrderInitialEvent event, Emitter<TurnOrderBodyState> emit) async {
    if(stack.id == 0) {
      //stack = database.getActiveStack();
      var stackList = await db.getAvailableStacks();
      for (var element in stackList) {
        if(element.stackType == StackType.turnOrder) {
          stack = element;
          break;
        }
      }
      //stack = stackList.isNotEmpty ? stackList.first : const CardsStack.empty();
      print("TurnOrderBodyBloc _onNext stack.id == 0 stack == $stack \n");
    } else {
      print("TurnOrderBodyBloc _onNext stack.id != 0 stack.cards == ${stack.cards} \n");
    }

    emit(TurnOrderBodySuccessActionState(stack, alreadyPlayed));
   }

  void _onNext(TurnOrderBodyNextEvent event, Emitter<TurnOrderBodyState> emit) async {
    // Handle the next event
    
print("TurnOrderBodyBloc _onNext stack.id == ${stack.id} \n");
    if(stack.id == 0 || stack.cards.isEmpty) {
      //stack = database.getActiveStack();

stack = await db.getStackById(stack.id);

      alreadyPlayed = const CardsStack.empty();
      stack.cards.shuffle();
      print("TurnOrderBodyBloc _onNext stack.id == 0 stack.cards == ${stack.cards} \n");
    } else {
      if(alreadyPlayed.id == 0) {
        alreadyPlayed = CardsStack(
          id: stack.id,
          name: stack.name,
          isActive: false,
          stackType: StackType.turnOrder,
          stackColor: stack.stackColor,
          cards: [],
        );
      }
      alreadyPlayed.cards.add(stack.cards.last);
      stack.cards.removeLast();
    }
    

    var newStack = CardsStack(
      id: -1,
      name: stack.name,
      isActive: stack.isActive,
      stackType: StackType.turnOrder,
      stackColor: stack.stackColor,
      cards: stack.cards,
    );

    var newAlreadyPlayed = CardsStack(
      id: -2,
      name: alreadyPlayed.name,
      isActive: alreadyPlayed.isActive,
      stackType: StackType.turnOrder,
      stackColor: alreadyPlayed.stackColor,
      cards: alreadyPlayed.cards,
    );


    print("TurnOrderBodyBloc _onNext stack.id != 0 stack == $stack \n ");
    print("TurnOrderBodyBloc _onNext alreadyPlayed.cards == ${alreadyPlayed.cards} \n");
      
    emit(TurnOrderBodySuccessActionState(newStack, newAlreadyPlayed));

  }

  void _onDelWild(TurnOrderBodyDelWildEvent event, Emitter<TurnOrderBodyState> emit) {
    // Handle the delete wild event
    List<AECard> newAlreadyCards = [];
    newAlreadyCards.add(AECard(
      id: 5,
      text: 'Wild',
      imgPath: 'assets/images/wild.png'));

    for (var i = 0; i < stack.cards.length; i++) {
      if(stack.cards[i].id == 5) {
        stack.cards.removeAt(i);
      }
    }

    print("TurnOrderBodyBlock onDelWild stack.cards after Wild deleted == ${stack.cards} \n");
    alreadyPlayed = CardsStack(
      id: stack.id,
      name: stack.name,
      isActive: false,
      stackType: StackType.turnOrder,
      stackColor: stack.stackColor,
      cards: newAlreadyCards,
    );

    
    List<AECard> newCardsList = stack.cards;
    var newStack = CardsStack(
      id: -1, //stack.id,
      name: stack.name,
      isActive: stack.isActive,
      stackType: StackType.turnOrder,
      stackColor: stack.stackColor,
      cards: newCardsList,
    );      // Something is wrong here

    var newAlreadyPlayed = CardsStack(
      id: -2, // alreadyPlayed.id,
      name: alreadyPlayed.name,
      isActive: alreadyPlayed.isActive,
      stackType: StackType.turnOrder,
      stackColor: alreadyPlayed.stackColor,
      cards: newAlreadyCards,
    );   


    emit(TurnOrderBodySuccessActionState(newStack, newAlreadyPlayed));
  }

  void _onShuffle(TurnOrderBodyShuffleEvent event, Emitter<TurnOrderBodyState> emit) async {
    // Handle the shuffle event
  print("TurnOrderBodyBlock _onShuffle stack.cards.length == ${stack.cards.length} \n");
    //stack = database.getActiveStack();
    stack = await db.getStackById(stack.id);
    stack.cards.shuffle();
    alreadyPlayed = const CardsStack.empty();
    // var newStack = CardsStack(
    //   id: -1, //stack.id,
    //   name: stack.name,
    //   isActive: stack.isActive,
    //   stackType: StackType.turnOrder,
    //   stackColor: stack.stackColor,
    //   cards: stack.cards,
    // );
    //emit(TurnOrderBodySuccessActionState(newStack, alreadyPlayed));
    emit(TurnOrderBodySuccessActionState(stack, alreadyPlayed));
  }

  void _onShuffleIn(TurnOrderBodyShuffleInStackEvent event, Emitter<TurnOrderBodyState> emit) {
    // Handle the shuffle in stack event
    print("TurnOrderBodyBlock _onShuffleIn text == ${event.text} \n");
    print("TurnOrderBodyBloc _onShuffleIn alreadyPlayed.cards == ${alreadyPlayed.cards} \n");

    AECard card = AECard(id: 0, text: "", imgPath: "");
    for (var i = 0; i < alreadyPlayed.cards.length; i++) {
      if(alreadyPlayed.cards[i].text == event.text) {
        card = alreadyPlayed.cards[i];
        alreadyPlayed.cards.removeAt(i);
        break;
      }
    }

    // var newStack = CardsStack(
    //   id: -1, //stack.id,
    //   name: stack.name,
    //   isActive: stack.isActive,
    //   stackType: StackType.turnOrder,
    //   stackColor: stack.stackColor,
    //   cards: stack.cards,
    // );
    if(card.id > 0) {
      stack.cards.add(card);
      stack.cards.shuffle();
    }
    //stack = newStack;

    print("TurnOrderBodyBloc _onShuffleIn stack == $stack \n ");
    print("TurnOrderBodyBloc _onShuffleIn alreadyPlayed.cards == ${alreadyPlayed.cards} \n");

    emit(TurnOrderBodySuccessActionState(/*newStack*/ stack, alreadyPlayed));
  }

  void _onChangeSequence(TurnOrderBodyChangeSequenceEvent event, 
                              Emitter<TurnOrderBodyState> emit) {
    var newCardsList = event.list;

     var newStack = CardsStack(
      id: stack.id,
      name: stack.name,
      isActive: stack.isActive,
      stackType: stack.stackType,
      stackColor: stack.stackColor,
      cards: newCardsList,
    ); 
    stack = newStack;
    print("TurnOrderBodyBlock _onChangeSequence "
          "stack == $stack \n "
          "newStack.cards == ${newStack.cards} \n ");

    emit(TurnOrderBodySuccessActionState(newStack, alreadyPlayed));
  }

  void _onChangeActiveStack(TurnOrderBodyChangeActiveStackEvent  event, 
                                      Emitter<TurnOrderBodyState> emit) async {
    //emit(const TurnOrderBodyClearScreenState());
    print("TurnOrderBodyBlock. _onChangeActiveStack. event.id == ${event.id} \n");
    var dbStack = await db.getStackById(event.id);
    stack = dbStack;
    alreadyPlayed = const CardsStack.empty();



    // CardsStack newAlreadyPlayed = const CardsStack.empty();
    // CardsStack newStack = const CardsStack.empty();
    // for (var i in database.friendfoeList) {
    //   for (var j in i.heroStacks) {
    //     if(j.id != event.id) {
    //       newAlreadyPlayed = const CardsStack.empty();
    //       database.setActiveStack(event.id);
    //       newStack = database.getActiveStack();
    //       stack = newStack;
    //       alreadyPlayed = newAlreadyPlayed;
    //     } else {
    //       print("TurnOrderBodyBlock. _onChangeActiveStack. else");
    //       newAlreadyPlayed = alreadyPlayed;
    //       newStack = stack;
    //     }
    //   }
    // }

    
    // print("TurnOrderBodyBlock. _onChangeActiveStack. $newStack \n"
    //       "newAlreadyPlayed.cards == ${newAlreadyPlayed.cards} \n "
    //       "newStack.cards == ${newStack.cards}");
    
    emit(TurnOrderBodySuccessActionState(dbStack, const CardsStack.empty()));
//    emit(TurnOrderBodySuccessActionState(newStack, newAlreadyPlayed));
  }

  // void _onChangeAvailableList(TurnOrderBodyChangeAvailableStackListEvent event, 
  //                                             Emitter<TurnOrderBodyState> emit) async {
  //   //database.updateAvialableStack(event.id);
  //   for (var element in event.id) {
  //    var dbStack = await db.getStackById(element);
  //    //print("TurnOrderBodyBloc _onChangeAvailableList dbStack.id == ${dbStack.id} isActive = ${dbStack.isActive} \n");
  //      if(dbStack.id != 0) {
  //       var newIsActiveState = !dbStack.isActive;
  //       //print("TurnOrderBodyBloc _onChangeAvailableList dbStack.id == ${dbStack.id} newIsActiveState = $newIsActiveState \n");
  //         var newStack = CardsStack(
  //           id: dbStack.id,
  //           name: dbStack.name,
  //           isActive: newIsActiveState,
  //           stackType: dbStack.stackType,
  //           stackColor: dbStack.stackColor,
  //           cards: dbStack.cards,
  //         );
  //         await db.updateStack(newStack);
  //       }    
  //   }

  //   emit(TurnOrderBodySuccessActionState(stack, alreadyPlayed));
  // }
}