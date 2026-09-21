import 'package:equatable/equatable.dart';

// Events
class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistoryGetEvent extends HistoryEvent {
  final int stackId;

  const HistoryGetEvent(this.stackId);

  @override
  List<Object> get props => [stackId];
}

class HistoryGetCardEvent extends HistoryEvent {
  final int cardId;

  const HistoryGetCardEvent(this.cardId);

  @override
  List<Object> get props => [cardId];
}

class HistoryClearEvent extends HistoryEvent {
  final int stackId;

  const HistoryClearEvent(this.stackId);

  @override
  List<Object> get props => [stackId];
}

// States
class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistorySuccessState extends HistoryState {
  final int stackId;
  final List<List<String>> story;
  final List<String> columns;

  const HistorySuccessState(this.stackId,
      [this.columns = const [], this.story = const []]);

  @override
  List<Object> get props => [stackId, columns, story];
}

class HistoryErrorState extends HistoryState {
  final String error;

  const HistoryErrorState(this.error);

  @override
  List<Object> get props => [error];
}
