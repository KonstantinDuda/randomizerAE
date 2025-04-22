import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack.dart';

class DbTemporary {
  //late CardsStack turnOrderThree;
  //late CardsStack turnOrderThreeBliz;
  List<CardsStack> dbStacks = [];

  DbTemporary() {
    var cardOne = AECard(
      id: 1,
      text: '1',
      source: 'Turn Order Deck',
      imgPath: 'assets/images/card1.png',
    );
    var cardTwo = AECard(
      id: 2,
      text: '2',
      source: 'Turn Order Deck',
      imgPath: 'assets/images/card2.png',
    );
    var cardThree = AECard(
      id: 3,
      text: '3',
      source: 'Turn Order Deck',
      imgPath: 'assets/images/card3.png',
    );
    var cardFour = AECard(
      id: 4,
      text: '4',
      source: 'Turn Order Deck',
      imgPath: 'assets/images/card4.png',
    );
    var cardWild = AECard(
      id: 5,
      text: 'Wild',
      source: 'Turn Order Deck',
      imgPath: 'assets/images/wild.png',
    );
    var cardNemesis = AECard(
      id: 6,
      text: 'Nemesis',
      source: 'Turn Order Deck',
      imgPath: 'assets/images/nemesis.png',
    );
    var cardFoe = AECard(
      id: 7,
      text: 'Foe',
      source: 'Turn Order Deck',
      imgPath: 'assets/images/foe.png',
    );
    var cardFriend = AECard(
      id: 8,
      text: 'Friend',
      source: 'Turn Order Deck',
      imgPath: 'assets/images/friend.png',
    );
    var cardBliz = AECard(
      id: 9,
      text: 'Blitz',
      source: 'Turn Order Deck',
      imgPath: 'assets/images/blitz.png',
    );

  List<AECard> turnOrderThreeList = [
    cardOne,
    cardTwo,
    cardThree,
    cardWild,
    cardNemesis,
    cardNemesis,
    cardFoe,
    cardFriend,
  ];

  CardsStack turnOrderThree = CardsStack(
    id: 1,
    name: 'Turn Order Three',
    isStandart: true,
    stackColor: Colors.grey,
    cards: turnOrderThreeList,
  );
  dbStacks.add(turnOrderThree);

  List<AECard> turnOrderThreeBlizList = [
    cardOne,
    cardTwo,
    cardThree,
    cardWild,
    cardNemesis,
    cardBliz,
    cardFoe,
    cardFriend,
  ];

  CardsStack turnOrderThreeBliz = CardsStack(
    id: 1,
    name: 'Turn Order Three Bliz',
    isStandart: true,
    stackColor: Colors.green,
    cards: turnOrderThreeBlizList,
  );
  dbStacks.add(turnOrderThreeBliz);
}

getStack() {
  return  dbStacks;
}

}

