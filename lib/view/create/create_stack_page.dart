import 'package:flutter/material.dart';
//import 'package:randomizer_new/database/cards_stack.dart';
import 'package:randomizer_new/view/create/stack_widget.dart';

class CreateStackPage extends StatefulWidget {
  const CreateStackPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateStackPageState();
}

class _CreateStackPageState extends State<CreateStackPage> {
  String newText = "";

  changeName() {
    print("CreateStackPage changeName");}
  
  addCard() {
    print("CreateStackPage addCard");}
  
  checkboxChange() {
    print("CreateStackPage checkboxChange");}
  
  changeType() {
    print("CreateStackPage changeType");}
  
  changeColor() {
    print("CreateStackPage changeColor");}
  
  saveStack() {
    print("CreateStackPage saveStack");}
  
  deleteStack() {
    print("CreateStackPage deleteStack");
    }


  @override
  Widget build(BuildContext context) {
    return StackWidget(
        Row(
          children: [
            const Text("Stack name:"),
            TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                newText = value;
                print('$newText');
              },
              controller: TextEditingController(text: newText),
              expands: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              autofocus: true,
            ),
          ],
        ),
        "",
        false,
        "Turn order",
      const Color.fromARGB(255, 76, 175, 80),
        changeName,
        addCard,
        checkboxChange,
        changeType,
        changeColor,
        saveStack,
        deleteStack);
  }
}
