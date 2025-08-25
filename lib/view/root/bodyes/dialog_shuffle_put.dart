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


/*class ChangeSequanceDialog extends StatefulWidget {
  final int cardId;

  const ChangeSequanceDialog({
    super.key,
    required this.cardId,
  });

  @override
  State<ChangeSequanceDialog> createState() => _ChangeSequanceDialogState();
}

class _ChangeSequanceDialogState extends State<ChangeSequanceDialog> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    newSequance = widget.list;
    for (var _ in widget.list) {
      isShown.add(false);      
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Sequence'),
      content: SizedBox(
        width: 300,
        height: 300,
        child: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 280,
              height: 50,
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        if (index < widget.list.length - 1) {
                          var temp = newSequance[index];
                          setState(() {
                            newSequance[index] = newSequance[index + 1];
                            newSequance[index + 1] = temp;
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                        iconColor: Colors.black,
                        backgroundColor: Colors.blue,
                        shape: const CircleBorder(),
                      ),
                      child: index < widget.list.length - 1
                          ? const Icon(Icons.arrow_downward)
                          : const Text("")
                    ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: isShown[index] ? const Text("") : const Icon(Icons.remove_red_eye_outlined)),
                        ListTile(
                          title: Text(
                            isShown[index] ? widget.list[index].text : "",
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            setState(() {
                              isShown[index] = !isShown[index];
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (index > 0) {
                        var temp = newSequance[index];
                        setState(() {
                          newSequance[index] = newSequance[index - 1];
                          newSequance[index - 1] = temp;
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      iconColor: Colors.black,
                      backgroundColor: Colors.blue,
                      shape: const CircleBorder(),
                    ),
                    child: index > 0
                        ? const Icon(Icons.arrow_upward)
                        : const Text(""),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            newSequance = newSequance.reversed.toList();
            context.read<TurnOrderBodyBloc>().add(
                  TurnOrderBodyChangeSequenceEvent(
                    newSequance,
                  ),
                );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}*/
