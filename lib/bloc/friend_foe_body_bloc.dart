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
    on<FriendFoeBodyInitialEvent>(_onInit);
    on<FriendFoeBodyNextEvent>(_onNext);
    on<FriendFoeChangeActiveStackEvent>(_onChangeActiveStack);
  }

  _onInit(FriendFoeBodyInitialEvent event, Emitter<FriendFoeBodyState> emit) {
    // Handle the initial event
    print("FriendFoeBodyBloc _onInit event.heroId == ${event.heroId} \n");
    friendStack = database.getActiveFriendStack();
    print("FriendFoeBodyBloc _onInit friendStack.cards == ${friendStack.cards} \n");
    if(friendStack.id != 0 && friendStack.cards.isNotEmpty) {
      print("FriendFoeBodyBloc _onInit friendStack.id != 0 && friendStack.cards.isNotEmpty \n");
    friendAlreadyPlayed = CardsStack(
      id: friendStack.id,
      name: friendStack.name,
      isActive: true,
      stackType: StackType.friendFoe,
      stackColor: friendStack.stackColor,
        cards: [],
      );
      friendStack.cards.shuffle();
    } else {
      database.setActiveFriendStack(friendStack.id);
      friendStack = database.getActiveFriendStack();
      friendStack.cards.shuffle();
      print("FriendFoeBodyBloc _onInit friend ELSE friendStack.cards == ${friendStack.cards} \n");
    }
    foeStack = database.getActiveFoeStack();
    if(foeStack.id != 0 && foeStack.cards.isNotEmpty) {
    foeAlreadyPlayed = CardsStack(
      id: foeStack.id,
      name: foeStack.name,
      isActive: true,
      stackType: StackType.friendFoe,
      stackColor: foeStack.stackColor,
      cards: [],
    );
    foeStack.cards.shuffle();
    } else {
      database.setActiveFoeStack(foeStack.id);
      foeStack = database.getActiveFoeStack();
      foeStack.cards.shuffle();
      print("FriendFoeBodyBloc _onInit foe ELSE foeStack.cards == ${foeStack.cards} \n");
    }
    
    
    var stack = const CardsStack.empty();
    var alreadyPlayed = const CardsStack.empty();
    var hero = database.getHeroById(event.heroId);
    print("FriendFoeBodyBloc _onInit HeroStack == $hero \n");
    if(hero.id != 0) {
    if(hero.heroStacks[0].id  == friendStack.id) {
      stack = friendStack;
      alreadyPlayed = friendAlreadyPlayed;
    } else if (hero.heroStacks[0].id == foeStack.id) {
      stack = foeStack;
      alreadyPlayed = foeAlreadyPlayed;
    } else {
      print(
          "FriendFoeBodyBloc _onInit event.heroId != 0 != friendStack.id != foeStack.id \n");
    }
      //stack.cards.shuffle();
    }
    
    emit(FriendFoeBodySuccessActionState(stack, alreadyPlayed));
  }

  _onNext(FriendFoeBodyNextEvent event, Emitter<FriendFoeBodyState> emit) {
    // Handle the next event

    var newStack = CardsStack.empty();
    var newAlreadyPlayed = CardsStack.empty();

    if (friendStack.id == 0 || friendStack.cards.isEmpty) {
      //print(
    //      "FriendFoeBodyBloc _onNext friendStack.id == 0 || friendStack.cards.isEmpty \n");
      friendStack = database.getActiveFriendStack();
  //    print(
//          "FriendFoeBodyBloc _onNext friendStack == $friendStack \n");
      friendAlreadyPlayed = CardsStack(
        id: friendStack.id,
        name: friendStack.name,
        isActive: true,
        stackType: StackType.friendFoe,
        stackColor: friendStack.stackColor,
        cards: [],
      );
      friendStack.cards.shuffle();
    }
    if (foeStack.id == 0 || foeStack.cards.isEmpty) {
      //print(
        //  "FriendFoeBodyBloc _onNext foeStack.id == 0 || foeStack.cards.isEmpty \n");
      foeStack = database.getActiveFoeStack();
      foeAlreadyPlayed = CardsStack(
        id: foeStack.id,
        name: foeStack.name,
        isActive: true,
        stackType: StackType.friendFoe,
        stackColor: foeStack.stackColor,
        cards: [],
      );  
      foeStack.cards.shuffle();
    }

    print("FriendFoeBodyBloc _onNext event.heroId == ${event.heroId} \n");
    var hero = database.getHeroById(event.heroId);
    print("FriendFoeBodyBloc _onNext hero == $hero \n");
    if (hero.id != 0) {
      if(hero.heroStacks[0].id == friendStack.id) {
        print("FriendFoeBodyBloc _onNext event.heroId == friendStack.id \n");
        friendAlreadyPlayed.cards.add(friendStack.cards.last);
        friendStack.cards.removeLast();
        newStack = friendStack;
        newAlreadyPlayed = friendAlreadyPlayed;
      } else if (hero.heroStacks[0].id == foeStack.id) {
        print("FriendFoeBodyBloc _onNext event.heroId == foeStack.id \n");
        foeAlreadyPlayed.cards.add(foeStack.cards.last);
        foeStack.cards.removeLast();
        newStack = foeStack;
        newAlreadyPlayed = foeAlreadyPlayed;
      } else {
        print(
            "FriendFoeBodyBloc _onNext event.heroId != 0 != friendStack.id != foeStack.id \n");
      }
    } else {
      print("FriendFoeBodyBloc _onNext localHero.id == 0 \n");
    }

    print("FriendFoeBodyBloc _onNext event.heroId == ${event.heroId} \n"
        "newStack == $newStack \n alreadyPlayed == $newAlreadyPlayed \n");

    emit(FriendFoeBodySuccessActionState(newStack, newAlreadyPlayed));
  }

  _onChangeActiveStack(
      FriendFoeChangeActiveStackEvent event, Emitter<FriendFoeBodyState> emit) {
    // Handle the change active stack event
    var stack = database.getStackById(event.id);
    var alreadyPlayed = const CardsStack.empty();
    emit(FriendFoeBodySuccessActionState(stack, alreadyPlayed));
  }
}
