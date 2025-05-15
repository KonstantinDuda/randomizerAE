import 'package:equatable/equatable.dart';

import '../../database/cards_stack.dart';

// Events
class FriendFoeBodyEvent extends Equatable {
  const FriendFoeBodyEvent();

  @override
  List<Object> get props => [];
}

class FriendFoeBodyNextEvent extends FriendFoeBodyEvent {
  final int heroId;
  const FriendFoeBodyNextEvent(this.heroId);

  @override
  List<Object> get props => [heroId];
}

class FriendFoeChangeActiveStackEvent extends FriendFoeBodyEvent {
  final int id;
  const FriendFoeChangeActiveStackEvent(this.id);

  @override
  List<Object> get props => [id];
}

// States
class FriendFoeBodyState extends Equatable {
  const FriendFoeBodyState();

  @override
  List<Object> get props => [];
}

class FriendFoeBodySuccessActionState extends FriendFoeBodyState {
  final CardsStack stack;
  final CardsStack alreadyPlayed;

  const FriendFoeBodySuccessActionState([
    this.stack = const CardsStack.empty(), 
    this.alreadyPlayed = const CardsStack.empty()]);

  @override
  List<Object> get props => [stack, alreadyPlayed];
}

class FriendFoeBodyClearScreenState extends FriendFoeBodyState {
  const FriendFoeBodyClearScreenState();
}

class FriendFoeBodyErrorActionState extends FriendFoeBodyState {
  const FriendFoeBodyErrorActionState();
}