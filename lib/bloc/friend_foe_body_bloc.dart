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

    // Friend and foe ids == 0
    if (friend.id == 0 && foe.id == 0) {
      for (var element in allHeroes) {
        if (element.heroStacks.isNotEmpty) {
          if (element.heroStacks[0].cards.isNotEmpty &&
              element.heroStacks[0].isActive) {
            if (element.isFriend) {
              friend = element;
            } else {
              foe = element;
            }
          } else if (element.heroStacks[0].isActive) {
            if (element.isFriend) {
              var stack = await db.getStackById(element.heroStacks[0].id);
              friend = HeroStack(
                  id: element.id,
                  name: element.name,
                  isFriend: element.isFriend,
                  heroStacks: [stack],
                  energyClosetCount: element.energyClosetCount,
                  ability: element.ability);
            } else {
              var stack = await db.getStackById(element.heroStacks[0].id);
              foe = HeroStack(
                  id: element.id,
                  name: element.name,
                  isFriend: element.isFriend,
                  heroStacks: [stack],
                  energyClosetCount: element.energyClosetCount,
                  ability: element.ability);
            }
          }
        }
      }
    } else if (friend.id == 0) {
      for (var element in allHeroes) {
        if (element.heroStacks.isNotEmpty) {
          if (element.heroStacks[0].cards.isNotEmpty) {
            if (element.heroStacks[0].isActive && element.isFriend) {
              friend = element;
            }
          } else {
            if (element.heroStacks[0].isActive && element.isFriend) {
              var stack = await db.getStackById(element.heroStacks[0].id);
              friend = HeroStack(
                  id: element.id,
                  name: element.name,
                  isFriend: element.isFriend,
                  heroStacks: [stack],
                  energyClosetCount: element.energyClosetCount,
                  ability: element.ability);
            }
          }
        }
      }
    } else if (foe.id == 0) {
      for (var element in allHeroes) {
        if (element.heroStacks.isNotEmpty) {
          if (element.heroStacks[0].cards.isNotEmpty) {
            if (element.heroStacks[0].isActive && !element.isFriend) {
              foe = element;
            }
          } else {
            if (element.heroStacks[0].isActive && !element.isFriend) {
              var stack = await db.getStackById(element.heroStacks[0].id);
              foe = HeroStack(
                  id: element.id,
                  name: element.name,
                  isFriend: element.isFriend,
                  heroStacks: [stack],
                  energyClosetCount: element.energyClosetCount,
                  ability: element.ability);
            }
          }
        }
      }
    }


    // Friend and Foe ids != 0 
    if (friend.heroStacks.isNotEmpty) {
      if (friend.heroStacks[0].id == event.stackId &&
          friend.heroStacks[0].cards.isNotEmpty) {
        heroToReturn = friend;
        stackToReturn = friendAlreadyPlayed;
      }
      if (friend.heroStacks[0].id == event.stackId) {
        var stack = await db.getStackById(friend.heroStacks[0].id);
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
      }
    }

    if (foe.heroStacks.isNotEmpty) {
      if (foe.heroStacks[0].id == event.stackId &&
          foe.heroStacks[0].cards.isNotEmpty) {
        heroToReturn = foe;
        stackToReturn = foeAlreadyPlayed;
      }
      if (foe.heroStacks[0].id == event.stackId) {
        var stack = await db.getStackById(foe.heroStacks[0].id);
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
      }
    }

print("FriendFoeBodyBloc heroToReturn == $heroToReturn \n stackToReturn == $stackToReturn");

    emit(FriendFoeBodySuccessActionState(heroToReturn, stackToReturn));

