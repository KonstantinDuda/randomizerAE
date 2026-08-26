import 'package:flutter/material.dart';

import '../../../database/cards_stack.dart';
import 'dialog_button.dart';

class DialogAboutStack extends StatefulWidget {
  final CardsStack stack;
  const DialogAboutStack(this.stack, {super.key});

  @override
  State<DialogAboutStack> createState() => _DialogAboutStackState();
}

class _DialogAboutStackState extends State<DialogAboutStack> {
  CardsStack stack = const CardsStack.empty();
  String cards = "";

  @override
  void initState() {
    stack = widget.stack;
    if (stack.cards.isNotEmpty) {
      cards = stack.cards.map(((e) => e.name)).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(stack.name),
      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  color: stack.stackColor,
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    stack.stackTypeToString(stack.stackType),
                    style: TextStyle(
                        color: stack.stackColor ==
                                const Color.fromARGB(255, 0, 0, 0)
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(stack.isActive
                      ? "Stack is Active"
                      : "Stack is not Active"),
                ),
              ],
            ),
            const Text(
              "Cards in stack: ",
              style: TextStyle(fontSize: 18),
            ),
            Text(cards),
            const Text(
              "Description: ",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      actions: [
        dialogButton("Leave 'About stack'", () {}, context),
        dialogButton("Edit the stack", () {}, context, navigation: "edit")
      ],
    );
  }
}
