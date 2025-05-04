import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/event_state/root_body_es.dart';
import '../database/cards_stack.dart';
import '../database/db_temporary.dart';

class RootBodyBloc extends Bloc<RootBodyEvent, RootBodyState> {
  late CardsStack stack = const CardsStack.empty();
  late CardsStack alreadyPlayed = const CardsStack.empty();
  final database = DbTemporary();
  
  RootBodyBloc() : super(const RootBodySuccessActionState()) {
    on<RootBodyNextEvent>(_onNext);
    on<RootBodyDelWildEvent>(_onDelWild);
    on<RootBodyShuffleEvent>(_onShuffle);
    on<RootBodyChangeSequenceEvent>(_onChangeSequence);
    on<RootBodyChangeActiveStackEvent>(_onChangeActiveStack);
  }

  void _onNext(RootBodyNextEvent event, Emitter<RootBodyState> emit) {
    // Handle the next event

    if(stack.id == 0 || stack.cards.isEmpty) {
      stack = database.getActiveStack();
      if(alreadyPlayed.id != 0) {
        alreadyPlayed = const CardsStack.empty();
      }
      stack.cards.shuffle();
      print("RootBodyBloc _onNext stack.id == 0 stack.cards == ${stack.cards} \n");
      //emit(RootBodySuccessActionState(stack, alreadyPlayed));
    } else {
      if(alreadyPlayed.id == 0) {
        alreadyPlayed = CardsStack(
          id: stack.id,
          name: stack.name,
          isStandart: false,
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
      isStandart: stack.isStandart,
      stackType: StackType.turnOrder,
      stackColor: stack.stackColor,
      cards: stack.cards,
    );      // Something is wrong here

    var newAlreadyPlayed = CardsStack(
      id: -2,
      name: alreadyPlayed.name,
      isStandart: alreadyPlayed.isStandart,
      stackType: StackType.turnOrder,
      stackColor: alreadyPlayed.stackColor,
      cards: alreadyPlayed.cards,
    );       // Something is wrong here


    print("RootBodyBloc _onNext stack.id != 0 stack == $stack \n "
                                  "stack.cards == ${stack.cards} \n");
    //print("RootBodyBloc _onNext database.getActiveStack().cards "
      //                      "== ${database.getActiveStack().cards} \n");
    //print("RootBodyBloc _onNext getStackById "
      //                      "== ${database.getStackById(stack.id).cards} \n");

    print("RootBodyBloc _onNext alreadyPlayed.cards == ${alreadyPlayed.cards} \n");
      
    emit(RootBodySuccessActionState(newStack, newAlreadyPlayed));

  }

  void _onDelWild(RootBodyDelWildEvent event, Emitter<RootBodyState> emit) {
    // Handle the delete wild event


    emit(RootBodySuccessActionState(stack, alreadyPlayed));
  }

  void _onShuffle(RootBodyShuffleEvent event, Emitter<RootBodyState> emit) {
    // Handle the shuffle event
    final database = DbTemporary();

    if(stack.cards.isEmpty) {
      stack = database.getActiveStack();
      stack.cards.shuffle();
    emit(RootBodySuccessActionState(stack, alreadyPlayed));
  }
  }

  void _onChangeSequence(RootBodyChangeSequenceEvent event, Emitter<RootBodyState> emit) {
    // Handle the change sequence event


    emit(RootBodySuccessActionState(stack, alreadyPlayed));
  }

  void _onChangeActiveStack(RootBodyChangeActiveStackEvent  event, Emitter<RootBodyState> emit) {
    emit(const RootBodyClearScreenState());
    var newAlreadyPlayed = const CardsStack.empty();
    database.setActiveStack(event.id);
    var newStack = database.getActiveStack();
    print("RootBodyBlock. _onChangeActiveStack. "
          "newAlredyPlayed.cards == ${newAlreadyPlayed.cards} \n "
          "newStack.cards == ${newStack.cards}");
    
    emit(RootBodySuccessActionState(newStack, newAlreadyPlayed));
  }
}