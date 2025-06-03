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
  final AECard card;
  const CRUDStackNewCardEvent(this.card);

  @override
  List<Object> get props => [card];
}

class CRUDStackUpdateCardEvent extends CRUDStackEvent {
  final AECard card;
  const CRUDStackUpdateCardEvent(this.card);

  @override
  List<Object> get props => [card];
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

  const CRUDStackSuccessActionState([
    this.cards = const [], 
    this.stacks = const []]);

  @override
  List<Object> get props => [cards, stacks];
}

class CRUDStackErrorActionState extends CRUDStackState {
  const CRUDStackErrorActionState();
}