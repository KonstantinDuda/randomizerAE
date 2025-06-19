import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/db_provider.dart';
import '../database/default_data.dart';
import 'event_state/turn_order_body_es.dart';
import '../database/cards_stack.dart';
//import '../database/db_temporary.dart';

class TurnOrderBodyBloc extends Bloc<TurnOrderBodyEvent, TurnOrderBodyState> {
  late CardsStack stack = const CardsStack.empty();
  late CardsStack alreadyPlayed = const CardsStack.empty();
  final db = DBProvider();
  final data = DefaultData();

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

  void _onInit(
      TurnOrderInitialEvent event, Emitter<TurnOrderBodyState> emit) async {
    if (stack.id == 0) {

      var stackList = await db.getAvailableStacks();
      //var stackList = await data.getStacks();
      if(stackList.isNotEmpty) {
      for (var element in stackList) {
        if (element.stackType == StackType.turnOrder) {
          stack = element;
          break;
        }
      }
      }

      // var turnNF = 0;
      // var turnNN = 0;
      // var turnNNF = 0;
      // var NF = 0;
      // var NN = 0;
      // var NNF = 0;
      // var NNN = 0;
      // var NNFF = 0;
      // var NNNF = 0;
      // var NNNN = 0;
      // var NNNFF = 0;
      // var NNNNF = 0;
      // var NNNNFF = 0;
      // var allShuffles = [];

      // for (var i = 0; i < 100; i++) {
      //   var localStack = await db.getStackById(1);
      //   localStack.cards.shuffle();
      //   //var oneStack = [];
      //   var nemes = 0;
      //   var fo = 0;
      //   for (var j = 0; j < localStack.cards.length; j++) {
      //     allShuffles.add(localStack.cards[j].id);
      //     if (localStack.cards[j].id == 6) {
      //       nemes++;
      //     } else if (localStack.cards[j].id == 7) {
      //       fo++;
      //     } else {
      //       if (nemes > 1) {
      //         if (fo > 0) {
      //           turnNNF++;
      //         } else {
      //           turnNN++;
      //         }
      //       } else if (nemes > 0) {
      //         if (fo > 0) {
      //           turnNF++;
      //         }
      //       }
      //       nemes = 0;
      //       fo = 0;
      //     }
      //   }
      // }

      // var nemesis = 0;
      // var foe = 0;
      // for (var i = 0; i < allShuffles.length; i++) {
      //   if (allShuffles[i] == 6) {
      //     nemesis++;
      //   } else if (allShuffles[i] == 7) {
      //     foe++;
      //   } else {
      //     if (nemesis > 0) {
      //       if (nemesis == 1 && foe == 1) {
      //         NF++;
      //       } else if (nemesis == 2 && foe == 0) {
      //         NN++;
      //       } else if (nemesis == 2 && foe == 1) {
      //         NNF++;
      //       } else if (nemesis == 2 && foe == 2) {
      //         NNFF++;
      //       } else if (nemesis == 3 && foe == 1) {
      //         NNNF++;
      //       } else if (nemesis == 3 && foe == 2) {
      //         NNNFF++;
      //       } else if (nemesis == 4 && foe == 1) {
      //         NNNNF++;
      //       } else if (nemesis == 4 && foe == 2) {
      //         NNNNFF++;
      //       }
      //     }
      //     nemesis = 0;
      //     foe = 0;
      //   }
      // }
      // print(
      //     "\n \t \t За 100 повторень: \n \t По турам: \n Послідовних кроків Nemesis Foe або Foe Nemesis = $turnNF");
      // print("Немезіс ходить підряд по 2 рази = $turnNN");
      // print(
      //     "В різних комбінаціях послідовних кроків Nemesis Nemesis Foe = $turnNNF ");
      // print(
      //     "\t Якщо вистроїти всі тури підряд (для перевірки 3 кроків немезіса підряд і т.і.): ");
      // print("Nemesis Foe = $NF");
      // print("Nemesis Nemesis = $NN");
      // print("Nemesis Nemesis Foe різні комбінації: $NNF");
      // print("Nemesis Nemesis Foe Foe в різних комбінаціях: $NNFF");
      // print("Nemesis Nemesis Nemesis: $NNN");
      // print("Nemesis Nemesis Nemesis Foe в різних комбінаціях: $NNNF");
      // print("Nemesis Nemesis Nemesis Foe Foe в різних комбінаціях: $NNNFF");
      // print("Nemesis Nemesis Nemesis Nemesis: $NNNN");
      // print("Nemesis Nemesis Nemesis Nemesis Foe в різних комбінаціях: $NNNNF");
      // print(
      //     "Nemesis Nemesis Nemesis Nemesis Foe Foe в різних комбінаціях: $NNNNFF");

      //stack = stackList.isNotEmpty ? stackList.first : const CardsStack.empty();
      //print("TurnOrderBodyBloc _onInit stack.id == 0 stack == $stack \n");
    } else {

      print(
          "TurnOrderBodyBloc _onInit stack.id != 0 \n stack.cards == ${stack.cards} \n alreadyPlayed.cards == ${alreadyPlayed.cards}");
      
    }

    emit(TurnOrderBodySuccessActionState(stack, alreadyPlayed));
  }

