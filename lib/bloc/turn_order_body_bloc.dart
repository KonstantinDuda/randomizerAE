import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/db_provider.dart';
import '../database/default_data.dart';
import 'event_state/turn_order_body_es.dart';
import '../database/cards_stack.dart';
//import '../database/db_temporary.dart';

class TurnOrderBodyBloc extends Bloc<TurnOrderBodyEvent, TurnOrderBodyState> {
  late List<CardsStack> stacks = [];
  late List<CardsStack> alreadyPlayed = [];
  Map<String, int> links = {};
  List<String> linksKeys = [];
  final db = DBProvider();
  final data = DefaultData();

  TurnOrderBodyBloc() : super(const TurnOrderBodySuccessActionState()) {
    on<TurnOrderInitialEvent>(_onInit);
    on<TurnOrderBodyNextEvent>(_onNext);
    //on<TurnOrderBodyDelWildEvent>(_onDelWild);
    on<TurnOrderBodyDiscardEvent>(_onDiscard);
    on<TurnOrderBodyShuffleEvent>(_onShuffle);
    on<TurnOrderBodyShuffleInStackEvent>(_onShuffleIn);
    on<TurnOrderBodyPutInButtom>(_onPutInTheButtom);
    on<TurnOrderBodyChangeSequenceEvent>(_onChangeSequence);
    on<TurnOrderBodyChangeActiveStackEvent>(_onChangeActiveStack);
    //on<TurnOrderBodyClearStackEvent>(_onClearStack);
    //on<TurnOrderBodyChangeAvailableStackListEvent>(_onChangeAvailableList);
  }

  void _onInit(
      TurnOrderInitialEvent event, Emitter<TurnOrderBodyState> emit) async {
    alreadyPlayedCheck() {
      if (alreadyPlayed.isEmpty) {
        alreadyPlayed.addAll(stacks.map((e) => e.copyWith(cards: [])));
      } else {
        for (var i = 0; i < stacks.length; i++) {
          var alreadyStack = alreadyPlayed.firstWhere(
              (element) => element.id == stacks[i].id,
              orElse: () => const CardsStack.empty());
          if (alreadyStack.id == 0) {
            alreadyPlayed.add(stacks[i].copyWith(cards: []));
          }
        }
      }
    }

    if (stacks.isEmpty) {
      var stackList = await db.getAvailableStacks();
      List<CardsStack> shuffledStacks = [];
      //var stackList = await data.getStacks();
      if (stackList.isNotEmpty) {
        for (int i = 0; i < stackList.length; i++) {
          List<AECard> cards = stackList[i].cards;
          cards.shuffle();
          print("TOBB _onInit: cards.shuffled == $cards");
          shuffledStacks.add(stackList[i].copyWith(cards: cards));
        }
        stacks.addAll(shuffledStacks);
      }

      /*var turnNF = 0;
      var turnNN = 0;
      var turnNNF = 0;
      var NF = 0;
      var NN = 0;
      var NNF = 0;
      var NNN = 0;
      var NNFF = 0;
      var NNNF = 0;
      var NNNN = 0;
      var NNNFF = 0;
      var NNNNF = 0;
      var NNNNFF = 0;
      var allShuffles = [];

      for (var i = 0; i < 100; i++) {
        var localStack = await db.getStackById(1);
        localStack.cards.shuffle();
        //var oneStack = [];
        var nemes = 0;
        var fo = 0;
        for (var j = 0; j < localStack.cards.length; j++) {
          allShuffles.add(localStack.cards[j].id);
          if (localStack.cards[j].id == 6) {
            nemes++;
          } else if (localStack.cards[j].id == 7) {
            fo++;
          } else {
            if (nemes > 1) {
              if (fo > 0) {
                turnNNF++;
              } else {
                turnNN++;
              }
            } else if (nemes > 0) {
              if (fo > 0) {
                turnNF++;
              }
            }
            nemes = 0;
            fo = 0;
          }
        }
      }

      var nemesis = 0;
      var foe = 0;
      for (var i = 0; i < allShuffles.length; i++) {
        if (allShuffles[i] == 6) {
          nemesis++;
        } else if (allShuffles[i] == 7) {
          foe++;
        } else {
          if (nemesis > 0) {
            if (nemesis == 1 && foe == 1) {
              NF++;
            } else if (nemesis == 2 && foe == 0) {
              NN++;
            } else if (nemesis == 2 && foe == 1) {
              NNF++;
            } else if (nemesis == 2 && foe == 2) {
              NNFF++;
            } else if (nemesis == 3 && foe == 1) {
              NNNF++;
            } else if (nemesis == 3 && foe == 2) {
              NNNFF++;
            } else if (nemesis == 4 && foe == 1) {
              NNNNF++;
            } else if (nemesis == 4 && foe == 2) {
              NNNNFF++;
            }
          }
          nemesis = 0;
          foe = 0;
        }
      }
      print(
          "\n \t \t За 100 повторень: \n \t По турам: \n Послідовних кроків Nemesis Foe або Foe Nemesis = $turnNF");
      print("Немезис ходить підряд по 2 рази = $turnNN");
      print(
          "В різних комбінаціях послідовних кроків Nemesis Nemesis Foe = $turnNNF ");
      print(
          "\t Якщо вистроїти всі тури підряд (для перевірки 3 кроків немезіса підряд і т.і.): ");
      print("Nemesis Foe = $NF");
      print("Nemesis Nemesis = $NN");
      print("Nemesis Nemesis Foe різні комбінації: $NNF");
      print("Nemesis Nemesis Foe Foe в різних комбінаціях: $NNFF");
      print("Nemesis Nemesis Nemesis: $NNN");
      print("Nemesis Nemesis Nemesis Foe в різних комбінаціях: $NNNF");
      print("Nemesis Nemesis Nemesis Foe Foe в різних комбінаціях: $NNNFF");
      print("Nemesis Nemesis Nemesis Nemesis: $NNNN");
      print("Nemesis Nemesis Nemesis Nemesis Foe в різних комбінаціях: $NNNNF");
      print(
          "Nemesis Nemesis Nemesis Nemesis Foe Foe в різних комбінаціях: $NNNNFF");*/

      print("TurnOrderBodyBloc _onInit stacks.length == ${stacks.length} \n");
    } else {
      print(
          "TurnOrderBodyBloc _onInit stacks.isNotEmpty \n stacks.length == ${stacks.length} \n alreadyPlayed.length == ${alreadyPlayed.length}");
    }
    alreadyPlayedCheck();

    emit(TurnOrderBodySuccessActionState(
        stacks.first,
        alreadyPlayed.firstWhere((element) => element.id == stacks.first.id,
            orElse: () => stacks.first.copyWith(cards: [])),
        stacks,
        linksKeys));
  }

