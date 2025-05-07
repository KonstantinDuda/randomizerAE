import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_state/turn_order_body_es.dart';
import '../database/cards_stack.dart';
import '../database/db_temporary.dart';

class TurnOrderBodyBloc extends Bloc<TurnOrderBodyEvent, TurnOrderBodyState> {
  late CardsStack stack = const CardsStack.empty();
  late CardsStack alreadyPlayed = const CardsStack.empty();
  final database = DbTemporary();
  
  TurnOrderBodyBloc() : super(const TurnOrderBodySuccessActionState()) {
    on<TurnOrderBodyNextEvent>(_onNext);
    on<TurnOrderBodyDelWildEvent>(_onDelWild);
    on<TurnOrderBodyShuffleEvent>(_onShuffle);
    on<TurnOrderBodyChangeSequenceEvent>(_onChangeSequence);
    on<TurnOrderBodyChangeActiveStackEvent>(_onChangeActiveStack);
    on<TurnOrderBodyChangeAvailableStackListEvent>(_onChangeAvailableList);
  }

  void _onNext(TurnOrderBodyNextEvent event, Emitter<TurnOrderBodyState> emit) {
    // Handle the next event

    if(stack.id == 0 || stack.cards.isEmpty) {
      stack = database.getActiveStack();
      if(alreadyPlayed.id != 0) {
        alreadyPlayed = const CardsStack.empty();
      }
      stack.cards.shuffle();
      print("TurnOrderBodyBloc _onNext stack.id == 0 stack.cards == ${stack.cards} \n");
      //emit(TurnOrderBodySuccessActionState(stack, alreadyPlayed));
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
    );      // Something is wrong here

    var newAlreadyPlayed = CardsStack(
      id: -2,
      name: alreadyPlayed.name,
      isActive: alreadyPlayed.isActive,
      stackType: StackType.turnOrder,
      stackColor: alreadyPlayed.stackColor,
      cards: alreadyPlayed.cards,
    );       // Something is wrong here


    print("TurnOrderBodyBloc _onNext stack.id != 0 stack == $stack \n "
                                  "stack.cards == ${stack.cards} \n");
    print("TurnOrderBodyBloc _onNext alreadyPlayed.cards == ${alreadyPlayed.cards} \n");
      
    emit(TurnOrderBodySuccessActionState(newStack, newAlreadyPlayed));

  }

  void _onDelWild(TurnOrderBodyDelWildEvent event, Emitter<TurnOrderBodyState> emit) {
    // Handle the delete wild event


    emit(TurnOrderBodySuccessActionState(stack, alreadyPlayed));
  }

  void _onShuffle(TurnOrderBodyShuffleEvent event, Emitter<TurnOrderBodyState> emit) {
    // Handle the shuffle event
    final database = DbTemporary();

    if(stack.cards.isEmpty) {
      stack = database.getActiveStack();
      stack.cards.shuffle();
    emit(TurnOrderBodySuccessActionState(stack, alreadyPlayed));
  }
  }

  void _onChangeSequence(TurnOrderBodyChangeSequenceEvent event, 
                              Emitter<TurnOrderBodyState> emit) {
    // Handle the change sequence event


    emit(TurnOrderBodySuccessActionState(stack, alreadyPlayed));
  }

  void _onChangeActiveStack(TurnOrderBodyChangeActiveStackEvent  event, 
                                      Emitter<TurnOrderBodyState> emit) {
    emit(const TurnOrderBodyClearScreenState());
    var newAlreadyPlayed = const CardsStack.empty();
    database.setActiveStack(event.id);
    var newStack = database.getActiveStack();
    print("TurnOrderBodyBlock. _onChangeActiveStack. "
          "newAlreadyPlayed.cards == ${newAlreadyPlayed.cards} \n "
          "newStack.cards == ${newStack.cards}");
    
    emit(TurnOrderBodySuccessActionState(newStack, newAlreadyPlayed));
  }

  void _onChangeAvailableList(TurnOrderBodyChangeAvailableStackListEvent event, 
                                              Emitter<TurnOrderBodyState> emit) {
    database.updateAvialableStack(event.id);


    emit(const TurnOrderBodySuccessActionState());
  }
}