import 'package:card_randomizer/database/cards_stack.dart';
import 'package:card_randomizer/view/root/bodyes/my_card.dart';
import 'package:card_randomizer/view/root/dialogs/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_state/turn_order_body_es.dart';
import '../../../bloc/turn_order_body_bloc.dart';

class ShufflePutBackDialog extends StatelessWidget {
  final int stackId;
  final AECard card;
  const ShufflePutBackDialog(this.stackId, this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('What to do with "${card.name}"?'),
      //content: const Text('Do you want to shuffle the deck and put the card back?'),
      content: UnconstrainedBox(child: MyCard(card, const Size(200, 300))),
      actions: [
        dialogButton(
          //_button(
          'Place on TOP',
          () => context
              .read<TurnOrderBodyBloc>()
              .add(TurnOrderBodyPutOnTopEvent(stackId, card.name)),
          context,
        ),
        dialogButton(
          //_button(
          'SHUFFLE into the stack',
          () => context
              .read<TurnOrderBodyBloc>()
              .add(TurnOrderBodyShuffleInStackEvent(stackId, card.name)),
          context,
        ), //""),
        dialogButton('LINK the card to the stack', () {}, context,
            navigation: "link"),
        dialogButton(
          // _button(
          'Place at the BOTTOM',
          () => context
              .read<TurnOrderBodyBloc>()
              .add(TurnOrderBodyPutInButtomEvent(stackId, card.name)),
          context,
        ),
      ],
    );
  }
}