  void _onNext(
      TurnOrderBodyNextEvent event, Emitter<TurnOrderBodyState> emit) async {
    // Handle the next event
    var curentStack = stacks.firstWhere((element) => element.id == event.id,
        orElse: () => const CardsStack.empty());
    var newAlreadyPlayed = alreadyPlayed.firstWhere(
        (element) => element.id == event.id,
        orElse: () => const CardsStack.empty());

    if (curentStack.id == 0 || curentStack.cards.isEmpty) {
      print("TOBB: _onNext: cS.id == 0 || cS.cards.isEmpty");
      curentStack = await db.getStackById(event.id);

      if (newAlreadyPlayed.id == 0) {
        newAlreadyPlayed = curentStack.copyWith(cards: []);
      }
      curentStack.cards.shuffle();
    } else {
      if (newAlreadyPlayed.id == 0) {
        newAlreadyPlayed = curentStack.copyWith(cards: []);
      }
      newAlreadyPlayed.cards.insert(0, curentStack.cards.last);
      curentStack.cards.removeLast();

      // Creating story to statistic
      if (newAlreadyPlayed.cards.length > 1) {
        data.addCardToStory(newAlreadyPlayed.cards.first, false);
      } else {
        data.addCardToStory(newAlreadyPlayed.cards.first, true);
      }
    }

    bool curentStackIsNew = true;
    bool alreadyPlayedIsNew = true;
    for (var i = 0; i < stacks.length; i++) {
      if (stacks[i].id == curentStack.id) {
        stacks[i] = curentStack;
        curentStackIsNew = false;
        break;
      }
      if (alreadyPlayed[i].id == curentStack.id) {
        alreadyPlayed[i] = curentStack;
        alreadyPlayedIsNew = false;
        break;
      }
    }
    if (curentStackIsNew) {
      stacks.add(curentStack);
    }
    if (alreadyPlayedIsNew) {
      alreadyPlayed.add(newAlreadyPlayed);
    }

    emit(TurnOrderBodySuccessActionState(
        curentStack.copyWith(cards: curentStack.cards),
        newAlreadyPlayed.copyWith(cards: newAlreadyPlayed.cards),
        List.from(stacks),
        linksKeys));
  }

