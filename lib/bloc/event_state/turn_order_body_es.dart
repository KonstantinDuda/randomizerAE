import 'package:equatable/equatable.dart';

import '../../database/cards_stack.dart';

// Events
class TurnOrderBodyEvent extends Equatable {
  const TurnOrderBodyEvent();

  @override
  List<Object> get props => [];
}

class TurnOrderBodyNextEvent extends TurnOrderBodyEvent {
  const TurnOrderBodyNextEvent();
}

class TurnOrderBodyDelWildEvent extends TurnOrderBodyEvent {
  const TurnOrderBodyDelWildEvent();
}

class TurnOrderBodyShuffleEvent extends TurnOrderBodyEvent {
  const TurnOrderBodyShuffleEvent();
}

class TurnOrderBodyChangeSequenceEvent extends TurnOrderBodyEvent {
  const TurnOrderBodyChangeSequenceEvent();
}

class TurnOrderBodyChangeActiveStackEvent extends TurnOrderBodyEvent {
  final int id;
  const TurnOrderBodyChangeActiveStackEvent(this.id);

  @override
  List<Object> get props => [id];
}

class TurnOrderBodyChangeAvailableStackListEvent extends TurnOrderBodyEvent {
  final List<CardsStack> newList;

  const TurnOrderBodyChangeAvailableStackListEvent(
    [this.newList = const []]);

  @override
  List<Object> get props => [newList];
}

// States
class TurnOrderBodyState extends Equatable {
  const TurnOrderBodyState();

  @override
  List<Object> get props => [];
}

class TurnOrderBodySuccessActionState extends TurnOrderBodyState {
  final CardsStack stack;
  final CardsStack alreadyPlayed;

  const TurnOrderBodySuccessActionState([
    this.stack = const CardsStack.empty(), 
    this.alreadyPlayed = const CardsStack.empty()]);

  @override
  List<Object> get props => [stack, alreadyPlayed];
}

class TurnOrderBodyClearScreenState extends TurnOrderBodyState {
  const TurnOrderBodyClearScreenState();
}

class TurnOrderBodyErrorActionState extends TurnOrderBodyState {
  const TurnOrderBodyErrorActionState();
}