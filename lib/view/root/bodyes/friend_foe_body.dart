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
    bool isHeroEmpty = widget.stack.id == 0 ? true : false;

    final Size bodyContainerSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height - 104.5,
    );
    final Size contentContainerSize = Size(
      bodyContainerSize.width - 20,
      bodyContainerSize.height - 60,
    );

    return Container(
      width: bodyContainerSize.width,
      height: bodyContainerSize.height,
      color: Colors.blue,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    isHeroEmpty ?  "Empty data" : widget.stack.name,
                    style: const TextStyle(fontSize: 30),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                height: 28,
                width: 80,
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                //alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: isHeroEmpty ? Colors.white : widget.stack.heroStacks[0].stackColor, //stackColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Align(
                  //alignment: Alignment.topCenter,
                  child: Text(
                    'stack color',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      height: -0.7,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: contentContainerSize.width,
            height: contentContainerSize.height,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text( isHeroEmpty ? "" :
                '${widget.stack.heroStacks[0].name} Friend or Foe Body'),
            ),
          ),
        ],
      ),
    );
  }
}
