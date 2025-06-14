import 'package:equatable/equatable.dart';

import '../../database/cards_stack.dart';

// Events
// Cards
class CRUDStackEvent extends Equatable {
  const CRUDStackEvent();

  @override
  List<Object> get props => [];
}

class CRUDStackInitialEvent extends CRUDStackEvent {}

class CRUDStackNewCardEvent extends CRUDStackEvent {
  //final AECard card;
  final int id;
  final String name;
  final bool isOptional;
  final String textBeforeOr;
  final String textAfterOr;
  final String type;

  const CRUDStackNewCardEvent(this.id, this.name, this.isOptional, this.textBeforeOr,
      this.textAfterOr, this.type);

  @override
  List<Object> get props => [id, name, isOptional, textBeforeOr, textAfterOr, type];
}

class CRUDStackUpdateAvailableListEvent extends CRUDStackEvent {
  final List<int> id;
  const CRUDStackUpdateAvailableListEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CRUDStackDeleteCardEvent extends CRUDStackEvent {
  final int id;
  const CRUDStackDeleteCardEvent(this.id);

  @override
  List<Object> get props => [id];
}

// Stacks
class CRUDStackNewStackEvent extends CRUDStackEvent {
  final CardsStack stack;
  const CRUDStackNewStackEvent(this.stack);

  @override
  List<Object> get props => [stack];
}

class CRUDStackUpdateStackEvent extends CRUDStackEvent {
  final CardsStack stack;
  const CRUDStackUpdateStackEvent(this.stack);

  @override
  List<Object> get props => [stack];
}

class CRUDStackDeleteStackEvent extends CRUDStackEvent {
  final int id;
  const CRUDStackDeleteStackEvent(this.id);

  @override
  List<Object> get props => [id];
}

// States
class CRUDStackState extends Equatable {
  const CRUDStackState();

  @override
  List<Object> get props => [];
}

class CRUDStackSuccessActionState extends CRUDStackState {
  final List<AECard> cards;
  final List<CardsStack> stacks;

  const CRUDStackSuccessActionState(
      [this.cards = const [], this.stacks = const []]);

  @override
  List<Object> get props => [cards, stacks];
}

class CRUDStackErrorActionState extends CRUDStackState {
  const CRUDStackErrorActionState();
}
