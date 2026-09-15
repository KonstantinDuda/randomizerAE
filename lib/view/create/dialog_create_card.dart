import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../bloc/providers/provider_bloc.dart';
import '../../database/cards_stack.dart';
import '../root/dialogs/dialog_button.dart';

class CreateCardDialog extends StatefulWidget {
  final AECard card;

  const CreateCardDialog(
    this.card, {
    super.key,
  });

  @override
  State<CreateCardDialog> createState() => _CreateCardDialogState();
}

class _CreateCardDialogState extends State<CreateCardDialog> {
  //String cardName = "";
  AECard newCard = AECard.empty();
  //String cardTextBeforeOr = "";
  //String cardTextAfterOr = "";
  //bool isOptional = false;

  @override
  void initState() {
    super.initState();

    newCard = widget.card;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create / Update card'),
      content: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                readOnly: false, // typeIsTO,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: newCard.name),
                onChanged: (value) {
                  newCard.name = value;
                },
                controller: TextEditingController(text: newCard.name),
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.only(top: 10),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: newCard.text),
                onChanged: (value) {
                  newCard.text = value;
                },
                controller: TextEditingController(text: newCard.text),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // TextButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: const Text("Cancel"),
        // ),
        dialogButton("Cancel", () {}, context),
        dialogButton("Save", () {
          context.read<CRUDStackBloc>().add(CRUDStackNewCardEvent(newCard));
          // widget.card.id,
          // cardName,
          // isOptional,
          // cardTextBeforeOr,
          // cardTextAfterOr));
          //context.read<CRUDStackBloc>().add(CRUDStackInitialEvent());
          //context.read<ProviderBloc>().add(UpdateDeleteEvent());
        }, context),
        // TextButton(
        //   style: ButtonStyle(
        //     backgroundColor: WidgetStateProperty.all(Colors.green),
        //   ),
        //   onPressed: () {
        //     context.read<CRUDStackBloc>().add(CRUDStackNewCardEvent(
        //         widget.card.id,
        //         cardName,
        //         isOptional,
        //         cardTextBeforeOr,
        //         cardTextAfterOr));
        //     context.read<CRUDStackBloc>().add(CRUDStackInitialEvent());
        //     Navigator.of(context).pop();
        //   },
        //   child: const Text("Save"),
        // ),
      ],
    );
  }
}
