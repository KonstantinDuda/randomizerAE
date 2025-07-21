import 'package:equatable/equatable.dart';

// Events
class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistoryGetEvent extends HistoryEvent {}

class HistoryGetCardEvent extends HistoryEvent {
  final int cardId;

  const HistoryGetCardEvent(this.cardId);

  @override
  List<Object> get props => [cardId];
}

class HistoryClearEvent extends HistoryEvent {}

// States
class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistorySuccessState extends HistoryState {
  final List<List<String>> story;
  final List<String> columns;

  const HistorySuccessState([this.columns = const [], this.story = const []]);

  @override
  List<Object> get props => [columns, story];
}

class HistoryErrorState extends HistoryState {
  final String error;

  const HistoryErrorState(this.error);

  @override
  List<Object> get props => [error];
}