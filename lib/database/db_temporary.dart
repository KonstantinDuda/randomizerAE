import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack.dart';
import 'package:randomizer_new/database/db_provider.dart';

class DbTemporary {
  var db = DBProvider();
  final List<CardsStack> _dbStacks = [];
  List<CardsStack> _availableStacks = [];
  CardsStack _activeStack = const CardsStack.empty();
  CardsStack turnOrderOne = const CardsStack.empty();
  CardsStack turnOrderOneBliz = const CardsStack.empty();
  CardsStack turnOrderTwo = const CardsStack.empty();
  CardsStack turnOrderTwoBliz = const CardsStack.empty();
  CardsStack turnOrderThree = const CardsStack.empty();
  CardsStack turnOrderThreeBliz = const CardsStack.empty();
  CardsStack turnOrderFour = const CardsStack.empty();
  CardsStack turnOrderFourBliz = const CardsStack.empty();

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

    List<AECard> turnOrderOneList = [
    cardOne,
    cardOne,
    cardWild,
    cardNemesis,
    cardNemesis,
    cardFoe,
    cardFriend,
  ];

  turnOrderOne = CardsStack(
    id: 1,
    name: 'Turn Order One',
    isActive: false,
    stackType: StackType.turnOrder,
    stackColor: Colors.grey,
    cards: turnOrderOneList,
  );
  
  List<AECard> turnOrderOneBlizList = [
    cardOne,
    cardOne,
    cardWild,
    cardNemesis,
    cardBliz,
    cardFoe,
    cardFriend,
  ];

  turnOrderOneBliz = CardsStack(
    id: 2,
    name: 'Turn Order One Bliz',
    isActive: false,
    stackType: StackType.turnOrder,
    stackColor: Colors.green,
    cards: turnOrderOneBlizList,
  );
  
  List<AECard> turnOrderTwoList = [
    cardOne,
    cardTwo,
    cardOne,
    cardTwo,
    cardNemesis,
    cardNemesis,
    cardFoe,
    cardFriend,
  ];

  turnOrderTwo = CardsStack(
    id: 3,
    name: 'Turn Order Two',
    isActive: false,
    stackType: StackType.turnOrder,
    stackColor: Colors.grey,
    cards: turnOrderTwoList,
  );
  
  List<AECard> turnOrderTwoBlizList = [
    cardOne,
    cardTwo,
    cardOne,
    cardTwo,
    cardNemesis,
    cardBliz,
    cardFoe,
    cardFriend,
  ];

  turnOrderTwoBliz = CardsStack(
    id: 4,
    name: 'Turn Order Two Bliz',
    isActive: false,
    stackType: StackType.turnOrder,
    stackColor: Colors.green,
    cards: turnOrderTwoBlizList,
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

  turnOrderThree = CardsStack(
    id: 5,
    name: 'Turn Order Three with so long name',
    isActive: true,
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

  turnOrderThreeBliz = CardsStack(
    id: 6,
    name: 'Turn Order Three Bliz',
    isActive: true,
    stackType: StackType.turnOrder,
    stackColor: Colors.green,
    cards: turnOrderThreeBlizList,
  );
  //db.createStack(turnOrderThree);

  List<AECard> turnOrderFourList = [
    cardOne,
    cardTwo,
    cardThree,
    cardFour,
    cardNemesis,
    cardNemesis,
    cardFoe,
    cardFriend,
  ];

  turnOrderFour = CardsStack(
    id: 7,
    name: 'Turn Order Four',
    isActive: false,
    stackType: StackType.turnOrder,
    stackColor: Colors.grey,
    cards: turnOrderFourList,
  );

  List<AECard> turnOrderFourBlizList = [
    cardOne,
    cardTwo,
    cardThree,
    cardFour,
    cardNemesis,
    cardBliz,
    cardFoe,
    cardFriend,
  ];

  turnOrderFourBliz = CardsStack(
    id: 8,
    name: 'Turn Order Four Bliz',
    isActive: false,
    stackType: StackType.turnOrder,
    stackColor: Colors.green,
    cards: turnOrderFourBlizList,
  );

  //db.createStack(turnOrderThree);
  //db.createStack(turnOrderThreeBliz);
  _dbStacks.add(turnOrderOne);
  _dbStacks.add(turnOrderOneBliz);
  _dbStacks.add(turnOrderTwo);
  _dbStacks.add(turnOrderTwoBliz);
  _dbStacks.add(turnOrderThree);
  _dbStacks.add(turnOrderThreeBliz);
  _dbStacks.add(turnOrderFour);
  _dbStacks.add(turnOrderFourBliz);
  setAvilableStacs();
  _activeStack = _dbStacks[4];
  
  for (var element in _dbStacks) {
    db.createStack(element);
  }
  //db.createStack(turnOrderThree);
  //db.createStack(turnOrderThreeBliz);
  getStackFromDB(turnOrderThree.id);
  }

  void setAvilableStacs() {
    for (var element in _dbStacks) {
      if(element.isActive) {
        _availableStacks.add(element);
      }
    }
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
    if(_availableStacks.isEmpty) {
      _availableStacks.add(turnOrderThree);
      _activeStack = _availableStacks[0];
    }
    
    return _availableStacks;
  }

  updateAvialableStack(List<CardsStack> newList) {
    print("DBTemporary updateAvialableStack newList == ${newList.length}");
    if(newList.isNotEmpty) {
      for (var i = 0; i < _dbStacks.length; i++) {
        for (var y in newList) {
          if(_dbStacks[i].id == y.id && _dbStacks[i].isActive != y.isActive) {
            print("DBTemporary updateAvialableStack remove == ${_dbStacks[i]}");
            _dbStacks.remove(_dbStacks[i]);
          
            _dbStacks.insert(i, y);  //add(y);
            print("DBTemporary updateAvialableStack add == ${y.isActive}");
          }
        }
      }
      _availableStacks = newList;
    } else {
      _availableStacks = [];
    }
    
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
    print("DBTemporary setActiveStack($id) on $newAS \n color: ${newAS.stackColor}");
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