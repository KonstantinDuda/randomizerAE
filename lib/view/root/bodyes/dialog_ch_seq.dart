import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_state/turn_order_body_es.dart';
import '../../../bloc/turn_order_body_bloc.dart';
import '../../../database/cards_stack.dart';

class ChangeSequanceDialog extends StatefulWidget {
  final List<AECard> list;

  const ChangeSequanceDialog({
    super.key,
    required this.list,
  });

  @override
  State<ChangeSequanceDialog> createState() => _ChangeSequanceDialogState();
}

class _ChangeSequanceDialogState extends State<ChangeSequanceDialog> {
  List<AECard> newSequance = [];
  List<bool> isShown = [];

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
}
