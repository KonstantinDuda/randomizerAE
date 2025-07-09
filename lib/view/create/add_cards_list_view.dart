import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../database/cards_stack.dart';

class AddCardsListView extends StatefulWidget {
  final CardsStack stack;
  final List<AECard> cardsList;
  final List<int> cardsCounters;
  final Function addCard;
  final Function minusCard;
  const AddCardsListView(this.stack, this.cardsList, this.cardsCounters, this.addCard, this.minusCard, {super.key});

  @override
  State<AddCardsListView> createState() => _AddCardsListViewState();
}

class _AddCardsListViewState extends State<AddCardsListView> {
  List<AECard> allCards = [];
  List<String> allCardsNames = [];
  // List<AECard> cardsList = [];
  // List<int> cardsCounters = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CRUDStackBloc, CRUDStackState>(
        builder: (context, state) {
      if (state is CRUDStackSuccessActionState) {
        allCards = state.cards;

        var counter = 0;
        for (var i in allCards) {
          allCardsNames.add(i.text.split(":")[0]);
          for (var j in widget.stack.cards) {
            print("AddCardDialog i.id == ${i.id}; j.id == ${j.id}");
            if (i.id == j.id) {
              counter++;
            }
            if (counter > 0) {
              widget.cardsList.add(j);
            }
          }
          if (widget.cardsCounters.length < allCards.length) {
            widget.cardsCounters.add(counter);
          }
          counter = 0;
        }
        print("AddCardsListView cardsList == ${widget.cardsList}");
        print("AddCardsListView cardCounters == ${widget.cardsCounters}");
      }

      return ListView.builder(
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
                    allCardsNames[index],
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
                TextButton(
                  onPressed: () {
                    if (widget.cardsCounters[index] > 0) {
                      setState(() {
                        widget.cardsCounters[index]--;
                      });
                      widget.minusCard(allCards[index].id);
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
                Text("${widget.cardsCounters[index]}"),
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.cardsCounters[index]++;
                    });
                    widget.addCard(index);
                  },
                  style: TextButton.styleFrom(
                    iconColor: Colors.black,
                    backgroundColor: Colors.blue,
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 16,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
