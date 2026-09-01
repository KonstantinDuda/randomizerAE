import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';
import '../../database/cards_stack.dart';

class DescriptionDialog extends StatefulWidget {
  final CardsStack stack;
  const DescriptionDialog({super.key, required this.stack});

  @override
  State<DescriptionDialog> createState() => _DescriptionDialogState();
}

class _DescriptionDialogState extends State<DescriptionDialog> {
  String description = "";

  @override
  initState() {
    super.initState();
    description = widget.stack.description;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Description"),
      content: TextField(
        controller: TextEditingController(text: description),
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: "Enter description...",
        ),
        onChanged: (value) {
          description = value;
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
            print(
                "DescriptionDialog onPressed Save description == $description");
            context.read<CRUDStackBloc>().add(CRUDStackUpdateStackEvent(
                widget.stack.copyWith(description: description)));
            Navigator.of(context).pop(description);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
