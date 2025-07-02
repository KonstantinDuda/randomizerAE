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
        if (element.heroStacks.isNotEmpty) {
          if (element.heroStacks[0].cards.isNotEmpty) {
            if (element.heroStacks[0].isActive && element.isFriend) {
              friend = element;
            }
          } else {
            if (element.heroStacks[0].isActive && element.isFriend) {
              var stack = await db.getStackById(element.heroStacks[0].id);
              stack.cards.shuffle();
              friend = HeroStack(
                  id: element.id,
                  name: element.name,
                  isFriend: element.isFriend,
                  heroStacks: [stack],
                  energyClosetCount: element.energyClosetCount,
                  ability: element.ability);
            }
          }
          friendAlreadyPlayed = CardsStack(
              id: element.heroStacks[0].id,
              name: element.heroStacks[0].name,
              isActive: element.heroStacks[0].isActive,
              stackType: element.heroStacks[0].stackType,
              stackColor: element.heroStacks[0].stackColor,
              cards: []);
        }
      }
    }

    if (foe.id == 0) {
      print("FriendFoeBodyBloc _onInit foe.id == 0 \n");
      for (var element in allHeroes) {
        if (element.heroStacks.isNotEmpty) {
          if (element.heroStacks[0].cards.isNotEmpty) {
            if (element.heroStacks[0].isActive && !element.isFriend) {
              foe = element;
            }
          } else {
            if (element.heroStacks[0].isActive && !element.isFriend) {
              var stack = await db.getStackById(element.heroStacks[0].id);
              stack.cards.shuffle();
              foe = HeroStack(
                  id: element.id,
                  name: element.name,
                  isFriend: element.isFriend,
                  heroStacks: [stack],
                  energyClosetCount: element.energyClosetCount,
                  ability: element.ability);
            }
          }
          foeAlreadyPlayed = CardsStack(
              id: element.heroStacks[0].id,
              name: element.heroStacks[0].name,
              isActive: element.heroStacks[0].isActive,
              stackType: element.heroStacks[0].stackType,
              stackColor: element.heroStacks[0].stackColor,
              cards: []);
        }
      }
    }

    // Friend and Foe ids != 0
    if (friend.heroStacks.isNotEmpty) {
      print("FriendFoeBodyBloc _onInit friend.heroStacks.isNotEmpty \n");
      if (friend.heroStacks[0].id == event.stackId &&
          friend.heroStacks[0].cards.isNotEmpty) {
        heroToReturn = friend;
        // friendAlreadyPlayed = CardsStack(
        //     id: friend.heroStacks[0].id,
        //     name: friend.heroStacks[0].name,
        //     isActive: friend.heroStacks[0].isActive,
        //     stackType: friend.heroStacks[0].stackType,
        //     stackColor: friend.heroStacks[0].stackColor,
        //     cards: []);
        stackToReturn = friendAlreadyPlayed;
      } else if (friend.heroStacks[0].id == event.stackId) {
        var stack = await db.getStackById(friend.heroStacks[0].id);
        stack.cards.shuffle();
        var supportStack = const CardsStack.empty();
        if (friend.heroStacks.length > 1) {
          supportStack = friend.heroStacks[1];
          heroToReturn = HeroStack(
              id: friend.id,
              name: friend.name,
              isFriend: true,
              heroStacks: [stack, supportStack],
              energyClosetCount: friend.energyClosetCount,
              ability: friend.ability);
        } else {
          heroToReturn = HeroStack(
              id: friend.id,
              name: friend.name,
              isFriend: true,
              heroStacks: [stack],
              energyClosetCount: friend.energyClosetCount,
              ability: friend.ability);
        }
        friend = heroToReturn;
        friendAlreadyPlayed = CardsStack(
            id: friend.heroStacks[0].id,
            name: friend.heroStacks[0].name,
            isActive: friend.heroStacks[0].isActive,
            stackType: friend.heroStacks[0].stackType,
            stackColor: friend.heroStacks[0].stackColor,
            cards: []);
      }
    }

    if (foe.heroStacks.isNotEmpty) {
      print("FriendFoeBodyBloc _onInit foe.heroStacks.isNotEmpty \n");
      if (foe.heroStacks[0].id == event.stackId &&
          foe.heroStacks[0].cards.isNotEmpty) {
        heroToReturn = foe;
        // foeAlreadyPlayed = CardsStack(
        //     id: foe.heroStacks[0].id,
        //     name: foe.heroStacks[0].name,
        //     isActive: foe.heroStacks[0].isActive,
        //     stackType: foe.heroStacks[0].stackType,
        //     stackColor: foe.heroStacks[0].stackColor,
        //     cards: []);
        stackToReturn = foeAlreadyPlayed;
      } else if (foe.heroStacks[0].id == event.stackId) {
        var stack = await db.getStackById(foe.heroStacks[0].id);
        stack.cards.shuffle();
        var supportStack = const CardsStack.empty();
        if (foe.heroStacks.length > 1) {
          supportStack = foe.heroStacks[1];
          heroToReturn = HeroStack(
              id: foe.id,
              name: foe.name,
              isFriend: true,
              heroStacks: [stack, supportStack],
              energyClosetCount: foe.energyClosetCount,
              ability: foe.ability);
        } else {
          heroToReturn = HeroStack(
              id: foe.id,
              name: foe.name,
              isFriend: true,
              heroStacks: [stack],
              energyClosetCount: foe.energyClosetCount,
              ability: foe.ability);
        }
        foe = heroToReturn;
        foeAlreadyPlayed = CardsStack(
            id: foe.heroStacks[0].id,
            name: foe.heroStacks[0].name,
            isActive: foe.heroStacks[0].isActive,
            stackType: foe.heroStacks[0].stackType,
            stackColor: foe.heroStacks[0].stackColor,
            cards: []);
      }
    }
    print("FriendFoeBodyBloc friend == $friend \n foe == $foe");
    print("FriendFoeBodyBloc heroToReturn == $heroToReturn "
        " stackToReturn == $stackToReturn");

    emit(FriendFoeBodySuccessActionState(heroToReturn, stackToReturn));
  }

  _onNext(
      FriendFoeBodyNextEvent event, Emitter<FriendFoeBodyState> emit) async {
    // Handle the next event
    print("FriendFoeBodyBloc _onNext event.heroId ${event.heroId}");

    var heroToReturn = const HeroStack.empty();
    var alreadyStackToReturn = const CardsStack.empty();

    if (event.heroId == friend.id && friendAlreadyPlayed.id != 0) {
      var cards = friendAlreadyPlayed.cards;
      if (friend.heroStacks[0].cards.isNotEmpty) {
        cards.add(friend.heroStacks[0].cards.last);
        alreadyStackToReturn = CardsStack(
            id: friendAlreadyPlayed.id,
            name: friendAlreadyPlayed.name,
            isActive: friendAlreadyPlayed.isActive,
            stackType: friendAlreadyPlayed.stackType,
            stackColor: friendAlreadyPlayed.stackColor,
            cards: cards);
        friendAlreadyPlayed = alreadyStackToReturn;
        friend.heroStacks[0].cards.removeLast();
        heroToReturn = friend;
        print(
            "FriendFoeBodyBloc _onNext event.heroId == friend.id && friendAlreadyPlayed.id != 0"
            "\n friend.heroStacks[0].cards.isNotEmpty"
            "\n heroToReturn == $heroToReturn "
            "\n alreadyStackToReturn == $alreadyStackToReturn");
        emit(FriendFoeBodySuccessActionState(
            heroToReturn, alreadyStackToReturn));
      } else {
        friendAlreadyPlayed.cards.clear();
        var stack = await db.getStackById(friend.heroStacks[0].id);
        friend.heroStacks[0] = stack;
        heroToReturn = friend;
        alreadyStackToReturn = friendAlreadyPlayed;

        print(
            "FriendFoeBodyBloc _onNext event.heroId == friend.id && friendAlreadyPlayed.id != 0"
            "\n friend.heroStacks[0].cards.isEmpty"
            "\n heroToReturn == $heroToReturn "
            "\n alreadyStackToReturn == $alreadyStackToReturn");

        emit(FriendFoeBodySuccessActionState(
            heroToReturn, alreadyStackToReturn));
      }
    }
    if (event.heroId == foe.id && foeAlreadyPlayed.id != 0) {
      var cards = foeAlreadyPlayed.cards;
      if (foe.heroStacks[0].cards.isNotEmpty) {
        cards.add(foe.heroStacks[0].cards.last);
        alreadyStackToReturn = CardsStack(
            id: foeAlreadyPlayed.id,
            name: foeAlreadyPlayed.name,
            isActive: foeAlreadyPlayed.isActive,
            stackType: foeAlreadyPlayed.stackType,
            stackColor: foeAlreadyPlayed.stackColor,
            cards: cards);
        foeAlreadyPlayed = alreadyStackToReturn;
        foe.heroStacks[0].cards.removeLast();
        heroToReturn = foe;
        print(
            "FriendFoeBodyBloc _onNext event.heroId == foe.id && foeAlreadyPlayed.id != 0"
            "\n foe.heroStacks[0].cards.isNotEmpty"
            "\n heroToReturn == $heroToReturn "
            "\n alreadyStackToReturn == $alreadyStackToReturn");
        emit(FriendFoeBodySuccessActionState(
            heroToReturn, alreadyStackToReturn));
      } else {
        foeAlreadyPlayed.cards.clear();
        var stack = await db.getStackById(foe.heroStacks[0].id);
        foe.heroStacks[0] = stack;
        heroToReturn = foe;
        alreadyStackToReturn = foeAlreadyPlayed;

        print(
            "FriendFoeBodyBloc _onNext event.heroId == foe.id && foeAlreadyPlayed.id != 0"
            "\n foe.heroStacks[0].cards.isEmpty"
            "\n heroToReturn == $heroToReturn "
            "\n alreadyStackToReturn == $alreadyStackToReturn");

        emit(FriendFoeBodySuccessActionState(
            heroToReturn, alreadyStackToReturn));
      }
    }
  }

  _onChangeActiveStack(FriendFoeChangeActiveStackEvent event,
      Emitter<FriendFoeBodyState> emit) async {
    print("FriendFoeBodyBloc _onChangeActiveStack event.id == ${event.id} \n");

    var heroToReturn = const HeroStack.empty();
    var stackToReturn = const CardsStack.empty();

    var allHeroes = await defaultData.getHeroes();

    
    print("FriendFoeBodyBloc _onChangeActiveStack friend.heroStack[0].id == ${friend.heroStacks[0].id} \n");
    print("FriendFoeBodyBloc _onChangeActiveStack foe.heroStack[0].id == ${foe.heroStacks[0].id} \n");

    if (event.id != friend.heroStacks[0].id && event.id != foe.heroStacks[0].id) {
      print(
          "FriendFoeBodyBloc _onChangeActiveStack event.id != friend.id && event.id != foe.id");
      for (var i = 0; i < allHeroes.length; i++) {
        if (allHeroes[i].heroStacks.isNotEmpty) {
          print(
              "FriendFoeBodyBloc _onChangeActiveStack allHeroes[$i].heroStacks.isNotEmpty");
          if (allHeroes[i].heroStacks[0].id == event.id) {
            print(
                "FriendFoeBodyBloc _onChangeActiveStack allHeroes[$i].heroStacks[0].id == event.id");
            if (allHeroes[i].isFriend) {
              print(
                  "FriendFoeBodyBloc _onChangeActiveStack allHeroes[$i].isFriend");
              if (allHeroes[i].heroStacks[0].cards.isNotEmpty) {
                friend = allHeroes[i];
              } else {
                friend = await db.getHeroById(allHeroes[i].id);
              }
              friendAlreadyPlayed = CardsStack(
                  id: friend.heroStacks[0].id,
                  name: friend.heroStacks[0].name,
                  isActive: true,
                  stackType: friend.heroStacks[0].stackType,
                  stackColor: friend.heroStacks[0].stackColor,
                  cards: []);
              heroToReturn = friend;
              stackToReturn = friendAlreadyPlayed;
              
            } else {
              print(
                  "FriendFoeBodyBloc _onChangeActiveStack allHeroes[$i].isNotFriend");
              if (allHeroes[i].heroStacks[0].cards.isNotEmpty) {
                foe = allHeroes[i];
              } else {
                foe = await db.getHeroById(allHeroes[i].id);
              }
              foeAlreadyPlayed = CardsStack(
                  id: foe.heroStacks[0].id,
                  name: foe.heroStacks[0].name,
                  isActive: true,
                  stackType: foe.heroStacks[0].stackType,
                  stackColor: foe.heroStacks[0].stackColor,
                  cards: []);
              heroToReturn = foe;
              stackToReturn = foeAlreadyPlayed;

            }
          }
        } else {
          print(
              "FriendFoeBodyBloc _onChangeActiveStack allHeroes[$i].heroStacks.isEmpty");
          var alreadyPlayed = const CardsStack.empty();
          emit(FriendFoeBodySuccessActionState(
              const HeroStack.empty(), alreadyPlayed));
          break;
        }
      }
    } else if (event.id == friend.heroStacks[0].id) {
      print("FriendFoeBodyBloc _onChangeActiveStack event.id == friend.id ");
      if (friend.id != 0 && friend.heroStacks.isNotEmpty) {
        heroToReturn = friend;
        stackToReturn = friendAlreadyPlayed;
      } else {
        _onInit(const FriendFoeBodyInitialEvent(0), emit);
      }
    } else if (event.id == foe.heroStacks[0].id) {
      print("FriendFoeBodyBloc _onChangeActiveStack event.id == foe.id ");
      if (foe.id != 0 && foe.heroStacks.isNotEmpty) {
        heroToReturn = foe;
        stackToReturn = foeAlreadyPlayed;
      } else {
        _onInit(const FriendFoeBodyInitialEvent(0), emit);
      }
    }

    print(
        "FriendFoeBodyBloc _onChangeActiveStack heroToReturn == $heroToReturn, stackToReturn == $stackToReturn");
    emit(FriendFoeBodySuccessActionState(heroToReturn, stackToReturn));
  }
}
