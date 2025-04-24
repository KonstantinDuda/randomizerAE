import 'package:equatable/equatable.dart';

import '../../database/cards_stack.dart';

// Events
class RootBodyEvent extends Equatable {
  const RootBodyEvent();

  @override
  List<Object> get props => [];
}

class RootBodyNextEvent extends RootBodyEvent {
  const RootBodyNextEvent();
}

class RootBodyDelWildEvent extends RootBodyEvent {
  const RootBodyDelWildEvent();
}

class RootBodyShuffleEvent extends RootBodyEvent {
  const RootBodyShuffleEvent();
}

class RootBodyChangeSequenceEvent extends RootBodyEvent {
  const RootBodyChangeSequenceEvent();
}

// States
class RootBodyState extends Equatable {
  const RootBodyState();

  @override
  List<Object> get props => [];
}

class RootBodySuccessActionState extends RootBodyState {
  final CardsStack stack;
  final CardsStack alreadyPlayed;

  const RootBodySuccessActionState([
    this.stack = const CardsStack.empty(), 
    this.alreadyPlayed = const CardsStack.empty()]);

  @override
  List<Object> get props => [stack, alreadyPlayed];
}

class RootBodyErrorActionState extends RootBodyState {
  const RootBodyErrorActionState();
}