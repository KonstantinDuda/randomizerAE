import 'package:equatable/equatable.dart';

import '../../database/cards_stack.dart';

// Events
class TurnOrderBodyEvent extends Equatable {
  const TurnOrderBodyEvent();

  @override
  List<Object> get props => [];
}

class TurnOrderInitialEvent extends TurnOrderBodyEvent {}

class TurnOrderBodyNextEvent extends TurnOrderBodyEvent {
  final int id;
  const TurnOrderBodyNextEvent(this.id);

  @override
  List<Object> get props => [id];
}

class TurnOrderBodyDelWildEvent extends TurnOrderBodyEvent {
  const TurnOrderBodyDelWildEvent();
}

class TurnOrderBodyShuffleEvent extends TurnOrderBodyEvent {
  final int stackId;
  const TurnOrderBodyShuffleEvent(this.stackId);

  @override
  List<Object> get props => [stackId];
}

class TurnOrderBodyShuffleInStackEvent extends TurnOrderBodyEvent {
  final int stackId;
  final String text;
  const TurnOrderBodyShuffleInStackEvent(this.stackId, this.text);

  @override
  List<Object> get props => [stackId, text];
}

class TurnOrderBodyPutInButtom extends TurnOrderBodyEvent {
  final int stackId;
  final String text;
  const TurnOrderBodyPutInButtom(this.stackId, this.text);

  @override
  List<Object> get props => [stackId, text];
}

class TurnOrderBodyChangeSequenceEvent extends TurnOrderBodyEvent {
  final int stackId;
  final List<AECard> list;

  const TurnOrderBodyChangeSequenceEvent(this.stackId, [this.list = const []]);

  @override
  List<Object> get props => [stackId, list];
}

class TurnOrderBodyChangeActiveStackEvent extends TurnOrderBodyEvent {
  final int stackId;
  const TurnOrderBodyChangeActiveStackEvent(this.stackId);

  @override
  List<Object> get props => [stackId];
}

class TurnOrderBodyDiscardEvent extends TurnOrderBodyEvent {
  final String name;
  final List<String> list;
  final bool isDiscard;
  //final int stackId;
  const TurnOrderBodyDiscardEvent(
    this.name,
    this.list,
    this.isDiscard,
    /*this.stackId*/
  );

  @override
  List<Object> get props => [
        name,
        list,
        isDiscard, /*stackId*/
      ];
}

class TurnOrderAddDeleteStackEvent extends TurnOrderBodyEvent {
  final List<int> ids;

  const TurnOrderAddDeleteStackEvent(this.ids);

  @override
  List<Object> get props => [ids];
}

class TurnOrderBodyClearStackHistoryEvent extends TurnOrderBodyEvent {
  final int stackId;

  const TurnOrderBodyClearStackHistoryEvent(this.stackId);

  @override
  List<Object> get props => [stackId];
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
  final List<CardsStack> allStacks;
  final Map<String, int> links;

  const TurnOrderBodySuccessActionState(
      [this.stack = const CardsStack.empty(),
      this.alreadyPlayed = const CardsStack.empty(),
      this.allStacks = const [],
      this.links = const {}]);

  @override
  List<Object> get props => [stack, alreadyPlayed, allStacks, links];
}

// class TurnOrderBodyClearScreenState extends TurnOrderBodyState {
//   const TurnOrderBodyClearScreenState();
// }

class TurnOrderBodyErrorActionState extends TurnOrderBodyState {
  const TurnOrderBodyErrorActionState();
}