/*
  var heroToReturn = const HeroStack.empty();

    if(friend.id == 0 || foe.id == 0) {
      var stackList = await db.getAvailableStacks();
      if (stackList.isNotEmpty) {
        for (var element in stackList) {
         if (element.stackType == StackType.friendFoe && element.stackColor == const Color.fromARGB(255, 33, 150, 243)) {
          friend = defaultData.getHeroByStackId(element.id);
          heroToReturn = friend;
          friendAlreadyPlayed = CardsStack(
            id: element.id,
            name: element.name,
            isActive: true,
            stackType: StackType.friendFoe,
            stackColor: element.stackColor,
            cards: [],
          );
          print("FriendFoeBodyBloc _onInit friend.id == ${friend.id}. friend.heroStacks == ${friend.heroStacks} \n");
         } else if (element.stackType == StackType.friendFoe && element.stackColor == const Color.fromARGB(255, 244, 67, 54)) {
          foe = defaultData.getHeroByStackId(element.id);
          heroToReturn = foe;
          foeAlreadyPlayed = CardsStack(
            id: element.id,
            name: element.name,
            isActive: true,
            stackType: StackType.friendFoe,
            stackColor: element.stackColor,
            cards: [],
          );
          print("FriendFoeBodyBloc _onInit foe.id == ${foe.id}. foe.heroStacks == ${foe.heroStacks} \n");
         }
      }
    }
    }

    if(friend.id != 0) {
      if(friend.heroStacks.isNotEmpty) {
        if(friend.heroStacks[0].id == event.stackId) {
          heroToReturn = friend;
        }
      } else {
        await defaultData.createFriendFoeHeroes();
        for (var element in defaultData.friendFoeList) {
          if(element.id == friend.id) {
            friend = element;
          }
        }
        if(friend.heroStacks[0].id == event.stackId) {
          heroToReturn = friend;
        }
        print("FriendFoeBodyBloc _onInit friend.id == ${friend.id}. friend.heroStacks was Empty == ${friend.heroStacks} \n");

      }
    }

    if(foe.id != 0) {
      if(foe.heroStacks.isNotEmpty) {
        if(foe.heroStacks[0].id == event.stackId) {
          heroToReturn = foe;
        }
      } else {
        await defaultData.createFriendFoeHeroes();
        for (var element in defaultData.friendFoeList) {
          if(element.id == foe.id) {
            foe = element;
          }
        }
        if(foe.heroStacks[0].id == event.stackId) {
          heroToReturn = foe;
        }
        print("FriendFoeBodyBloc _onInit friend.id == ${foe.id}. friend.heroStacks was Empty == ${foe.heroStacks} \n");

      }
    }

    emit(FriendFoeBodySuccessActionState(heroToReturn, friendAlreadyPlayed));
*/

