import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/cards_stack.dart';
import '../database/default_data.dart';
import 'event_state/hero_es.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  final defaultData = DefaultData();

  int index = 0;
  List<HeroStack> heroes = [];
  var newHero = const HeroStack.empty();

  HeroBloc() : super(const HeroSuccessState(0, const HeroStack.empty())) {
    on<HeroInitEvent>(_onInit);
    on<HeroNextPrevEvent>(_changeHero);
    on<HeroCreateEvent>(_createHero);
    on<HeroSaveEvent>(_saveHero);
    on<HeroDeleteEvent>(_deleteHero);
    on<HeroChangeStackEvent>(_changeStack);
  }

  _onInit(HeroInitEvent event, Emitter<HeroState> emit) async {
    heroes = await defaultData.getHeroes();
     print("HeroBloc/ _onInit: heroes.length == ${heroes.length}");
    emit(HeroSuccessState(index, heroes[index]));
  }

  _changeHero(HeroNextPrevEvent event, Emitter<HeroState> emit) {
    print("HeroBloc: _changeHero event: ${event.index}");

    var heroToReturn = const HeroStack.empty();
    index = event.index;
    var newHeroId = heroes.last.id + 1;
    if (index == heroes.length) {
      heroToReturn = HeroStack(
          id: newHeroId,
          name: "",
          isFriend: true,
          heroStack: const CardsStack.empty(),
          energyClosetCount: 0,
          ability: "");
    } else if (index > heroes.length) {
      index = 0;
      heroToReturn = heroes[0];
    } else {
      heroToReturn = heroes[index];
    }
    print("HeroBloc: Returning hero at index $index: ${heroToReturn.name}");
    emit(HeroSuccessState(index, heroToReturn));
  }

  _createHero(HeroCreateEvent event, Emitter<HeroState> emit) {
    print("HeroBloc: Creating Hero event");

    var newHeroId = heroes.last.id + 1;
    var heroToReturn = HeroStack(
          id: newHeroId,
          name: "",
          isFriend: true,
          heroStack: const CardsStack.empty(),
          energyClosetCount: 0,
          ability: "");
    index = heroes.length;

    emit(HeroSuccessState(index, heroToReturn));
  }

  _saveHero(HeroSaveEvent event, Emitter<HeroState> emit) async {
    print("HeroBloc/ _saveHero: event.hero.id ${event.hero.id}");
    var dDHeroes = await defaultData.getHeroes();
    print("HeroBloc/ _saveHero: dDHeroes.length == ${dDHeroes.length}");
    int index = dDHeroes.indexWhere((hero) => hero.id == event.hero.id);
    print("HeroBloc/ _saveHero: index == $index");
    if (index != -1) {
      //heroes[index] = event.heroStack;
      if (event.hero.name == heroes[index].name &&
          event.hero.isFriend == heroes[index].isFriend &&
          event.hero.energyClosetCount == heroes[index].energyClosetCount &&
          event.hero.heroStack.id == heroes[index].heroStack.id &&
          event.hero.ability == heroes[index].ability &&
          event.hero.feature == heroes[index].feature &&
          event.hero.description == heroes[index].description) {
        print("HeroBloc: No changes detected, not updating hero");
        return; // No changes, do not update
      } else {
        print("HeroBloc/ _saveHero: Update hero with id == ${event.hero.id}");
        defaultData.updateHero(event.hero.id, event.hero);
      }
    } else {
      index = 0;
      print("HeroBloc/ _saveHero: Hero with id ${event.hero.id} not found for update. \n"
            "Create new Hero: ${event.hero.name}");
      await defaultData.newHero(event.hero);
    }
    emit(HeroSuccessState(index, heroes[index]));
  }

  _deleteHero(HeroDeleteEvent event, Emitter<HeroState> emit) async {
    print("HeroBloc: Deleting Hero with id ${event.id}");
    await defaultData.deleteHero(event.id);
    heroes = await defaultData.getHeroes();

index = 0;
    //heroes.removeWhere((hero) => hero.id == event.id);
    emit(HeroSuccessState(index, heroes[index]));
  }

  _changeStack(HeroChangeStackEvent event, Emitter<HeroState> emit) async {
    print(
        "HeroBloc/ _changeStack: Changing stack for hero ${event.hero.name} to stack ${event.stack.name}");
    int indexLocal = heroes.indexWhere((hero) => hero.id == event.hero.id);
    if (indexLocal == -1) {
      print("HeroBloc/ _changeStack: indexLocal == -1, creating new hero");
    var hero = HeroStack(
        id: event.hero.id,
        name: event.hero.name,
        isFriend: event.hero.isFriend,
        heroStack: event.stack,
        energyClosetCount: event.hero.energyClosetCount,
        ability: event.hero.ability,
        feature: event.hero.feature,
        description: event.hero.description);
    //heroes.add(hero);
    newHero = hero;
    index = heroes.length;
    print("HeroBloc/_changeStack: new hero == $newHero \n ");
    } else {
      print("HeroBloc/ _changeStack: Updating existing hero at index $indexLocal");
      heroes[indexLocal] = HeroStack(
        id: event.hero.id,
        name: event.hero.name,
        isFriend: event.hero.isFriend,
        heroStack: event.stack,
        energyClosetCount: event.hero.energyClosetCount,
        ability: event.hero.ability,
        feature: event.hero.feature,
        description: event.hero.description,
      );
      index = indexLocal;
      print("HeroBloc/_changeStack: Updated hero == ${heroes[indexLocal]} \n ");
    }

    // print("HeroBloc/_changeStack: Updated hero at index $index \n "
    // "(heroes[index].name == ${heroes[index].name})"
    
    // " with stack ${event.stack.name} \n" 
    //     "HeroBloc: Hero details: ${heroes[index].name}, ${heroes[index].isFriend}, \n"
    //     "${heroes[index].heroStack.name}, ${heroes[index].energyClosetCount}, \n"
    //     "${heroes[index].ability}, ${heroes[index].feature}, ${heroes[index].description}");

    

    emit(HeroSuccessState(index, newHero));
  }
}
