import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack.dart';
import 'package:randomizer_new/database/db_provider.dart';

class DbTemporary {
  var db = DBProvider();
  final List<CardsStack> _dbStacks = [];
  final List<CardsStack> _availableStacks = [];
  CardsStack _activeStack = const CardsStack.empty();
  CardsStack turnOrderThree = const CardsStack.empty();
  CardsStack turnOrderThreeBliz = const CardsStack.empty();

  DbTemporary() {
    var cardOne = AECard(
      id: 1,
      text: '1',
      imgPath: 'assets/images/card1.png',
    );
    var cardTwo = AECard(
      id: 2,
      text: '2',
      imgPath: 'assets/images/card2.png',
    );
    var cardThree = AECard(
      id: 3,
      text: '3',
      imgPath: 'assets/images/card3.png',
    );
    var cardFour = AECard(
      id: 4,
      text: '4',
      imgPath: 'assets/images/card4.png',
    );
    var cardWild = AECard(
      id: 5,
      text: 'Wild',
      imgPath: 'assets/images/wild.png',
    );
    var cardNemesis = AECard(
      id: 6,
      text: 'Nemesis',
      imgPath: 'assets/images/nemesis.png',
    );
    var cardFoe = AECard(
      id: 7,
      text: 'Foe',
      imgPath: 'assets/images/foe.png',
    );
    var cardFriend = AECard(
      id: 8,
      text: 'Friend',
      imgPath: 'assets/images/friend.png',
    );
    var cardBliz = AECard(
      id: 9,
      text: 'Blitz',
      imgPath: 'assets/images/blitz.png',
    );

    db.createCard(cardOne);
    db.createCard(cardTwo);
    db.createCard(cardThree);
    db.createCard(cardFour);
    db.createCard(cardWild);
    db.createCard(cardNemesis);
    db.createCard(cardFoe);
    db.createCard(cardFriend);
    db.createCard(cardBliz);

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

  turnOrderThree = CardsStack(
    id: 1,
    name: 'Turn Order Three with so long name',
    isStandart: true,
    stackType: StackType.turnOrder,
    stackColor: Colors.grey,
    cards: turnOrderThreeList,
  );
  //db.createStack(turnOrderThree);

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

  turnOrderThreeBliz = CardsStack(
    id: 2,
    name: 'Turn Order Three Bliz',
    isStandart: true,
    stackType: StackType.turnOrder,
    stackColor: Colors.green,
    cards: turnOrderThreeBlizList,
  );
  //db.createStack(turnOrderThree);
  //db.createStack(turnOrderThreeBliz);
  _dbStacks.add(turnOrderThree);
  _dbStacks.add(turnOrderThreeBliz);
  _availableStacks.add(turnOrderThree);
  _availableStacks.add(turnOrderThreeBliz);
  _activeStack = _dbStacks[0];
  
  db.createStack(turnOrderThree);
  getStackFromDB(turnOrderThree.id);
  }


  getStackFromDB(int id) async {
    var tos = await db.getStackById(turnOrderThree.id);
    print("\n");
    print("\n");
    print("\n");
    print("\n");
    print("DBTemporary getStackFromDB($id) == $tos \n");
    print("\n");
    print("\n");
    print("\n");
    print("\n");
  }
  //Future<List<CardsStack>> getStacks() async {
  List<CardsStack> getStacks() {
    if(_dbStacks.isEmpty) {
      //_dbStacks.addAll(await db.getAllStacks());
      _dbStacks.add(turnOrderThree);
      _dbStacks.add(turnOrderThreeBliz);
    }
    return _dbStacks;
  }

  //Future<List<CardsStack>> getAvialableStacks() async {
  List<CardsStack> getAvialableStacks() {
    List<CardsStack> stacks = [];
    if(_availableStacks.isEmpty) {
      //stacks.addAll(await db.getAllStacks());
      stacks.add(turnOrderThree);
    }
    for (var element in stacks) {
      if(element.isStandart) {
        _availableStacks.add(element);
      }
    }
    _activeStack = _availableStacks[0];
    return _availableStacks;
  }

  CardsStack getActiveStack() {
    print("DBTemporary getActiveStack _activeStack.id == ${_activeStack.id}");
    if(_activeStack.cards.isEmpty) {
      setActiveStack(_activeStack.id);
    }
    return _activeStack;
  }

  //void setActiveStack(int id) async {
    //var as = await db.getStackById(id);
  void setActiveStack(int id) async {
    /*var as = _dbStacks[0];
    if(as.id != 0) {
      _activeStack = as;
    } else {
      _activeStack = const CardsStack.empty();
    }*/
    print(_activeStack.id);
    var newAS = await db.getStackById(id);
    print("DBTemporary setActiveStack($id) on $newAS");
    _activeStack = newAS;
  }

  //Future<CardsStack> getStackById(int id) async {
    //var stack = await db.getStackById(id);
    CardsStack getStackById(int id) {
     var stack = _dbStacks[0];
    if (stack.id != 0) {
      return stack;
    } else {
      return const CardsStack.empty();
    }
  }
}