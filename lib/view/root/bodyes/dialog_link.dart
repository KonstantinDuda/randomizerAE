import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_state/turn_order_body_es.dart';
import '../../../bloc/turn_order_body_bloc.dart';

class LinkDialog extends StatefulWidget {
  final List<String> list; // Cards or Stacks names
  final String name; // From where it is called
  final bool discard; // Is it discard or Link something

  const LinkDialog({
    super.key,
    required this.list,
    required this.name,
    required this.discard,
  });

  @override
  State<LinkDialog> createState() => _LinkDialogState();
}

class _LinkDialogState extends State<LinkDialog> {
  List<String> stateList = [];
  List<bool> isChosen = [];
  bool isDiscard = false;
  String objName = "";

  @override
  void initState() {
    super.initState();

    stateList = widget.list;
    stateList.shuffle(); // Shuffle the list to randomize the order
    isDiscard = widget.discard;
    objName = widget.name;
    for (var _ in widget.list) {
      isChosen.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Sequence'),
      content: SizedBox(
        width: 300,
        height: 400,
        child: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            final bool canIteract = isDiscard ? true : false;
            return SizedBox(
              width: 280,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text(stateList[index]),
                      value: isChosen[index],
                      enabled: canIteract,
                      onChanged: (value) {
                        setState(() {
                          isChosen[index] = value ?? false;
                        });
                      },
                    ),
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
            List<String> selectedItems = [];
            for (int i = 0; i < stateList.length; i++) {
              if (isChosen[i]) {
                selectedItems.add(stateList[i]);
              }
            }
            context.read<TurnOrderBodyBloc>().add(
                TurnOrderBodyDiscardEvent(objName, selectedItems, isDiscard));

            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
