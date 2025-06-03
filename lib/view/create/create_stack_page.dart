import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:randomizer_new/database/cards_stack.dart';
import 'package:randomizer_new/view/create/stack_widget.dart';

import '../../bloc/providers/provider_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: const Text("Create Stack")),
            ElevatedButton(onPressed: () {
              context.read<ProviderBloc>().add(UpdateDeleteEvent());
            }, child: const Icon(Icons.arrow_back_sharp),),
          ],
        ),
      ),
      body: StackWidget(
          Row(
            children: [
              const Text("Stack name:"),
              // TextField(
              //   decoration: const InputDecoration(
              //     contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              //     border: InputBorder.none,
              //   ),
              //   onChanged: (value) {
              //     newText = value;
              //     print('$newText');
              //   },
              //   controller: TextEditingController(text: newText),
              //   expands: true,
              //   maxLines: null,
              //   keyboardType: TextInputType.multiline,
              //   autofocus: true,
              // ),
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
          deleteStack),
    );
  }
}
