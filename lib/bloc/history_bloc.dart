import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/cards_stack.dart';
import '../database/default_data.dart';
import 'event_state/history_es.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final defaultData = DefaultData();

  List<List<String>> story = [];
  List<String> columns = [];
  //int turns = 0;

  HistoryBloc() : super(const HistorySuccessState()) {
    on<HistoryGetEvent>(_getHistory);
    on<HistoryGetCardEvent>(_getCardHistory);
    on<HistoryClearEvent>(_clearHistory);
  }

  void _getHistory(HistoryGetEvent event, Emitter<HistoryState> emit) async {
    print("HistoryBloc getHistory");

    try {
      var allData = defaultData.story;
      //print("HistoryBloc _getHistory: allData == $allData.");

      List<List<String>> storyToReturn = [];
      List<String> columnsToReturn = [];
      int maxLength = 0;

      if (allData.isEmpty) {
        print("HistoryBloc _getHistory: allData is empty.");
        emit(const HistorySuccessState([], []));
        return;
      } else {
        List<String> turnList = [];
        for (var i = 0; i < allData.length; i++) {
          for (var j = 0; j < allData[i].length; j++) {
            turnList.add(allData[i][j].text);
          }
          if (allData[i].length > maxLength) {
            maxLength = allData[i].length;
            List<AECard> sortedCards = allData[i];
            List<AECard> beforeSortedCards = allData[i];
            sortedCards.sort((a, b) => a.text.compareTo(b.text));
            columnsToReturn = sortedCards.map((e) => e.text).toList();
            allData.removeAt(i);
            allData.insert(i, beforeSortedCards);
          }
          storyToReturn.add(turnList);
          turnList = [];
        }
      }

      for (var element in storyToReturn) {
        if (element.length < maxLength) {
          // Fill missing cells with empty strings
          element.addAll(List.generate(maxLength - element.length, (_) => ""));
        }
      }

      story = storyToReturn;
      columns = columnsToReturn;

      emit(HistorySuccessState(columnsToReturn, storyToReturn));
    } catch (e) {
      print("HistoryBloc getHistory error: $e");
      emit(HistoryErrorState(e.toString()));
    }
  }

  void _getCardHistory(
      HistoryGetCardEvent event, Emitter<HistoryState> emit) async {
    print("HistoryBloc getCardHistory event: ${event.cardId}");
  }

  void _clearHistory(
      HistoryClearEvent event, Emitter<HistoryState> emit) async {
    print("HistoryBloc clearHistory");

    defaultData.story.clear();
    story.clear();
    columns.clear();

    emit(const HistorySuccessState([], []));
  }
}
