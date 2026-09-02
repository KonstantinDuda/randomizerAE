import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../database/cards_stack.dart';

class DescriptionDialog extends StatefulWidget {
  final CardsStack stack;
  final bool isDescription;
  const DescriptionDialog(
      {super.key, required this.stack, required this.isDescription});

  @override
  State<DescriptionDialog> createState() => _DescriptionDialogState();
}

class _DescriptionDialogState extends State<DescriptionDialog> {
  String description = "";
  String name = "";
  bool isDescription = true;

  @override
  initState() {
    super.initState();
    description = widget.stack.description;
    name = widget.stack.name;
    isDescription = widget.isDescription;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isDescription ? "Edit Description" : "Edit Name"),
      content: TextField(
        controller:
            TextEditingController(text: isDescription ? description : name),
        maxLines: 5,
        decoration: InputDecoration(
          hintText: isDescription ? "Enter description..." : "Enter name...",
        ),
        onChanged: (value) {
          if (isDescription) {
            description = value;
          } else {
            name = value;
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (isDescription) {
              print(
                  "DescriptionDialog onPressed Save description == $description");
              context.read<CRUDStackBloc>().add(CRUDStackUpdateStackEvent(
                  widget.stack.copyWith(description: description)));
              Navigator.of(context).pop(description);
            } else {
              print("DescriptionDialog onPressed Save name == $name");
              context.read<CRUDStackBloc>().add(
                  CRUDStackUpdateStackEvent(widget.stack.copyWith(name: name)));
              Navigator.of(context).pop(name);
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
