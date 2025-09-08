import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_stack_bloc.dart';
import '../../bloc/event_state/crud_stack_es.dart';

class DeleteDialog extends StatefulWidget {
  final String text;
  final bool isCard;
  final bool isStack;
  final int id;

  const DeleteDialog(
    this.text,
    this.isCard,
    this.isStack,
    this.id, {
    super.key,
  });

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete dialog'),
      content: SizedBox(
        width: 300,
        height: 300,
        child: Center(child: Text("Delete: \n ${widget.text}?", textAlign: TextAlign.center, style: const TextStyle(fontSize: 18),)),
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
            backgroundColor: WidgetStateProperty.all(Colors.red),
          ),
          onPressed: () {
            print("DialogDelete delete ${widget.text}");
            if (widget.isCard) {
              context
                  .read<CRUDStackBloc>()
                  .add(CRUDStackDeleteCardEvent(widget.id));
            } else if (widget.isStack) {
              context
                  .read<CRUDStackBloc>()
                  .add(CRUDStackDeleteStackEvent(widget.id));
            } else {
              print("DialogDelete isCard == false, isStack == false");
            }
            context.read<CRUDStackBloc>().add(CRUDStackInitialEvent()); // Addad 08.09.2025
            Navigator.of(context).pop();
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
