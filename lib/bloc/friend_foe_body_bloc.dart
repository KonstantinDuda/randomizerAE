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
    print("\n FriendFoeBodyBloc _onInit event.stackId == ${event.stackId} \n");

    var heroToReturn = const HeroStack.empty();
    var stackToReturn = const CardsStack.empty();
    //Map<HeroStack, CardsStack> dataToReturn = {};

    var allHeroes = await defaultData.getHeroes();

    Future<HeroStack> heroCheck(
        HeroStack hero, CardsStack alreadyPlayed, bool isFriend) async {
      if (hero.id == 0) {
        //print("FriendFoeBodyBloc _onInit heroCheck hero.id == 0 \n");
        var first = allHeroes.firstWhere((el) =>
            el.heroStack.id != 0 &&
            el.heroStack.isActive &&
            el.isFriend == isFriend);
        // print("FriendFoeBodyBloc _onInit heroCheck first == $first \n");
        if (first.heroStack.cards.isNotEmpty) {
          //print("FriendFoeBodyBloc _onInit heroCheck "
          //    "\t first.heroStack.cards.isNotEmpty");
          hero = first;
          hero.heroStack.cards.shuffle();
          // alreadyPlayed = CardsStack(
          //     id: hero.heroStack.id,
          //     name: hero.heroStack.name,
          //     isActive: hero.heroStack.isActive,
          //     stackType: hero.heroStack.stackType,
          //     stackColor: hero.heroStack.stackColor,
          //     cards: []);
        } else {
          //print("FriendFoeBodyBloc _onInit heroCheck "
          //    "\t first.heroStack.cards.isEmpty");
          var stack = await db.getStackById(first.heroStack.id);
          stack.cards.shuffle();
          hero = HeroStack(
              id: first.id,
              name: first.name,
              isFriend: first.isFriend,
              heroStack: stack,
              energyClosetCount: first.energyClosetCount,
              ability: first.ability);
          // alreadyPlayed = CardsStack(
          //     id: hero.heroStack.id,
          //     name: hero.heroStack.name,
          //     isActive: hero.heroStack.isActive,
          //     stackType: hero.heroStack.stackType,
          //     stackColor: hero.heroStack.stackColor,
          //     cards: []);
        }
        return hero;
        // for (var element in allHeroes) {
        //   if (element.heroStack.id != 0) {
        //     if (element.heroStack.cards.isNotEmpty) {
        //       if (element.heroStack.isActive && element.isFriend) {
        //         hero = element;
        //         print("FriendFoeBodyBloc _onInit heroCheck "
        //             " friend = $friend");
        //       }
        //     } else {
        //       if (element.heroStack.isActive && element.isFriend) {
        //         var stack = await db.getStackById(element.heroStack.id);
        //         stack.cards.shuffle();
        //         hero = HeroStack(
        //             id: element.id,
        //             name: element.name,
        //             isFriend: element.isFriend,
        //             heroStack: stack,
        //             energyClosetCount: element.energyClosetCount,
        //             ability: element.ability);
        //       }
        //     }
        //     alreadyPlayed = CardsStack(
        //         id: element.heroStack.id,
        //         name: element.heroStack.name,
        //         isActive: element.heroStack.isActive,
        //         stackType: element.heroStack.stackType,
        //         stackColor: element.heroStack.stackColor,
        //         cards: []);
        //   }
        // }
      } else {
        //print("FriendFoeBodyBloc _onInit heroCheck hero.id != 0 hero == $hero \n");
        return hero;
      }
    }

    friend = await heroCheck(friend, friendAlreadyPlayed, true);
    // friendAlreadyPlayed = CardsStack(
    //     id: friend.heroStack.id,
    //     name: friend.heroStack.name,
    //     isActive: friend.heroStack.isActive,
    //     stackType: friend.heroStack.stackType,
    //     stackColor: friend.heroStack.stackColor,
    //     cards: []);
    foe = await heroCheck(foe, foeAlreadyPlayed, false);
    // foeAlreadyPlayed = CardsStack(
    //     id: foe.heroStack.id,
    //     name: foe.heroStack.name,
    //     isActive: foe.heroStack.isActive,
    //     stackType: foe.heroStack.stackType,
    //     stackColor: foe.heroStack.stackColor,
    //     cards: []);
    print("FriendFoeBodyBloc _onInit after heroChecks "
        "friend == $friend \n \t foe == $foe");

    /*if (friend.id == 0) {
      print("FriendFoeBodyBloc _onInit friend.id == 0 \n");
      for (var element in allHeroes) {
        //print("\t element == $element");
        if (element.heroStack.id != 0) {
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
        if (element.heroStack.id != 0) {
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
    }*/

    // Friend and Foe ids != 0
    stackCheck(HeroStack hero, CardsStack alreadyPlayed) async {
      //print("FriendFoeBodyBloc _onInit stackCheck hero.id == ${hero.id} \n");
      if (hero.id != 0) {
        if (hero.heroStack.id == event.stackId &&
            hero.heroStack.cards.isNotEmpty) {
          // print("FriendFoeBodyBloc _onInit stackCheck "
          //     " hero.heroStack.id == event.stackId && hero.heroStack.cards.isNotEmpty \n");
          heroToReturn = hero;
          stackToReturn = alreadyPlayed;
        } else if (hero.heroStack.id == event.stackId) {
          // print(
          //     "FriendFoeBodyBloc _onInit stackCheck hero.heroStack.id == event.stackId \n");
          var stack = await db.getStackById(hero.heroStack.id);
          stack.cards.shuffle();
          heroToReturn = HeroStack(
              id: hero.id,
              name: hero.name,
              isFriend: hero.isFriend,
              heroStack: stack,
              energyClosetCount: hero.energyClosetCount,
              ability: hero.ability);
          stackToReturn = CardsStack(
              id: hero.heroStack.id,
              name: hero.heroStack.name,
              isActive: hero.heroStack.isActive,
              stackType: hero.heroStack.stackType,
              stackColor: hero.heroStack.stackColor,
              cards: []);
          // print(
          //     "FriendFoeBodyBloc _onInit stackCheck heroToReturn == $heroToReturn \n"
          //     "\t stackToReturn == $stackToReturn");
        } else {
          print("FriendFoeBodyBloc _onInit stackCheck "
              "hero.heroStack.id != event.stackId \n");
        }
      } else {
        print("FriendFoeBodyBloc _onInit stackCheck hero.id == 0 \n");
      }
    }

    await stackCheck(friend, friendAlreadyPlayed);
    if(heroToReturn.id != 0) {
      friend = heroToReturn;
      friendAlreadyPlayed = stackToReturn;
    } else {
      await stackCheck(foe, foeAlreadyPlayed);
      foe = heroToReturn;
      foeAlreadyPlayed = stackToReturn;
    }
    
    print("FriendFoeBodyBloc _onInit after stackCheck "
        "friend == $friend \n \t foe == $foe");

    /*if (friend.heroStack.id != 0) {
      print("FriendFoeBodyBloc _onInit friend.heroStack.id != 0 \n");
      if (friend.heroStack.id == event.stackId &&
          friend.heroStack.cards.isNotEmpty) {
        print(
            "FriendFoeBodyBloc _onInit friend.heroStack.id == event.stackId && friend.heroStack.cards.isNotEmpty");
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
      if (foe.heroStack.id == event.stackId && foe.heroStack.cards.isNotEmpty) {
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
    }*/

    //print("FriendFoeBodyBloc _onInit friend == $friend \n \t foe == $foe");
    print("FriendFoeBodyBloc _onInit heroToReturn == $heroToReturn \n"
        "\t stackToReturn == $stackToReturn");

    emit(FriendFoeBodySuccessActionState(heroToReturn, stackToReturn));
  }

  _onNext(
      FriendFoeBodyNextEvent event, Emitter<FriendFoeBodyState> emit) async {
    // Handle the next event
    print("FriendFoeBodyBloc _onNext event.heroId == ${event.heroId}");

    var heroToReturn = const HeroStack.empty();
    var alreadyStackToReturn = const CardsStack.empty();

    eventCheck(HeroStack hero, CardsStack alreadyPlayed) async {
      print("FriendFoeBodyBloc _onNext eventCheck hero.id == ${hero.id} \n");
      List<AECard> cards = [];
      if (event.heroId == hero.id /*&& alreadyPlayed.id != 0*/) {
        print("FriendFoeBodyBloc _onNext eventCheck "
            " event.heroId == hero.id \n");
        /*List<AECard> */ cards =
            alreadyPlayed.id == 0 ? [] : alreadyPlayed.cards;
        if (hero.heroStack.cards.isNotEmpty) {
          print(
              "FriendFoeBodyBloc _onNext eventCheck hero.heroStack.cards.isNotEmpty \n");
          cards.add(hero.heroStack.cards.last);

          // alreadyStackToReturn = CardsStack(
          //     id: alreadyPlayed.id,
          //     name: alreadyPlayed.name,
          //     isActive: alreadyPlayed.isActive,
          //     stackType: alreadyPlayed.stackType,
          //     stackColor: alreadyPlayed.stackColor,
          //     cards: cards);
          //alreadyPlayed = alreadyStackToReturn;

          hero.heroStack.cards.removeLast();
          heroToReturn = hero;

          print("\n \t hero.heroStack.cards.isNotEmpty \n");
        } else {
          print(
              "FriendFoeBodyBloc _onNext eventCheck hero.heroStack.cards.isEmpty \n");
          //alreadyPlayed.cards.clear();
          cards.clear();
          var stack = await db.getStackById(hero.heroStack.id);
          stack.cards.shuffle();
          //hero.heroStack = stack;
          var newHero = HeroStack(
              id: hero.id,
              name: hero.name,
              isFriend: hero.isFriend,
              heroStack: stack,
              energyClosetCount: hero.energyClosetCount,
              ability: hero.ability);
          //hero = newHero;
          heroToReturn = newHero; // hero;
          //alreadyStackToReturn = alreadyPlayed;

          print("\t hero.heroStack.cards.isEmpty \n");
        }
        alreadyStackToReturn = CardsStack(
            id: hero.heroStack.id,
            name: hero.heroStack.name,
            isActive: hero.heroStack.isActive,
            stackType: hero.heroStack.stackType,
            stackColor: hero.heroStack.stackColor,
            cards: cards);
        print("FriendFoeBodyBloc _onNext eventCheck \n"
            "\t heroToReturn == $heroToReturn \n"
            "\t alreadyStackToReturn == $alreadyStackToReturn");
      }
    }

    await eventCheck(friend, friendAlreadyPlayed);
    if (heroToReturn.id == 0) {
      await eventCheck(foe, foeAlreadyPlayed);
      if (heroToReturn.id != 0) {
        foe = heroToReturn;
        foeAlreadyPlayed = alreadyStackToReturn;
        print(
            "\n FriendFoeBodyBloc _onNext after eventCheck(foe, _) foe == $foe, "
            "\n \t foeAlreadyPlayed == $foeAlreadyPlayed");
      } else {
        print(
            "\n FriendFoeBodyBloc _onNext after eventCheck heroToReturn == 0");
      }
    } else {
      friend = heroToReturn;
      friendAlreadyPlayed = alreadyStackToReturn;
      print(
          "\n FriendFoeBodyBloc _onNext after eventCheck(friend, _) friend == $friend, "
          "\n \t friendAlreadyPlayed == $friendAlreadyPlayed");
    }

    /*if (event.heroId == friend.id && friendAlreadyPlayed.id != 0) {
      print(
          "FriendFoeBodyBloc _onNext event.heroId == friend.id && friendAlreadyPlayed.id != 0 \n");
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
        stack.cards.shuffle();
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
      print(
          "FriendFoeBodyBloc _onNext event.heroId == foe.id && foeAlreadyPlayed.id != 0 \n");
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
        stack.cards.shuffle();
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
    }*/

    emit(FriendFoeBodySuccessActionState(heroToReturn, alreadyStackToReturn));
  }

  _onChangeActiveStack(FriendFoeChangeActiveStackEvent event,
      Emitter<FriendFoeBodyState> emit) async {
    print(
        "FriendFoeBodyBloc _onChangeActiveStack event.stackId == ${event.stackId} \n");

    var heroToReturn = const HeroStack.empty();
    var stackToReturn = const CardsStack.empty();

    var allHeroes = []; // await defaultData.getHeroes();
    //print("FriendFoeBodyBloc _onChangeActiveStack allHeroes == $allHeroes \n");

    checkAllHeroes(CardsStack alreadyPlayed) async {
      allHeroes = await defaultData.getHeroes();
      print(
          "FriendFoeBodyBloc _onChangeActiveStack checkAllHeroes allHeroes.length == ${allHeroes.length} \n");
      var hero = allHeroes
          .firstWhere((el) => el.heroStack.id != 0 && el.heroStack.isActive);
      if (hero.id == 0) {
        return hero;
      }

      if (hero.heroStack.cards.isEmpty) {
        hero = await db.getHeroById(hero.id);
        hero.heroStack.cards.shuffle();
      }
      alreadyPlayed = CardsStack(
          id: hero.heroStack.id,
          name: hero.heroStack.name,
          isActive: hero.heroStack.isActive,
          stackType: hero.heroStack.stackType,
          stackColor: hero.heroStack.stackColor,
          cards: []);
      if (hero.heroStack.id == event.stackId) {
        heroToReturn = hero;
        stackToReturn = alreadyPlayed;
      }

      return hero;
    }

    friendFoeCheck(HeroStack hero, CardsStack alreadyPlayed) async {
      if (hero.id != 0 && hero.heroStack.id != 0) {
        if (hero.heroStack.id == event.stackId) {
          heroToReturn = hero;
          stackToReturn = alreadyPlayed;
        }
      } else {
        if (hero.id == 0) {
          hero = await checkAllHeroes(alreadyPlayed);
        } else {
          hero = await db.getHeroById(hero.id);
          hero.heroStack.cards.shuffle();
          alreadyPlayed = CardsStack(
              id: hero.heroStack.id,
              name: hero.heroStack.name,
              isActive: hero.heroStack.isActive,
              stackType: hero.heroStack.stackType,
              stackColor: hero.heroStack.stackColor,
              cards: []);
        }
      }
    }

    await friendFoeCheck(friend, friendAlreadyPlayed);
    await friendFoeCheck(foe, foeAlreadyPlayed);
    print("FriendFoeBodyBloc _onChangeActiveStack after checks "
        "friend == $friend, \n \t foe == $foe");

    /*if (friend.id != 0 && friend.heroStack.id != 0) {
      // print(
      //     "FriendFoeBodyBloc _onChangeActiveStack friend.heroStack.id != 0, fr.heroStack.id == ${friend.heroStack.id} \n");
      if (friend.heroStack.id != event.stackId) {
        print(
            "FriendFoeBodyBloc _onChangeActiveStack friend.heroStack.id != event.id \n");
      } else {
        // print(
        //     "FriendFoeBodyBloc _onChangeActiveStack friend.heroStack.id == event.id \n");
        heroToReturn = friend;
        stackToReturn = friendAlreadyPlayed;
      }
    } else {
      if (friend.id == 0) {
        // print("FriendFoeBodyBloc _onChangeActiveStack friend.id == 0 \n");
        friend = await checkAllHeroes(friendAlreadyPlayed);
      } else {
        // print(
        //     "FriendFoeBodyBloc _onChangeActiveStack friend.heroStacks.isEmpty \n");
        friend = await db.getHeroById(friend.id);
        friend.heroStack.cards.shuffle();
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
      // print(
      //     "FriendFoeBodyBloc _onChangeActiveStack foe.heroStack.id != 0, foe.heroStack == ${foe.heroStack.id} \n");
      if (foe.heroStack.id != event.stackId) {
        print(
            "FriendFoeBodyBloc _onChangeActiveStack foe.heroStack.id != event.id \n");
      } else {
        // print(
        //     "FriendFoeBodyBloc _onChangeActiveStack foe.heroStack.id == event.id \n");
        heroToReturn = foe;
        stackToReturn = foeAlreadyPlayed;
      }
    } else {
      if (foe.id == 0) {
        //print("FriendFoeBodyBloc _onChangeActiveStack foe.id == 0 \n");
        foe = await checkAllHeroes(foeAlreadyPlayed);
      } else {
        foe = await db.getHeroById(foe.id);
        foe.heroStack.cards.shuffle();
        foeAlreadyPlayed = CardsStack(
            id: foe.heroStack.id,
            name: foe.heroStack.name,
            isActive: foe.heroStack.isActive,
            stackType: foe.heroStack.stackType,
            stackColor: foe.heroStack.stackColor,
            cards: []);
      }
      //_onInit(const FriendFoeBodyInitialEvent(0), emit);
    }*/

// Check if we came here from Turn order page by toching the Friend or Foe card
    if (event.stackId == -1) {
      print("came here from Turn order page by toching the Friend card");
      heroToReturn = friend;
      stackToReturn = friendAlreadyPlayed;
    } else if (event.stackId == -2) {
      print("came here from Turn order page by toching the Foe card");
      heroToReturn = foe;
      stackToReturn = foeAlreadyPlayed;
    } else if (event.stackId > 0) {
      //print("FriendFoeBodyBloc _onChangeActiveStack event.id > 0");
      if (friend.heroStack.id != 0) {
        if (event.stackId == friend.heroStack.id) {
          heroToReturn = friend;
          stackToReturn = friendAlreadyPlayed;
        }
      }
      if (foe.heroStack.id != 0) {
        if (event.stackId == foe.heroStack.id) {
          heroToReturn = foe;
          stackToReturn = foeAlreadyPlayed;
        }
      }
      if (heroToReturn.id == 0) {
        // print("FriendFoeBodyBloc _onChangeActiveStack event.id > 0, heroToReturn.id == 0");
        allHeroes = await defaultData.getHeroes();
        for (var element in allHeroes) {
          if (element.heroStack.id != 0) {
            if (element.heroStack.id == event.stackId) {
              // print("FriendFoeBodyBloc _onChangeActiveStack event.id > 0, element.heroStack.id == event.stackId");
              if (element.isFriend) {
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
        "FriendFoeBodyBloc _onChangeActiveStack friend == $friend, \n \t foe == $foe");
    print(
        "FriendFoeBodyBloc _onChangeActiveStack heroToReturn == $heroToReturn, \n \t stackToReturn == $stackToReturn");
    emit(FriendFoeBodySuccessActionState(heroToReturn, stackToReturn));
  }
}
