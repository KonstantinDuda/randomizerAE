import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/event_state/history_es.dart';
import '../bloc/event_state/turn_order_body_es.dart';
import '../bloc/providers/provider_bloc.dart';
import '../bloc/history_bloc.dart';
import '../bloc/turn_order_body_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        List<String> columns = [];
        //int stepCount = 0;
        List<List<String>> rows = [];
        String text = "";

        List<DataColumn> columnWidgets = [];
        List<DataRow> rowWidgets = [];

        if (state is HistorySuccessState) {
          //text = state.story;
          if (state.columns.isNotEmpty) {
            columns = state.columns;
          }
          if (state.story.isNotEmpty) {
            rows = state.story;
            for (var i = 0; i < rows.length; i++) {
              if (rows[i].length < columns.length) {
                print(
                    "HistoryPage: row $i has ${rows[i].length} cells, but columns has ${columns.length} cells.");
                // Fill missing cells with empty strings
                rows[i].addAll(
                    List.generate(columns.length - rows[i].length, (_) => ""));
              }
            }
          }
        } else if (state is HistoryErrorState) {
          text = state.error;
        }

        _listColumns() {
          print("HistoryPage _listColumns $columns");
          for (var i = 0; i < columns.length; i++) {
            columnWidgets.add(
              DataColumn(
                label: Text(
                  "Step ${i + 1}",
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 18),
                ),
              ),
            );
          }
          return columnWidgets;
        }

        _listRows() {
          print("HistoryPage _listRows $rows");
          for (var i = 0; i < rows.length; i++) {
            List<DataCell> cells = [];
            for (var cell in rows[i]) {
              cells.add(
                DataCell(
                  Text(
                    cell,
                    //style: TextStyle(backgroundColor: i % 2 == 0 ? Colors.grey[200] : Colors.white),
                  ),
                ),
              );
            }
            rowWidgets.add(DataRow(
                cells: cells,
                color: i % 2 == 0
                    ? WidgetStateProperty.all(Colors.grey[200])
                    : WidgetStateProperty.all(Colors.white)));
          }
          return rowWidgets;
        }

        if (text.isNotEmpty || columns.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('History Page'),
                  ElevatedButton(
                    child: const Icon(Icons.arrow_back),
                    onPressed: () =>
                        context.read<ProviderBloc>().add(RootEvent()),
                  ),
                ],
              ),
            ),
            body: const Center(
              child: Text(
                'This is the History Page. \n History is Epmty now.',
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('History Page'),
                  ElevatedButton(
                    child: const Icon(Icons.arrow_back),
                    onPressed: () =>
                        context.read<ProviderBloc>().add(RootEvent()),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: _listColumns(),
                  //columns.map((col) => DataColumn(label: Text(col, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 20),))).toList(),
                  rows: _listRows(),
                  // rows.map((row) => DataRow(
                  //         cells:
                  //             row.map((cell) => DataCell(Text(cell))).toList(),
                  //       ))
                  //   .toList(),
                ),
              ),
            ),
            floatingActionButton: ElevatedButton(
              onPressed: () {
                columns.clear();
                rows.clear();
                context.read<HistoryBloc>().add(HistoryClearEvent());
                context.read<TurnOrderBodyBloc>().add(TurnOrderInitialEvent());
                context.read<ProviderBloc>().add(RootEvent());
            }, 
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black,
              ),
            child: const Text("Clear the story"),
            ),
          );
        }
      },
    );
  }
}
