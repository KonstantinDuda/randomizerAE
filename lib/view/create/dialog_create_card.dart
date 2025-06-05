import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/database/cards_stack.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';

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
  String cardName = "";
  String cardTextBeforeOr = "";
  String cardTextAfterOr = "";
  bool isOptional = false;
  List<String> cardTypesList = [
    "Turn order",
    "Friend",
    "Foe",
    "Nemesis",
    "Gravehold",
    "Suply",
    "Hero",
    "Other"
  ];
  var cardType = "Other";
  var typeIsTO = false;

  @override
  Widget build(BuildContext context) {
    if (widget.card.id > 0) {
      print("DialogCreatecard widget.card.id > 0");
      if (widget.card.imgPath.isNotEmpty) {
        var pathAndName = widget.card.imgPath.split("/");
        if (pathAndName.length > 3) {
          for (var element in cardTypesList) {
            element.toLowerCase() == pathAndName[2]
                ? cardType = element
                : cardType = "Other";
          }
        }
      }
      if (cardType != "Turn order") {
        if (widget.card.text.isNotEmpty) {
          var nameAndText = widget.card.text.split(":");
          var beforeOrAndAfter = [];
          cardName = nameAndText[0];
          if (nameAndText.length > 1) {
            beforeOrAndAfter = nameAndText[1].split("OR");
            cardTextBeforeOr = beforeOrAndAfter[0];
            beforeOrAndAfter.length > 1
                ? cardTextAfterOr = beforeOrAndAfter
                    .sublist(1, beforeOrAndAfter.length - 1)
                    .join(" ")
                : cardTextAfterOr = "";
          }
        }
      } else {
        cardName = "";
        var beforeOrAndAfter = widget.card.text.split("OR");
        if (beforeOrAndAfter.length > 1) {
          isOptional = true;
          cardTextBeforeOr = beforeOrAndAfter[0];
          cardTextAfterOr = beforeOrAndAfter
              .sublist(1, beforeOrAndAfter.length - 1)
              .join(" ");
        }
      }
    }

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
                readOnly: typeIsTO,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Card name"),
                onChanged: (value) {
                  cardName = value;
                },
                controller: TextEditingController(text: cardName),
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.only(top: 10),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Card text before Or"),
                onChanged: (value) {
                  cardTextBeforeOr = value;
                },
                controller: TextEditingController(text: cardTextBeforeOr),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("OR"),
                Checkbox(
                    value: isOptional,
                    onChanged: (value) {
                      setState(() {
                        isOptional = value!;
                      });
                    }),
              ],
            ),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Card text after Or"),
                onChanged: (value) {
                  cardTextAfterOr = value;
                },
                controller: TextEditingController(text: cardTextAfterOr),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Card type: "),
                DropdownButton<String>(
                  iconSize: 35,
                  value: cardType, //typesList[index],
                  items: cardTypesList.map((String type) {
                    return DropdownMenuItem<String>(
                      alignment: AlignmentDirectional.center,
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      cardType = value!;
                      cardType == "Turn order"
                          ? typeIsTO = true
                          : typeIsTO = false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.green),
          ),
          onPressed: () {
            if (cardType == "Turn order") cardName = "";
            print("DialogCreateCard create card");
            context.read<CRUDStackBloc>().add(CRUDStackNewCardEvent(cardName,
                isOptional, cardTextBeforeOr, cardTextAfterOr, cardType));
            Navigator.of(context).pop();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
