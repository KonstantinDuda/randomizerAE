import 'package:card_randomizer/database/cards_stack.dart';
import 'package:card_randomizer/view/root/bodyes/my_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_state/turn_order_body_es.dart';
import '../../../bloc/turn_order_body_bloc.dart';

class ShufflePutBackDialog extends StatelessWidget {
  final int stackId;
  final AECard card;
  const ShufflePutBackDialog(this.stackId, this.card, {super.key});

  Widget _button(String text, VoidCallback onPressed, BuildContext context,
      String navigation) {
    return GestureDetector(
        child: Container(
          height: 40,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
        onTap: () {
          onPressed();
          Navigator.of(context).pop(navigation);
        });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Shuffle or put "${card.name}" in the bottom?'),
      //content: const Text('Do you want to shuffle the deck and put the card back?'),
      content: UnconstrainedBox(child: MyCard(card, const Size(200, 300))),
      actions: [
        _button(
            'SHUFFLE the card into the stack',
            () => context
                .read<TurnOrderBodyBloc>()
                .add(TurnOrderBodyShuffleInStackEvent(stackId, card.name)),
            context,
            ""),
        _button(
            'Place the card on TOP of the stack',
            () => context
                .read<TurnOrderBodyBloc>()
                .add(TurnOrderBodyPutOnTopEvent(stackId, card.name)),
            context,
            ""),
        _button(
            'Place the card at the BOTTOM of the stack',
            () => context
                .read<TurnOrderBodyBloc>()
                .add(TurnOrderBodyPutInButtomEvent(stackId, card.name)),
            context,
            ""),
        _button('LINK the card to the stack', () {}, context, "link"),
      ],
    );
  }
}
