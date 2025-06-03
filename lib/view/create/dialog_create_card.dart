import 'package:flutter/material.dart';

class CreateCardDialog extends StatefulWidget {

  const CreateCardDialog({
    super.key,
  });

  @override
  State<CreateCardDialog> createState() => _CreateCardDialogState();
}

class _CreateCardDialogState extends State<CreateCardDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create / Update card'),
      content: const SizedBox(
        width: 300,
        height: 300,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
        }, 
        child: const Text("Cancel"),),
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.green),
          ),
          onPressed: () {
            print("DialogCreateCard create card");
            //Navigator.of(context).pop();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}