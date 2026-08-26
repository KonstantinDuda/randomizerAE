import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_state/turn_order_body_es.dart';
import '../../../bloc/turn_order_body_bloc.dart';
import '../../../database/cards_stack.dart';
import '../bodyes/my_card.dart';
import 'dialog_button.dart';

class TopCardDialog extends StatefulWidget {
  final List<AECard> list;
  final int cardId;
  final int stackId;

  const TopCardDialog({
    super.key,
    required this.list,
    required this.cardId,
    required this.stackId,
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
    super.initState();

    newSequance = widget.list;
    for (var i = 0; i < newSequance.length; i++) {
      if (newSequance[i].id == widget.cardId) {
        topCard = newSequance[i];
        topCardIndex = i;
      }
    }
  }

  // Widget _button(String text, VoidCallback onPressed, BuildContext context) {
  //   return GestureDetector(
  //       child: Container(
  //         height: 40,
  //         margin: const EdgeInsets.only(bottom: 5),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           border: Border.all(
  //             color: Colors.black,
  //             width: 2,
  //           ),
  //         ),
  //         child: Center(
  //           child: Text(
  //             text,
  //             style: const TextStyle(color: Colors.black, fontSize: 18),
  //           ),
  //         ),
  //       ),
  //       onTap: () {
  //         onPressed();
  //         Navigator.of(context).pop();
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('The top card '),
      content: UnconstrainedBox(child: MyCard(topCard, const Size(200, 300))),
      actions: [
        /*_button*/ dialogButton("On top", () {}, context),
        /*_button*/ dialogButton("On bottom", () {
          newSequance.removeAt(topCardIndex);
          newSequance.insert(0, topCard);
          context.read<TurnOrderBodyBloc>().add(
                TurnOrderBodyChangeSequenceEvent(widget.stackId, newSequance),
              );
        }, context),
      ],
    );
  }
}
