import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/cards_stack.dart';
import '../database/default_data.dart';
import 'event_state/hero_es.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  final defaultData = DefaultData();

  List<HeroStack> heroes = [];

  HeroBloc() : super(const HeroSuccessState([])) {
    on<HeroInitEvent>(_onInit);
    on<HeroCreateEvent>(_createHero);
    on<HeroUpdateEvent>(_updateHero);
    on<HeroDeleteEvent>(_deleteHero);
  }


  _onInit(HeroInitEvent event, Emitter<HeroState> emit) async {
    print("HeroBloc: Initializing HeroBloc");
    heroes = await defaultData.getHeroes();
    emit(HeroSuccessState(heroes));
  }

  _createHero(HeroCreateEvent event, Emitter<HeroState> emit) {
    print("HeroBloc: Creating Hero event: ${event.heroStack}");
    //heroes.add(event.heroStack);
    defaultData.newHero(event.heroStack);
    heroes = defaultData.friendFoeList;
    emit(HeroSuccessState(heroes));
  }

  _updateHero(HeroUpdateEvent event, Emitter<HeroState> emit) {
    print("HeroBloc: Updating Hero with id ${event.id}");
    int index = heroes.indexWhere((hero) => hero.id == event.id);
    if (index != -1) {
      //heroes[index] = event.heroStack;
      defaultData.updateHero(event.id, event.heroStack);
      emit(HeroSuccessState(heroes));
    } else {
      emit(HeroErrorState("Hero with id ${event.id} not found"));
    }
  }

  _deleteHero(HeroDeleteEvent event, Emitter<HeroState> emit) {
    print("HeroBloc: Deleting Hero with id ${event.id}");
    heroes.removeWhere((hero) => hero.id == event.id);
    emit(HeroSuccessState(heroes));
  }
}

