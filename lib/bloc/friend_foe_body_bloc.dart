//import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/db_provider.dart';
import '../database/default_data.dart';
import 'event_state/friend_foe_body_es.dart';
import '../database/cards_stack.dart';

class FriendFoeBodyBloc extends Bloc<FriendFoeBodyEvent, FriendFoeBodyState> {
  late CardsStack foeAlreadyPlayed = const CardsStack.empty();
  late CardsStack friendAlreadyPlayed = const CardsStack.empty();
  var defaultData = DefaultData();
  final db = DBProvider();

  late HeroStack friend = const HeroStack.empty();
  late HeroStack foe = const HeroStack.empty();

  FriendFoeBodyBloc() : super(const FriendFoeBodySuccessActionState()) {
    on<FriendFoeBodyInitialEvent>(_onInit);
    on<FriendFoeBodyNextEvent>(_onNext);
    on<FriendFoeChangeActiveStackEvent>(_onChangeActiveStack);
  }

  _onInit(
      FriendFoeBodyInitialEvent event, Emitter<FriendFoeBodyState> emit) async {
    // Friend Initialisation
    print("FriendFoeBodyBloc _onInit event.stackId == ${event.stackId} \n");

    var heroToReturn = const HeroStack.empty();
    var stackToReturn = const CardsStack.empty();

    var allHeroes = await defaultData.getHeroes();

    if (friend.id == 0) {
      print("FriendFoeBodyBloc _onInit friend.id == 0 \n");
      for (var element in allHeroes) {
        print("element == $element");
        if (element.heroStack.id == 0) {
          if (element.heroStack.cards.isNotEmpty) {
            if (element.heroStack.isActive && element.isFriend) {
              friend = element;
            }
          } else {
            if (element.heroStack.isActive && element.isFriend) {
              var stack = await db.getStackById(element.heroStack.id);
              stack.cards.shuffle();
              friend = HeroStack(
                  id: element.id,
                  name: element.name,
                  isFriend: element.isFriend,
                  heroStack: stack,
                  energyClosetCount: element.energyClosetCount,
                  ability: element.ability);
            }
          }
          friendAlreadyPlayed = CardsStack(
              id: element.heroStack.id,
              name: element.heroStack.name,
              isActive: element.heroStack.isActive,
              stackType: element.heroStack.stackType,
              stackColor: element.heroStack.stackColor,
              cards: []);
        }
      }
    }

    if (foe.id == 0) {
      print("FriendFoeBodyBloc _onInit foe.id == 0 \n");
      for (var element in allHeroes) {
        if (element.heroStack.id == 0) {
          if (element.heroStack.cards.isNotEmpty) {
            if (element.heroStack.isActive && !element.isFriend) {
              foe = element;
            }
          } else {
            if (element.heroStack.isActive && !element.isFriend) {
              var stack = await db.getStackById(element.heroStack.id);
              stack.cards.shuffle();
              foe = HeroStack(
                  id: element.id,
                  name: element.name,
                  isFriend: element.isFriend,
                  heroStack: stack,
                  energyClosetCount: element.energyClosetCount,
                  ability: element.ability);
            }
          }
          foeAlreadyPlayed = CardsStack(
              id: element.heroStack.id,
              name: element.heroStack.name,
              isActive: element.heroStack.isActive,
              stackType: element.heroStack.stackType,
              stackColor: element.heroStack.stackColor,
              cards: []);
        }
      }
    }

    // Friend and Foe ids != 0
    if (friend.heroStack.id != 0) {
      print("FriendFoeBodyBloc _onInit friend.heroStack.id == 0 \n");
      if (friend.heroStack.id == event.stackId &&
          friend.heroStack.cards.isNotEmpty) {
        print("FriendFoeBodyBloc _onInit friend.heroStack.id == event.stackId && friend.heroStack.cards.isNotEmpty");
        heroToReturn = friend;
        stackToReturn = friendAlreadyPlayed;
      } else if (friend.heroStack.id == event.stackId) {
        print("FriendFoeBodyBloc _onInit friend.heroStack.id == event.stackId");
        var stack = await db.getStackById(friend.heroStack.id);
        stack.cards.shuffle();
        // var supportStack = const CardsStack.empty();
        if (friend.heroStack.id > 0) {
          // supportStack = friend.heroStacks[1];
          heroToReturn = HeroStack(
              id: friend.id,
              name: friend.name,
              isFriend: true,
              heroStack: stack, //[stack, supportStack],
              energyClosetCount: friend.energyClosetCount,
              ability: friend.ability);
        } else {
          heroToReturn = HeroStack(
              id: friend.id,
              name: friend.name,
              isFriend: true,
              heroStack: stack,
              energyClosetCount: friend.energyClosetCount,
              ability: friend.ability);
        }
        friend = heroToReturn;
        friendAlreadyPlayed = CardsStack(
            id: friend.heroStack.id,
            name: friend.heroStack.name,
            isActive: friend.heroStack.isActive,
            stackType: friend.heroStack.stackType,
            stackColor: friend.heroStack.stackColor,
            cards: []);
        print("FriendFoeBodyBloc _onInit friend.heroStack.id == $friend");
      } else {
        print("FriendFoeBodyBloc _onInit friend.heroStack.id != 0 \n "
            "\t friend.heroStack.id != event.stackId");
      }
    }

    if (foe.heroStack.id != 0) {
      print("FriendFoeBodyBloc _onInit foe.heroStack.id != 0 \n");
      if (foe.heroStack.id == event.stackId &&
          foe.heroStack.cards.isNotEmpty) {
        heroToReturn = foe;
        stackToReturn = foeAlreadyPlayed;
      } else if (foe.heroStack.id == event.stackId) {
        var stack = await db.getStackById(foe.heroStack.id);
        stack.cards.shuffle();
        //var supportStack = const CardsStack.empty();
        if (foe.heroStack.id > 0) {
          //supportStack = foe.heroStacks[1];
          heroToReturn = HeroStack(
              id: foe.id,
              name: foe.name,
              isFriend: true,
              heroStack: stack, // [stack, supportStack],
              energyClosetCount: foe.energyClosetCount,
              ability: foe.ability);
        } else {
          heroToReturn = HeroStack(
              id: foe.id,
              name: foe.name,
              isFriend: true,
              heroStack: stack,
              energyClosetCount: foe.energyClosetCount,
              ability: foe.ability);
        }
        foe = heroToReturn;
        foeAlreadyPlayed = CardsStack(
            id: foe.heroStack.id,
            name: foe.heroStack.name,
            isActive: foe.heroStack.isActive,
            stackType: foe.heroStack.stackType,
            stackColor: foe.heroStack.stackColor,
            cards: []);
      }
    }

    print("FriendFoeBodyBloc friend == $friend \n \t foe == $foe");
    print("FriendFoeBodyBloc heroToReturn == $heroToReturn \n"
        "\t stackToReturn == $stackToReturn");

    emit(FriendFoeBodySuccessActionState(heroToReturn, stackToReturn));
  }

