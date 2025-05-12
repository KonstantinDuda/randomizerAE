import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack.dart';

class FriendFoeBody extends StatefulWidget {
  final HeroStack stack;
  
  const FriendFoeBody(this.stack, {super.key});
  
  

@override
  State<FriendFoeBody> createState() => _FriendFoeBody();
}

class _FriendFoeBody extends State<FriendFoeBody> {
  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Text('${widget.stack.heroStack.name} Friend or Foe Body'),
    );
  }
}