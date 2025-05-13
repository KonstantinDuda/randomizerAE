import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_state/friend_foe_body_es.dart';
import '../database/cards_stack.dart';
import '../database/db_temporary.dart';

class FriendFoeBodyBloc extends Bloc<FriendFoeBodyEvent, FriendFoeBodyState> {
  late CardsStack stack = const CardsStack.empty();
  late CardsStack alreadyPlayed = const CardsStack.empty();
  final database = DbTemporary();
  
  FriendFoeBodyBloc() : super(const FriendFoeBodySuccessActionState()) {
    on<FriendFoeBodyNextEvent>(_onNext);
    on<FriendFoeChangeActiveStackEvent>(_onChangeActiveStack);
  }
  
  _onNext(FriendFoeBodyNextEvent event, Emitter<FriendFoeBodyState> emit) {
    // Handle the next event

    if(stack.id == 0 || stack.cards.isEmpty) {
      stack = database.getActiveStack();
      if(alreadyPlayed.id != 0) {
        alreadyPlayed = const CardsStack.empty();
      }
      stack.cards.shuffle();
      print("FriendFoeBodyBloc _onNext stack.id == 0 stack.cards == ${stack.cards} \n");
    } else {
      if(alreadyPlayed.id == 0) {
        alreadyPlayed = CardsStack(
          id: stack.id,
          name: stack.name,
          isActive: false,
          stackType: StackType.friendFoe,
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
      stackType: StackType.friendFoe,
      stackColor: stack.stackColor,
      cards: stack.cards,
    );      

    var newAlreadyPlayed = CardsStack(
      id: -2,
      name: alreadyPlayed.name,
      isActive: alreadyPlayed.isActive,
      stackType: StackType.friendFoe,
      stackColor: alreadyPlayed.stackColor,
      cards: alreadyPlayed.cards,
    );

    emit(FriendFoeBodySuccessActionState(newStack, newAlreadyPlayed));

  }

  _onChangeActiveStack(FriendFoeChangeActiveStackEvent event, Emitter<FriendFoeBodyState> emit) {
    // Handle the change active stack event
    stack = database.getStackById(event.id);
    alreadyPlayed = const CardsStack.empty();
    emit(FriendFoeBodySuccessActionState(stack, alreadyPlayed));
  }
}