  _onNext(
      FriendFoeBodyNextEvent event, Emitter<FriendFoeBodyState> emit) async {
    // Handle the next event
    print("FriendFoeBodyBloc _onNext event.heroId ${event.heroId}");

    var heroToReturn = const HeroStack.empty();
    var alreadyStackToReturn = const CardsStack.empty();

    if (event.heroId == friend.id && friendAlreadyPlayed.id != 0) {
      print("FriendFoeBodyBloc _onNext event.heroId == friend.id && friendAlreadyPlayed.id != 0 \n");
      var cards = friendAlreadyPlayed.cards;
      if (friend.heroStack.cards.isNotEmpty) {
        print("FriendFoeBodyBloc _onNext friend.heroStack.cards.isNotEmpty \n");
        cards.add(friend.heroStack.cards.last);
        alreadyStackToReturn = CardsStack(
            id: friendAlreadyPlayed.id,
            name: friendAlreadyPlayed.name,
            isActive: friendAlreadyPlayed.isActive,
            stackType: friendAlreadyPlayed.stackType,
            stackColor: friendAlreadyPlayed.stackColor,
            cards: cards);
        friendAlreadyPlayed = alreadyStackToReturn;
        friend.heroStack.cards.removeLast();
        heroToReturn = friend;
        print(
            "FriendFoeBodyBloc _onNext event.heroId == friend.id && friendAlreadyPlayed.id != 0 \n"
            "\t friend.heroStack.cards.isNotEmpty \n"
            "\t heroToReturn == $heroToReturn \n"
            "\t alreadyStackToReturn == $alreadyStackToReturn");
        // emit(FriendFoeBodySuccessActionState(
        //     heroToReturn, alreadyStackToReturn));
      } else {
        print("FriendFoeBodyBloc _onNext friend.heroStack.cards.isEmpty \n");
        friendAlreadyPlayed.cards.clear();
        var stack = await db.getStackById(friend.heroStack.id);
        //friend.heroStack = stack;
        var newHero = HeroStack(
            id: friend.id,
            name: friend.name,
            isFriend: friend.isFriend,
            heroStack: stack,
            energyClosetCount: friend.energyClosetCount,
            ability: friend.ability);
        friend = newHero;
        heroToReturn = friend;
        alreadyStackToReturn = friendAlreadyPlayed;

        print(
            "FriendFoeBodyBloc _onNext event.heroId == friend.id && friendAlreadyPlayed.id != 0 \n"
            "\t friend.heroStack.cards.isEmpty \n"
            "\t heroToReturn == $heroToReturn \n"
            "\t alreadyStackToReturn == $alreadyStackToReturn");

        // emit(FriendFoeBodySuccessActionState(
        //     heroToReturn, alreadyStackToReturn));
      }
    }
    if (event.heroId == foe.id && foeAlreadyPlayed.id != 0) {
      print("FriendFoeBodyBloc _onNext event.heroId == foe.id && foeAlreadyPlayed.id != 0 \n");
      var cards = foeAlreadyPlayed.cards;
      if (foe.heroStack.cards.isNotEmpty) {
        print("FriendFoeBodyBloc _onNext foe.heroStack.cards.isNotEmpty \n");
        cards.add(foe.heroStack.cards.last);
        alreadyStackToReturn = CardsStack(
            id: foeAlreadyPlayed.id,
            name: foeAlreadyPlayed.name,
            isActive: foeAlreadyPlayed.isActive,
            stackType: foeAlreadyPlayed.stackType,
            stackColor: foeAlreadyPlayed.stackColor,
            cards: cards);
        foeAlreadyPlayed = alreadyStackToReturn;
        foe.heroStack.cards.removeLast();
        heroToReturn = foe;
        print(
            "FriendFoeBodyBloc _onNext event.heroId == foe.id && foeAlreadyPlayed.id != 0 \n"
            "\t foe.heroStack.cards.isNotEmpty \n"
            "\t heroToReturn == $heroToReturn \n"
            "\t alreadyStackToReturn == $alreadyStackToReturn");
        // emit(FriendFoeBodySuccessActionState(
        //     heroToReturn, alreadyStackToReturn));
      } else {
        print("FriendFoeBodyBloc _onNext foe.heroStack.cards.isEmpty \n");
        foeAlreadyPlayed.cards.clear();
        var stack = await db.getStackById(foe.heroStack.id);
        //foe.heroStack = stack;
        var newFoe = HeroStack(
            id: foe.id,
            name: foe.name,
            isFriend: foe.isFriend,
            heroStack: stack,
            energyClosetCount: foe.energyClosetCount,
            ability: foe.ability);
        foe = newFoe;
        heroToReturn = foe;
        alreadyStackToReturn = foeAlreadyPlayed;

        print(
            "FriendFoeBodyBloc _onNext event.heroId == foe.id && foeAlreadyPlayed.id != 0 \n"
            "\t foe.heroStack.cards.isEmpty \n"
            "\t heroToReturn == $heroToReturn \n"
            "\t alreadyStackToReturn == $alreadyStackToReturn");

        // emit(FriendFoeBodySuccessActionState(
        //     heroToReturn, alreadyStackToReturn));
      }
    }

    emit(FriendFoeBodySuccessActionState(
             heroToReturn, alreadyStackToReturn));
  }

