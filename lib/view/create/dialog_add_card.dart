import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../database/cards_stack.dart';

class AddCardToStackDialog extends StatefulWidget {
  final CardsStack stack;

  const AddCardToStackDialog({
    super.key,
    required this.stack,
  });

  @override
  State<AddCardToStackDialog> createState() => _AddCardToStackDialogState();
}

class _AddCardToStackDialogState extends State<AddCardToStackDialog> {
  List<AECard> allCards = [];
  List<String> namesAllCards = [];
  List<AECard> cardsList = [];
  List<int> cardCounter = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CRUDStackBloc, CRUDStackState>(
        builder: (context, state) {
      if (state is CRUDStackSuccessActionState) {
        allCards = state
            .cards;

        var counter = 0;
        for (var i in allCards) {
          namesAllCards.add(i.text.split(":")[0]);
          for (var j in widget.stack.cards) {
            print("AddCardDialog i.id == ${i.id}; j.id == ${j.id}");
            if (i.id == j.id) {
              counter++;
            }
            if (counter > 0) {
              cardsList.add(j);
            }
          }
          if (cardCounter.length < allCards.length) {
            cardCounter.add(counter);
          }
          counter = 0;
        }
        print("AddCardDialog cardsList == $cardsList");
        print("AddCardDialog cardCounter == $cardCounter");
      }

      return AlertDialog(
        title: Text('Add card to ${widget.stack.name}'),
        content: SizedBox(
          width: 300,
          height: 300,
          child: ListView.builder(
            itemCount: allCards.isEmpty ? 1 : allCards.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 280,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        child: Center(
                      child: Text(
                        namesAllCards[index], //allCards[index].text,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                    TextButton(
                      onPressed: () {
                        if (cardCounter[index] > 0) {
                          setState(() {
                            cardCounter[index]--;
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                        iconColor: Colors.black,
                        backgroundColor: Colors.blue,
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        Icons.remove_outlined,
                        size: 16,
                      ),
                    ),
                    Text("${cardCounter[index]}"),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            cardCounter[index]++;
                          });
                        },
                        style: TextButton.styleFrom(
                          iconColor: Colors.black,
                          backgroundColor: Colors.blue,
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 16,
                        )),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              List<AECard> newCardsList = [];
              for (var i = 0; i < cardCounter.length; i++) {
                if (cardCounter[i] > 0) {
                  for (var j = 0; j < cardCounter[i]; j++) {
                    newCardsList.add(allCards[i]);
                  }
                }
              }
              print(
                  "AddCardDialog update ${widget.stack.name} with List<AECard> == $newCardsList \n");
              print(
                  "AddCardDialog update ${widget.stack.name} old list == ${widget.stack.cards} \n");
              var newStack = CardsStack(
                  id: widget.stack.id,
                  name: widget.stack.name,
                  isActive: widget.stack.isActive,
                  stackType: widget.stack.stackType,
                  stackColor: widget.stack.stackColor,
                  cards: newCardsList);
              context
                  .read<CRUDStackBloc>()
                  .add(CRUDStackUpdateStackEvent(newStack));
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green, // Colors.green,
              foregroundColor: Colors.black,
            ),
            child: const Text('Save'),
          ),
        ],
      );
    });
  }
}
