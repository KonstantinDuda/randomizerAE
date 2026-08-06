import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_state/turn_order_body_es.dart';
import '../../../bloc/turn_order_body_bloc.dart';

class ShufflePutBackDialog extends StatelessWidget {
  final String text;
  const ShufflePutBackDialog(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Shuffle or put card in the bottom?'),
      //content: const Text('Do you want to shuffle the deck and put the card back?'),
      actions: [
        TextButton(
          onPressed: () {
            context
                .read<TurnOrderBodyBloc>()
                .add(TurnOrderBodyShuffleInStackEvent(text));
            Navigator.of(context).pop();
          },
          child: const Text('Suffle card in stack'),
        ),
        TextButton(
          onPressed: () {
            context
                .read<TurnOrderBodyBloc>()
                .add(TurnOrderBodyPutInButtom(text));
            Navigator.of(context).pop();
          },
          child: const Text('Put card in the bottom'),
        ),
      ],
    );
  }
}