  _onChangeActiveStack(FriendFoeChangeActiveStackEvent event,
      Emitter<FriendFoeBodyState> emit) async {
    print("FriendFoeBodyBloc _onChangeActiveStack event.id == ${event.id} \n");

    var heroToReturn = const HeroStack.empty();
    var stackToReturn = const CardsStack.empty();

    var allHeroes = await defaultData.getHeroes();

    checkAllHeroes(bool checkFriend) async {
      for (var i = 0; i < allHeroes.length; i++) {
        if (allHeroes[i].heroStack.id != 0) {
          if (allHeroes[i].heroStack.isActive) {
            if (checkFriend == false) {
              if (allHeroes[i].heroStack.cards.isNotEmpty) {
                foe = allHeroes[i];
              } else {
                foe = await db.getHeroById(allHeroes[i].id);
              }
              foeAlreadyPlayed = CardsStack(
                  id: foe.heroStack.id,
                  name: foe.heroStack.name,
                  isActive: foe.heroStack.isActive,
                  stackType: foe.heroStack.stackType,
                  stackColor: foe.heroStack.stackColor,
                  cards: []);
              if (foe.heroStack.id == event.id) {
                heroToReturn = foe;
                stackToReturn = foeAlreadyPlayed;
              }
            } else {
              if (allHeroes[i].heroStack.cards.isNotEmpty) {
                friend = allHeroes[i];
              } else {
                friend = await db.getHeroById(allHeroes[i].id);
              }
              friendAlreadyPlayed = CardsStack(
                  id: friend.heroStack.id,
                  name: friend.heroStack.name,
                  isActive: friend.heroStack.isActive,
                  stackType: friend.heroStack.stackType,
                  stackColor: friend.heroStack.stackColor,
                  cards: []);
              if (friend.heroStack.id == event.id) {
                heroToReturn = friend;
                stackToReturn = friendAlreadyPlayed;
              }
            }
          }
        }
      }
      return;
    }

    if (friend.id != 0 && friend.heroStack.id != 0) {
      print(
          "FriendFoeBodyBloc _onChangeActiveStack friend.heroStack[0].id == ${friend.heroStack.id} \n");
      if (friend.heroStack.id != event.id) {
        print(
            "FriendFoeBodyBloc _onChangeActiveStack friend.heroStack[0].id != event.id \n");
      } else {
        print(
            "FriendFoeBodyBloc _onChangeActiveStack friend.heroStack[0].id == event.id \n");
        heroToReturn = friend;
        stackToReturn = friendAlreadyPlayed;
      }
    } else {
      if (friend.id == 0) {
        print("FriendFoeBodyBloc _onChangeActiveStack friend.id == 0 \n");
        checkAllHeroes(true);
      } else {
        print(
            "FriendFoeBodyBloc _onChangeActiveStack friend.heroStacks.isEmpty \n");
        friend = await db.getHeroById(friend.id);
        friendAlreadyPlayed = CardsStack(
            id: friend.heroStack.id,
            name: friend.heroStack.name,
            isActive: friend.heroStack.isActive,
            stackType: friend.heroStack.stackType,
            stackColor: friend.heroStack.stackColor,
            cards: []);
      }
      //_onInit(const FriendFoeBodyInitialEvent(0), emit);
    }

    if (foe.id != 0 && foe.heroStack.id != 0) {
      print(
          "FriendFoeBodyBloc _onChangeActiveStack foe.heroStack[0].id == ${foe.heroStack.id} \n");
      if (foe.heroStack.id != event.id) {
        print(
            "FriendFoeBodyBloc _onChangeActiveStack foe.heroStack[0].id != event.id \n");
      } else {
        print(
            "FriendFoeBodyBloc _onChangeActiveStack foe.heroStack[0].id == event.id \n");
        heroToReturn = foe;
        stackToReturn = foeAlreadyPlayed;
      }
    } else {
      if (foe.id == 0) {
        print("FriendFoeBodyBloc _onChangeActiveStack foe.id == 0 \n");
        checkAllHeroes(false);
      } else {
        foe = await db.getHeroById(foe.id);
        foeAlreadyPlayed = CardsStack(
            id: foe.heroStack.id,
            name: foe.heroStack.name,
            isActive: foe.heroStack.isActive,
            stackType: foe.heroStack.stackType,
            stackColor: foe.heroStack.stackColor,
            cards: []);
      }
      //_onInit(const FriendFoeBodyInitialEvent(0), emit);
    }

// Check if we came here from Turn order page by toching the Friend or Foe card
    if (event.id == -1) {
      print("came here from Turn order page by toching the Friend card");
      heroToReturn = friend;
      stackToReturn = friendAlreadyPlayed;
    } else if (event.id == -2) {
      print("came here from Turn order page by toching the Foe card");
      heroToReturn = foe;
      stackToReturn = foeAlreadyPlayed;
    } else if (event.id > 0) {
      if(friend.heroStack.id != 0) {
        if(event.id == friend.heroStack.id) {
          heroToReturn = friend;
          stackToReturn = friendAlreadyPlayed;
        }
      }
      if(foe.heroStack.id != 0) {
        if(event.id == foe.heroStack.id) {
          heroToReturn = foe;
          stackToReturn = foeAlreadyPlayed;
        }
      }
      if(heroToReturn.id == 0) {
        print("FriendFoeBodyBloc _onChangeActiveStack event.id > 0, heroToReturn.id == 0");
        allHeroes = await defaultData.getHeroes();
        for (var element in allHeroes) {
          if(element.heroStack.id != 0) {
            if(element.heroStack.id == event.id) {
              if(element.isFriend) {
                friend = element;
                friendAlreadyPlayed = CardsStack(
                id: friend.heroStack.id,
                name: friend.heroStack.name,
                isActive: friend.heroStack.isActive,
                stackType: friend.heroStack.stackType,
                stackColor: friend.heroStack.stackColor,
                cards: []);
                heroToReturn = friend;
                stackToReturn = friendAlreadyPlayed;
              } else {
                foe = element;
                foeAlreadyPlayed = CardsStack(
                id: foe.heroStack.id,
                name: foe.heroStack.name,
                isActive: foe.heroStack.isActive,
                stackType: foe.heroStack.stackType,
                stackColor: foe.heroStack.stackColor,
                cards: []);
                heroToReturn = foe;
                stackToReturn = foeAlreadyPlayed;
              }
            }
          }
        }
      }
    } else {
      print("FriendFoeBodyBloc _onChangeActiveStack event.id == 0");
    }
    
    print(
        "FriendFoeBodyBloc _onChangeActiveStack heroToReturn == $heroToReturn, \n stackToReturn == $stackToReturn");
    emit(FriendFoeBodySuccessActionState(heroToReturn, stackToReturn));
  }
}
