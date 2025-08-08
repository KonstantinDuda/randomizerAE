import 'package:equatable/equatable.dart';

import '../../database/cards_stack.dart';

class HeroEvent extends Equatable {
  const HeroEvent();

  @override
  List<Object?> get props => [];
}

class HeroInitEvent extends HeroEvent {}

class HeroCreateEvent extends HeroEvent {
  final HeroStack heroStack;

  const HeroCreateEvent(this.heroStack);

  @override
  List<Object?> get props => [heroStack];
}

class HeroUpdateEvent extends HeroEvent {
  final int id;
  final HeroStack heroStack;

  const HeroUpdateEvent(this.id, this.heroStack);

  @override
  List<Object?> get props => [id, heroStack];
}

class HeroDeleteEvent extends HeroEvent {
  final int id;

  const HeroDeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class HeroState extends Equatable {
  const HeroState();

  @override
  List<Object?> get props => [];
}

class HeroSuccessState extends HeroState {
  final List<HeroStack> heroStacks;

  const HeroSuccessState(this.heroStacks);

  @override
  List<Object?> get props => [heroStacks];
}

class HeroErrorState extends HeroState {
  final String error;

  const HeroErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

