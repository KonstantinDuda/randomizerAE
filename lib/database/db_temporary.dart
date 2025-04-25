import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack.dart';

class DbTemporary {
  final List<CardsStack> _dbStacks = [];
  final List<CardsStack> _availableStacs = [];
  CardsStack _activeStack = const CardsStack.empty();
  static final DbTemporary db = DbTemporary._();

  DbTemporary._();


  factory DbTemporary() {
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
    name: 'Turn Order Three with so long name',
    isStandart: true,
    stackType: StackType.turnOrder,
    stackColor: Colors.grey,
    cards: turnOrderThreeList,
  );

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
    id: 2,
    name: 'Turn Order Three Bliz',
    isStandart: true,
    stackType: StackType.turnOrder,
    stackColor: Colors.green,
    cards: turnOrderThreeBlizList,
  );

  if (db._dbStacks.isEmpty) {
    db._dbStacks.add(turnOrderThree);
    db._dbStacks.add(turnOrderThreeBliz);
      print("DBTemporary factory: db._dbStacks isEmpty so" 
                " db._dbStacks.add(turnOrderThree)"
                " db._dbStacks.add(turnOrderThreeBliz)");
  } 
  if (db._availableStacs.isEmpty) {
    for (var element in db._dbStacks) {
      if(element.isStandart) {
        db._availableStacs.add(element);
      }
    }
    print("DBTemporary factory: db._availableStacs isEmpty so" 
                " db._availableStacs.addAll(db._dbStacks)");
  }
    
  if (db._activeStack.id == 0 && db._availableStacs.isNotEmpty) {
    db._activeStack = db._availableStacs[0];
  }

  return db;
}

List<CardsStack> getStacks() {
  return  _dbStacks;
}

List<CardsStack> getAvialableStacks() {
  return _availableStacs;
}

CardsStack getActiveStack() {
  return _activeStack;
}


void setActiveStack(CardsStack stack) {
  _activeStack = stack;
}
}