/*

    if (event.stackId == 0) {
      //var friendFoeList = await db.getFriendFoeStacks();
      var stackList = await db.getAvailableStacks();
      if (stackList.isNotEmpty) {
        for (var element in stackList) {
          if (element.stackType == StackType.friendFoe) {
            if (element.stackColor == const Color.fromARGB(255, 33, 150, 243) &&
                friend.id != 0) {
              friendAlreadyPlayed = CardsStack(
                id: element.id,
                name: element.name,
                isActive: true,
                stackType: StackType.friendFoe,
                stackColor: element.stackColor,
                cards: [],
              );
              friend = defaultData.getHeroByStackId(element.id);
              print("FriendFoeBodyBloc _onInit friend.id == ${friend.id}. friend.heroStacks == ${friend.heroStacks} \n");
              if (friend.heroStacks.isNotEmpty) {
                if (friend.heroStacks[0].cards.isEmpty) {
                  friend.heroStacks[0] = await db.getStackById(element.id);
                }
              } else {
                friend.heroStacks.add(await db.getStackById(element.id));
                 print("FriendFoeBodyBloc _onInit friend.id == ${friend.id}. friend.heroStacks. was Empty == ${friend.heroStacks} \n");
              }
            } else if (element.stackColor ==
                    const Color.fromARGB(255, 244, 67, 54) &&
                foe.id != 0) {
              foeAlreadyPlayed = CardsStack(
                id: element.id,
                name: element.name,
                isActive: true,
                stackType: StackType.friendFoe,
                stackColor: element.stackColor,
                cards: [],
              );
              foe = defaultData.getHeroByStackId(element.id);
               print("FriendFoeBodyBloc _onInit foe.id == ${friend.id}. foe.heroStacks == ${friend.heroStacks} \n");
              if (foe.heroStacks.isNotEmpty) {
                if (foe.heroStacks[0].cards.isEmpty) {
                  foe.heroStacks[0] = await db.getStackById(element.id);
                }
              } else {
                foe.heroStacks.add(await db.getStackById(element.id));
                 print("FriendFoeBodyBloc _onInit foe.id == ${friend.id}. foe.heroStacks was Empty == ${friend.heroStacks} \n");
              }
            }
          }
        }
      }
      print("FriendFoeBodyBloc _onInit event.stackId == 0 \n"
          "friend == $friend , foe == $foe \n");
    } else {
      print("FriendFoeBodyBloc _onInit event.stackId != 0 \n");
      var stackFromDB = await db.getStackById(event.stackId);
      if (friend.id > 0 && foe.id > 0) {
        if (friend.heroStacks[0].cards.isEmpty &&
            stackFromDB.stackColor == const Color.fromARGB(255, 33, 150, 243)) {
          friend.heroStacks[0] = stackFromDB;
          friendAlreadyPlayed = const CardsStack.empty();
        }
        if (foe.heroStacks[0].cards.isEmpty &&
            stackFromDB.stackColor == const Color.fromARGB(255, 244, 67, 54)) {
          foe.heroStacks[0] = stackFromDB;
          foeAlreadyPlayed = const CardsStack.empty();
        }
        print("FriendFoeBodyBloc _onInit event.stackId != 0 "
            "friend.id == ${friend.id} foe.id == ${foe.id} \n");
      } else {
        var hero = defaultData.getHeroByStackId(event.stackId);
        if(hero.heroStacks.isEmpty) {
          hero.heroStacks.add(await db.getStackById(event.stackId));
        }
          if(hero.heroStacks[0].stackColor == const Color.fromARGB(255, 33, 150, 243)) {
            friend = hero;
          } else {
            foe = hero;
          }
        print(
            "FriendFoeBodyBloc _onInit event.stackId != 0 friend.id == 0 || foe.id == 0 \n");
      }

      print("FriendFoeBodyBloc _onInit event.stackId != 0 \n");
    }

    if (event.stackId == friend.heroStacks[0].id) {
      print(
          "FriendFoeBodyBloc _onInit event.stackId == friend.heroStacks[0].id \n");
      emit(FriendFoeBodySuccessActionState(friend, friendAlreadyPlayed));
    } else {
      print(
          "FriendFoeBodyBloc _onInit event.stackId == foe.heroStacks[0].id \n");
      emit(FriendFoeBodySuccessActionState(foe, foeAlreadyPlayed));
    }
*/
    // print("FriendFoeBodyBloc _onInit event.heroId == ${event.heroId} \n");
    // friendStack = database.getActiveFriendStack();
    // print("FriendFoeBodyBloc _onInit friendStack.cards == ${friendStack.cards} \n");
    // if(friendStack.id != 0 && friendStack.cards.isNotEmpty) {
    //   print("FriendFoeBodyBloc _onInit friendStack.id != 0 && friendStack.cards.isNotEmpty \n");
    // friendAlreadyPlayed = CardsStack(
    //   id: friendStack.id,
    //   name: friendStack.name,
    //   isActive: true,
    //   stackType: StackType.friendFoe,
    //   stackColor: friendStack.stackColor,
    //     cards: [],
    //   );
    //   friendStack.cards.shuffle();
    // } else {
    //   database.setActiveFriendStack(friendStack.id);
    //   friendStack = database.getActiveFriendStack();
    //   friendStack.cards.shuffle();
    //   print("FriendFoeBodyBloc _onInit friend ELSE friendStack.cards == ${friendStack.cards} \n");
    // }
    // foeStack = database.getActiveFoeStack();
    // if(foeStack.id != 0 && foeStack.cards.isNotEmpty) {
    // foeAlreadyPlayed = CardsStack(
    //   id: foeStack.id,
    //   name: foeStack.name,
    //   isActive: true,
    //   stackType: StackType.friendFoe,
    //   stackColor: foeStack.stackColor,
    //   cards: [],
    // );
    // foeStack.cards.shuffle();
    // } else {
    //   database.setActiveFoeStack(foeStack.id);
    //   foeStack = database.getActiveFoeStack();
    //   foeStack.cards.shuffle();
    //   print("FriendFoeBodyBloc _onInit foe ELSE foeStack.cards == ${foeStack.cards} \n");
    // }

    // var stack = const CardsStack.empty();
    // var alreadyPlayed = const CardsStack.empty();
    // var hero = database.getHeroById(event.heroId);
    // print("FriendFoeBodyBloc _onInit HeroStack == $hero \n");
    // if(hero.id != 0) {
    // if(hero.heroStacks[0].id  == friendStack.id) {
    //   stack = friendStack;
    //   alreadyPlayed = friendAlreadyPlayed;
    // } else if (hero.heroStacks[0].id == foeStack.id) {
    //   stack = foeStack;
    //   alreadyPlayed = foeAlreadyPlayed;
    // } else {
    //   print(
    //       "FriendFoeBodyBloc _onInit event.heroId != 0 != friendStack.id != foeStack.id \n");
    // }
    //   //stack.cards.shuffle();
    // }

    //emit(FriendFoeBodySuccessActionState(stack, alreadyPlayed));
  }

  _onNext(
      FriendFoeBodyNextEvent event, Emitter<FriendFoeBodyState> emit) async {
    // Handle the next event

    if (event.heroId == friend.id) {
      friendAlreadyPlayed.cards.add(friend.heroStacks[0].cards.last);
      friend.heroStacks[0].cards.removeLast();
      emit(FriendFoeBodySuccessActionState(friend, friendAlreadyPlayed));
    }
    if (event.heroId == foe.id) {
      foeAlreadyPlayed.cards.add(foe.heroStacks[0].cards.last);
      foe.heroStacks[0].cards.removeLast();
      emit(FriendFoeBodySuccessActionState(foe, foeAlreadyPlayed));
    }

    // var newStack = CardsStack.empty();
    // var newAlreadyPlayed = CardsStack.empty();

    // if (friendStack.cards.isEmpty) {
    //   friendStack = await db.getStackById(friendStack.id);
    //   friendAlreadyPlayed = CardsStack(
    //     id: friendStack.id,
    //     name: friendStack.name,
    //     isActive: true,
    //     stackType: StackType.friendFoe,
    //     stackColor: friendStack.stackColor,
    //     cards: [],
    //   );
    //   friendStack.cards.shuffle();
    // }
    // if (foeStack.cards.isEmpty) {
    //   foeStack = await db.getStackById(foeStack.id);
    //   foeAlreadyPlayed = CardsStack(
    //     id: foeStack.id,
    //     name: foeStack.name,
    //     isActive: true,
    //     stackType: StackType.friendFoe,
    //     stackColor: foeStack.stackColor,
    //     cards: [],
    //   );
    //   foeStack.cards.shuffle();
    // }

    // print("FriendFoeBodyBloc _onNext event.heroId == ${event.heroId} \n");
    // var hero = HeroStack(
    //     id: 0,
    //     name: "",
    //     isFriend: true,
    //     heroStacks: [],
    //     energyClosetCount: 0,
    //     ability: "");
    // if (defaultData.friendFoeList.isNotEmpty) {
    //   for (var element in defaultData.friendFoeList) {
    //     if (event.heroId == element.id) {
    //       hero = element;
    //       print(
    //           "FriendFoeBodyBloc _onNext event.heroId == ${event.heroId} hero == $hero \n");
    //     }
    //   }
    // }
    // print("FriendFoeBodyBloc _onNext hero == $hero \n");
    // if (hero.id != 0) {
    //   if (hero.heroStacks[0].id == friendStack.id) {
    //     print("FriendFoeBodyBloc _onNext event.heroId == friendStack.id \n");
    //     friendAlreadyPlayed.cards.add(friendStack.cards.last);
    //     friendStack.cards.removeLast();
    //     newStack = friendStack;
    //     newAlreadyPlayed = friendAlreadyPlayed;
    //   } else if (hero.heroStacks[0].id == foeStack.id) {
    //     print("FriendFoeBodyBloc _onNext event.heroId == foeStack.id \n");
    //     foeAlreadyPlayed.cards.add(foeStack.cards.last);
    //     foeStack.cards.removeLast();
    //     newStack = foeStack;
    //     newAlreadyPlayed = foeAlreadyPlayed;
    //   } else {
    //     print(
    //         "FriendFoeBodyBloc _onNext event.heroId != 0 != friendStack.id != foeStack.id \n");
    //   }
    // } else {
    //   print("FriendFoeBodyBloc _onNext localHero.id == 0 \n");
    // }

    // print("FriendFoeBodyBloc _onNext event.heroId == ${event.heroId} \n"
    //     "newStack == $newStack \n alreadyPlayed == $newAlreadyPlayed \n");

    // emit(FriendFoeBodySuccessActionState(newStack, newAlreadyPlayed));
  }

  _onChangeActiveStack(FriendFoeChangeActiveStackEvent event,
      Emitter<FriendFoeBodyState> emit) async {
    // Handle the change active stack event
    //var stack = database.getStackById(event.id);
    print("FriendFoeBodyBloc _onChangeActiveStack event.id == ${event.id} \n");
    //var stack = const CardsStack.empty();
    var alreadyPlayed = const CardsStack.empty();
    emit(FriendFoeBodySuccessActionState(
        const HeroStack.empty(), alreadyPlayed));
  }
}
