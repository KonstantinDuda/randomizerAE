import 'package:equatable/equatable.dart';

import '../../database/cards_stack.dart';

// Events
  // Cards
class CreateStackEvent extends Equatable {
  const CreateStackEvent();

  @override
  List<Object> get props => [];
}

class CreateStackInitialEvent extends CreateStackEvent {}

class CreateStackNewCardEvent extends CreateStackEvent {
  final AECard card;
  const CreateStackNewCardEvent(this.card);

  @override
  List<Object> get props => [card];
}

class CreateStackUpdateCardEvent extends CreateStackEvent {
  final AECard card;
  const CreateStackUpdateCardEvent(this.card);

  @override
  List<Object> get props => [card];
}

class CreateStackDeleteCardEvent extends CreateStackEvent {
  final int id;
  const CreateStackDeleteCardEvent(this.id);

  @override
  List<Object> get props => [id];
}

  // Stacks
class CreateStackNewStackEvent extends CreateStackEvent {
  final CardsStack stack;
  const CreateStackNewStackEvent(this.stack);

  @override
  List<Object> get props => [stack];
}

class CreateStackUpdateStackEvent extends CreateStackEvent {
  final CardsStack stack;
  const CreateStackUpdateStackEvent(this.stack);

  @override
  List<Object> get props => [stack];
}

class CreateStackDeleteStackEvent extends CreateStackEvent {
  final int id;
  const CreateStackDeleteStackEvent(this.id);

  @override
  List<Object> get props => [id];
}

// States
class CreateStackState extends Equatable {
  const CreateStackState();

  @override
  List<Object> get props => [];
}

class CreateStackSuccessActionState extends CreateStackState {
  final List<AECard> cards;
  final List<CardsStack> stacks;

  const CreateStackSuccessActionState([
    this.cards = const [], 
    this.stacks = const []]);

  @override
  List<Object> get props => [cards, stacks];
}

class CreateStackErrorActionState extends CreateStackState {
  const CreateStackErrorActionState();
}
