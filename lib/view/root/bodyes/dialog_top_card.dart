import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/bloc/turn_order_body_bloc.dart';
import 'package:randomizer_new/database/cards_stack.dart';

import '../../../bloc/event_state/turn_order_body_es.dart';

class TopCardDialog extends StatefulWidget {
  final List<AECard> list;
  final int id;

  const TopCardDialog({
    super.key,
    required this.list,
    required this.id,
  });

  @override
  State<TopCardDialog> createState() => _TopCardDialogState();
}

class _TopCardDialogState extends State<TopCardDialog> {

  List<AECard> newSequance = [];
  late AECard topCard;
  late int topCardIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    newSequance = widget.list;
    for (var i = 0; i < newSequance.length; i++) {
      if (newSequance[i].id == widget.id) {
        topCard = newSequance[i];
        topCardIndex = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('The top card '),
      content: Container(
        height: 300,
        width: 90,
        alignment: Alignment.center,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:Colors.black,
              width: 2,
            ),
          ),
          child: Text(
            topCard.text,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      actions: [
        TextButton(
          onPressed: () {
            print("Dialog_Top_Card newSequance BEFORE changes == $newSequance");
            newSequance.removeAt(topCardIndex);
            newSequance.insert(0, topCard);
            print("Dialog_Top_Card newSequance AFTER changes == $newSequance");
            context.read<TurnOrderBodyBloc>().add(
              TurnOrderBodyChangeSequenceEvent(
                newSequance
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text('On Bottom'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('On Top'),
        ),
      ],
    );
  }
}