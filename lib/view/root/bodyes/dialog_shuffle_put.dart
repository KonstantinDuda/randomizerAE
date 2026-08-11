import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_state/turn_order_body_es.dart';
import '../../../bloc/turn_order_body_bloc.dart';

class ShufflePutBackDialog extends StatelessWidget {
  final int stackId;
  final String text;
  const ShufflePutBackDialog(this.stackId, this.text, {super.key});

  Widget _button(String text, VoidCallback onPressed, BuildContext context,
      String navigation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
            onPressed();
            Navigator.of(context).pop(navigation);
          },
          child: Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Shuffle or put "$text" in the bottom?'),
      //content: const Text('Do you want to shuffle the deck and put the card back?'),
      actions: [
        _button(
            'Shuffle card in stack',
            () => context
                .read<TurnOrderBodyBloc>()
                .add(TurnOrderBodyShuffleInStackEvent(stackId, text)),
            context,
            ""),
        _button(
            'Put card in the bottom',
            () => context
                .read<TurnOrderBodyBloc>()
                .add(TurnOrderBodyPutInButtom(stackId, text)),
            context,
            ""),
        _button('Link card to Stack', () {}, context, "link")
      ],
    );
  }
}
