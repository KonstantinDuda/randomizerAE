import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_state/friend_foe_body_es.dart';
import '../database/cards_stack.dart';
import '../database/db_temporary.dart';

class FriendFoeBodyBloc extends Bloc<FriendFoeBodyEvent, FriendFoeBodyState> {
  late CardsStack foeStack = const CardsStack.empty();
  late CardsStack foeAlreadyPlayed = const CardsStack.empty();
  late CardsStack friendStack = const CardsStack.empty();
  late CardsStack friendAlreadyPlayed = const CardsStack.empty();
  final database = DbTemporary();
  
  FriendFoeBodyBloc() : super(const FriendFoeBodySuccessActionState()) {
    on<FriendFoeBodyNextEvent>(_onNext);
    on<FriendFoeChangeActiveStackEvent>(_onChangeActiveStack);
  }
  
  _onNext(FriendFoeBodyNextEvent event, Emitter<FriendFoeBodyState> emit) {
    // Handle the next event

    var newStack = CardsStack.empty();
    var newAlreadyPlayed = CardsStack.empty();

    if(event.heroId == 0) {
      print("FriendFoeBodyBloc _onNext event.heroId == 0 \n");
      foeStack = database.getActiveFoeStack();
      foeAlreadyPlayed = foeStack;
      foeAlreadyPlayed.cards.clear();
      foeStack.cards.shuffle();

      friendStack = database.getActiveFriendStack();
      friendAlreadyPlayed = friendStack;
      friendAlreadyPlayed.cards.clear();
      friendStack.cards.shuffle();
    } else {
      if(event.heroId == friendStack.id) {
        print("FriendFoeBodyBloc _onNext event.heroId == friendStack.id \n");
        friendAlreadyPlayed.cards.add(friendStack.cards.last);
        friendStack.cards.removeLast();
        newStack = friendStack;
        newAlreadyPlayed = friendAlreadyPlayed;
      } else if(event.heroId == foeStack.id) {
        print("FriendFoeBodyBloc _onNext event.heroId == friendStack.id \n");
        foeAlreadyPlayed.cards.add(foeStack.cards.last);
        foeStack.cards.removeLast();
        newStack = foeStack;
        newAlreadyPlayed = foeAlreadyPlayed;
      }
    }

    print("FriendFoeBodyBloc _onNext event.heroId == ${event.heroId} \n" 
          "newStack == $newStack \n alreadyPlayed == $newAlreadyPlayed \n");

    emit(FriendFoeBodySuccessActionState(newStack, newAlreadyPlayed));
  }

  _onChangeActiveStack(FriendFoeChangeActiveStackEvent event, Emitter<FriendFoeBodyState> emit) {
    // Handle the change active stack event
    var stack = database.getStackById(event.id);
    var alreadyPlayed = const CardsStack.empty();
    emit(FriendFoeBodySuccessActionState(stack, alreadyPlayed));
  }
}