  _onDiscard(
      TurnOrderBodyDiscardEvent event, Emitter<TurnOrderBodyState> emit) {
    print("TurnOrderBodyBloc _onDiscard event.name == ${event.name} \n");
    print("TurnOrderBodyBloc _onDiscard event.list == ${event.list} \n");
    print(
        "TurnOrderBodyBloc _onDiscard event.isDiscard == ${event.isDiscard} \n");

    String link = "";
    var curentStack = stacks.firstWhere(
        (element) => element.id == event.stackId,
        orElse: () => const CardsStack.empty());
    var newAlreadyPlayed = alreadyPlayed.firstWhere(
      (element) => element.id == event.stackId,
      orElse: () => const CardsStack.empty(),
    );
    if (curentStack.id == 0) {
      link = linksKeys.firstWhere((element) => element == event.name,
          orElse: () => "");
    }

    if (event.isDiscard) {
      List<AECard> newAlreadyCards = [];

      for (var i = 0; i < curentStack.cards.length; i++) {
        if (event.list.contains(curentStack.cards[i].name)) {
          newAlreadyCards.add(curentStack.cards[i]);
          curentStack.cards.removeAt(i);
          i--; // Adjust index after removal
        }
      }
      for (var i = 0; i < stacks.length; i++) {
        if (stacks[i].name == event.name) {
          stacks[i] = curentStack;
          break;
        }
      }
      var discardedEarlier = alreadyPlayed.firstWhere(
          (element) => element.name == event.name,
          orElse: () => const CardsStack.empty());
      if (discardedEarlier.id != 0) {
        newAlreadyCards.addAll(discardedEarlier.cards);
        for (var i = 0; i < alreadyPlayed.length; i++) {
          if (alreadyPlayed[i].name == event.name) {
            alreadyPlayed[i] =
                discardedEarlier.copyWith(cards: newAlreadyCards);
            newAlreadyPlayed = alreadyPlayed[i];
            break;
          }
        }
      } else {
        alreadyPlayed.add(curentStack.copyWith(cards: newAlreadyCards));
        newAlreadyPlayed = alreadyPlayed.last;
      }
    } else {
      var idToLink =
          stacks.firstWhere((element) => element.name == event.list.first).id;
      if (link != "") {
        links[link] = idToLink;
      } else {
        links.addAll({event.name: idToLink});
      }
      print("_onDiscard isDiscard == false: links == $links");
    }

    // Here you can implement the logic for linking or discarding based on the event data
    // For example, you might want to update the stack or alreadyPlayed based on the event

    // After processing, emit a new state if necessary

    emit(TurnOrderBodySuccessActionState(
        curentStack.copyWith(cards: curentStack.cards),
        newAlreadyPlayed.copyWith(cards: newAlreadyPlayed.cards),
        List.from(stacks),
        linksKeys));
  }

  void _onShuffle(
      TurnOrderBodyShuffleEvent event, Emitter<TurnOrderBodyState> emit) async {
    var curentStack = await db.getStackById(event.stackId);
    curentStack.cards.shuffle();
    var curentAP = curentStack.copyWith(cards: []);

    _saveStacksAndAP(curentStack.id, curentStack.cards, curentAP.cards);

    emit(TurnOrderBodySuccessActionState(
        curentStack, curentAP, List.from(stacks), linksKeys));
  }

  void _onShuffleIn(TurnOrderBodyShuffleInStackEvent event,
      Emitter<TurnOrderBodyState> emit) {
    AECard card = AECard(id: 0, text: "", name: "");
    var curentStack = stacks.firstWhere(
        (element) => element.id == event.stackId,
        orElse: () => const CardsStack.empty());
    var curentAP = alreadyPlayed.firstWhere(
        (element) => element.id == event.stackId,
        orElse: () => const CardsStack.empty());

    for (var i = 0; i < curentAP.cards.length; i++) {
      if (curentAP.cards[i].name == event.text) {
        card = curentAP.cards[i];
        curentAP.cards.removeAt(i);
        curentStack.cards.add(card);
        curentStack.cards.shuffle();
        break;
      }
    }
    _saveStacksAndAP(curentStack.id, curentStack.cards, curentAP.cards);

    emit(TurnOrderBodySuccessActionState(
        curentStack, curentAP, List.from(stacks), linksKeys));
  }

  _onPutInTheButtom(
      TurnOrderBodyPutInButtom event, Emitter<TurnOrderBodyState> emit) {
    print("TurnOrderBodyBloc _onPutInTheButtom event.text == ${event.text} \n");
    AECard card = AECard(id: 0, text: "", name: "");
    var curentStack = stacks.firstWhere(
        (element) => element.id == event.stackId,
        orElse: () => const CardsStack.empty());
    var curentAP = alreadyPlayed.firstWhere(
        (element) => element.id == event.stackId,
        orElse: () => const CardsStack.empty());

    for (var i = 0; i < curentAP.cards.length; i++) {
      if (curentAP.cards[i].text == event.text) {
        print(
            "TurnOrderBodyBloc _onPutInTheButtom found card to put in the buttom: ${curentAP.cards[i]} \n");
        card = curentAP.cards[i];
        curentAP.cards.removeAt(i);
        curentStack.cards.insert(0, card);
        break;
      }
    }
    _saveStacksAndAP(curentStack.id, curentStack.cards, curentAP.cards);

    emit(TurnOrderBodySuccessActionState(
        curentStack, curentAP, List.from(stacks), linksKeys));
  }