  void _onNext(
      TurnOrderBodyNextEvent event, Emitter<TurnOrderBodyState> emit) async {
    // Handle the next event

    //print("TurnOrderBodyBloc _onNext stack.id == ${stack.id} \n");
    if (stack.id == 0 || stack.cards.isEmpty) {
      //stack = database.getActiveStack();

      stack = await db.getStackById(stack.id);

      alreadyPlayed = const CardsStack.empty();
      stack.cards.shuffle();
      // print(
      //     "TurnOrderBodyBloc _onNext stack.id == 0 stack.cards == ${stack.cards} \n");
    } else {
      if (alreadyPlayed.id == 0) {
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

    // print("TurnOrderBodyBloc _onNext stack.id != 0 stack == $stack \n ");
    // print(
    //     "TurnOrderBodyBloc _onNext alreadyPlayed.cards == ${alreadyPlayed.cards} \n");

    emit(TurnOrderBodySuccessActionState(newStack, newAlreadyPlayed));
  }

  void _onDelWild(
      TurnOrderBodyDelWildEvent event, Emitter<TurnOrderBodyState> emit) {
    // Handle the delete wild event
    List<AECard> newAlreadyCards = [];
    newAlreadyCards
        .add(AECard(id: 5, text: 'Wild', imgPath: 'assets/images/wild.png'));

    for (var i = 0; i < stack.cards.length; i++) {
      if (stack.cards[i].id == 5) {
        stack.cards.removeAt(i);
      }
    }

    print(
        "TurnOrderBodyBlock onDelWild stack.cards after Wild deleted == ${stack.cards} \n");
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
    ); // Something is wrong here

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

  void _onShuffle(
      TurnOrderBodyShuffleEvent event, Emitter<TurnOrderBodyState> emit) async {
    // Handle the shuffle event
    print(
        "TurnOrderBodyBlock _onShuffle stack.cards.length == ${stack.cards.length} \n");
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

  void _onShuffleIn(TurnOrderBodyShuffleInStackEvent event,
      Emitter<TurnOrderBodyState> emit) {
    // Handle the shuffle in stack event
    print("TurnOrderBodyBlock _onShuffleIn text == ${event.text} \n");
    print(
        "TurnOrderBodyBloc _onShuffleIn alreadyPlayed.cards == ${alreadyPlayed.cards} \n");

    AECard card = AECard(id: 0, text: "", imgPath: "");
    for (var i = 0; i < alreadyPlayed.cards.length; i++) {
      if (alreadyPlayed.cards[i].text == event.text) {
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
    if (card.id > 0) {
      stack.cards.add(card);
      stack.cards.shuffle();
    }
    //stack = newStack;

    print("TurnOrderBodyBloc _onShuffleIn stack == $stack \n ");
    print(
        "TurnOrderBodyBloc _onShuffleIn alreadyPlayed.cards == ${alreadyPlayed.cards} \n");

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

  void _onChangeActiveStack(TurnOrderBodyChangeActiveStackEvent event,
      Emitter<TurnOrderBodyState> emit) async {
    //emit(const TurnOrderBodyClearScreenState());
    print(
        "TurnOrderBodyBlock. _onChangeActiveStack. event.id == ${event.id} \n");
    var dbStack = await db.getStackById(event.id);
    stack = dbStack;
    alreadyPlayed = const CardsStack.empty();

    emit(TurnOrderBodySuccessActionState(dbStack, const CardsStack.empty()));
//    emit(TurnOrderBodySuccessActionState(newStack, newAlreadyPlayed));
  }
}
