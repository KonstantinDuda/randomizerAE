import 'package:equatable/equatable.dart';

import '../../database/cards_stack.dart';

// Events
class HeroEvent extends Equatable {
  const HeroEvent();

  @override
  List<Object?> get props => [];
}

class HeroInitEvent extends HeroEvent {}

class HeroNextPrevEvent extends HeroEvent {
  final int index;

  const HeroNextPrevEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class HeroCreateEvent extends HeroEvent {}

class HeroSaveEvent extends HeroEvent {
  final HeroStack hero;

  const HeroSaveEvent(this.hero);

  @override
  List<Object?> get props => [hero];
}

class HeroDeleteEvent extends HeroEvent {
  final int id;

  const HeroDeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class HeroChangeStackEvent extends HeroEvent {
  final HeroStack hero;
  final CardsStack stack;

  const HeroChangeStackEvent(this.hero, this.stack);

  @override
  List<Object?> get props => [hero, stack];
}

// States
class HeroState extends Equatable {
  const HeroState();

  @override
  List<Object?> get props => [];
}

class HeroSuccessState extends HeroState {
  final int index;
  final HeroStack heroStack;

  const HeroSuccessState(this.index, this.heroStack);

  @override
  List<Object?> get props => [index, heroStack];
}

class HeroErrorState extends HeroState {
  final String error;

  const HeroErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