  void _onChangeSequence(TurnOrderBodyChangeSequenceEvent event,
      Emitter<TurnOrderBodyState> emit) {
    print("TOBB _onChangeSeq: list == ${event.list}");
    var newCardsList = event.list;
    var stackIndex =
        stacks.indexWhere((element) => element.id == event.stackId);
    if (stackIndex != -1) {
      stacks[stackIndex] = stacks[stackIndex].copyWith(cards: newCardsList);
    }

    emit(TurnOrderBodySuccessActionState(
        stacks[stackIndex].copyWith(cards: newCardsList),
        alreadyPlayed.firstWhere(
          (element) => element.id == stacks[stackIndex].id,
          orElse: () => stacks[stackIndex].copyWith(cards: []),
        ),
        List.from(stacks),
        linksKeys));
  }

  void _onChangeActiveStack(TurnOrderBodyChangeActiveStackEvent event,
      Emitter<TurnOrderBodyState> emit) async {
    //emit(const TurnOrderBodyClearScreenState());
    print(
        "TurnOrderBodyBlock. _onChangeActiveStack. event.stackId == ${event.stackId} \n");
    var newStack = stacks.firstWhere((element) => element.id == event.stackId,
        orElse: () => const CardsStack.empty());
    var newAlreadyPlayed = alreadyPlayed.firstWhere(
        (element) => element.id == event.stackId,
        orElse: () => const CardsStack.empty());

    if (newStack.id != 0 && newAlreadyPlayed.id != 0) {
      emit(TurnOrderBodySuccessActionState(
          newStack, newAlreadyPlayed, List.from(stacks), linksKeys));
      return;
    } else if (newStack.id != 0 && newAlreadyPlayed.id == 0) {
      alreadyPlayed.add(newStack.copyWith(cards: []));
      newAlreadyPlayed = alreadyPlayed.last;
    } else if (newStack.id == 0 && newAlreadyPlayed.id != 0) {
      newStack = await db.getStackById(event.stackId);
      if (newStack.id != 0) {
        newStack.cards.shuffle();
        stacks.add(newStack);
      }
      for (var i = 0; i < alreadyPlayed.length; i++) {
        if (alreadyPlayed[i].id == event.stackId) {
          alreadyPlayed[i] = newAlreadyPlayed.copyWith(cards: []);
          break;
        }
      }
    } else {
      newStack = await db.getStackById(event.stackId);
      if (newStack.id != 0) {
        newStack.cards.shuffle();
        stacks.add(newStack);
        alreadyPlayed.add(newStack.copyWith(cards: []));
        newAlreadyPlayed = alreadyPlayed.last;
      }
    }
    emit(TurnOrderBodySuccessActionState(
        newStack, newAlreadyPlayed, List.from(stacks), linksKeys));
  }

  // void _onClearStack(TurnOrderBodyClearStackEvent event,
  //     Emitter<TurnOrderBodyState> emit) async {
  //   var curentStack = stacks.firstWhere((element) => element.id == event.id,
  //       orElse: () => const CardsStack.empty());
  //   var curentAP = alreadyPlayed.firstWhere((element) => element.id == event.id,
  //       orElse: () => const CardsStack.empty());

  //   if (curentStack.id != 0) {
  //     curentStack = curentStack.copyWith(cards: []);
  //     for (var i = 0; i < stacks.length; i++) {
  //       if (stacks[i].id == event.id) {
  //         stacks[i] = curentStack;
  //         break;
  //       }
  //     }
  //   }
  //   if (curentAP.id != 0) {
  //     curentAP = curentAP.copyWith(cards: []);
  //     for (var i = 0; i < alreadyPlayed.length; i++) {
  //       if (alreadyPlayed[i].id == event.id) {
  //         alreadyPlayed[i] = curentAP;
  //         break;
  //       }
  //     }
  //   }

  //   emit(TurnOrderBodySuccessActionState(curentStack,
  //       curentAP)); // Is here need to be  curentAP.copyWith(cards: curentAP.cards) or just curentAP.copyWith()?
  //   // I think it is the same, but need to check
  // }

  _saveStacksAndAP(int stackId, List<AECard> stackCards, List<AECard> apCards) {
    var stackIndex = stacks.indexWhere((element) => element.id == stackId);
    stacks[stackIndex] = stacks[stackIndex].copyWith(cards: stackCards);
    var apIndex = alreadyPlayed.indexWhere((element) => element.id == stackId);
    alreadyPlayed[apIndex] = alreadyPlayed[apIndex].copyWith(cards: apCards);
  }
}
