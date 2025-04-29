import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack.dart';
//import 'package:randomizer_new/database/db_provider.dart';

class DbTemporary {
  //var db = DBProvider();
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

    /*db.createCard(cardOne);
    db.createCard(cardTwo);
    db.createCard(cardThree);
    db.createCard(cardFour);
    db.createCard(cardWild);
    db.createCard(cardNemesis);
    db.createCard(cardFoe);
    db.createCard(cardFriend);
    db.createCard(cardBliz);*/

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

  }


  getStacks() async {
    if(_dbStacks.isEmpty) {
      //_dbStacks.addAll(await db.getAllStacks());
      _dbStacks.add(turnOrderThree);
      _dbStacks.add(turnOrderThreeBliz);
    }
    return  _dbStacks;
  }

  getAvialableStacks() async {
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
    if(_activeStack.cards.isEmpty) {
      setActiveStack(0);
    }
    return _activeStack;
  }

  setActiveStack(int id) async {
    //var as = await db.getStackById(id);
    var as = _dbStacks[0];
    if(as.id != 0) {
      _activeStack = as;
    } else {
      _activeStack = const CardsStack.empty();
    }
  }

  getStackById(int id) async {
    //var stack = await db.getStackById(id);
     var stack = _dbStacks[0];
    if (stack.id != 0) {
      return stack;
    } else {
      return const CardsStack.empty();
    }
  }
}


/*class DbTemporary {
  final List<CardsStack> _dbStacks = [];
  final List<CardsStack> _availableStacs = [];
  CardsStack _activeStack = const CardsStack.empty();

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

  if (_dbStacks.isEmpty) {
    _dbStacks.add(turnOrderThree);
    _dbStacks.add(turnOrderThreeBliz);
      print("DBTemporary factory: db._dbStacks isEmpty so" 
                " db._dbStacks.add(turnOrderThree)"
                " db._dbStacks.add(turnOrderThreeBliz)");
  } 
  if (_availableStacs.isEmpty) {
    for (var element in _dbStacks) {
      if(element.isStandart) {
        _availableStacs.add(element);
      }
    }
    print("DBTemporary factory: db._availableStacs isEmpty so" 
                " db._availableStacs.addAll(db._dbStacks)");
  }
    
  if (_activeStack.id == 0 && _availableStacs.isNotEmpty) {
    _activeStack = _availableStacs[0];
  }

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

CardsStack getStackById(int id) {
  for (var element in _dbStacks) {
    if (element.id == id) {
      return element;
    }
  }
  return const CardsStack.empty();
}

void setActiveStack(CardsStack stack) {
  _activeStack = stack;
}

CardsStack createStack(String name, bool isStandart, StackType stackType,
            Color stackColor, List<AECard> cards) {
  if (_dbStacks.isNotEmpty) {
    int id = _dbStacks.last.id + 1;
    CardsStack newStack = CardsStack(
      id: id,
      name: name,
      isStandart: isStandart,
      stackType: stackType,
      stackColor: stackColor,
      cards: cards,
    );
    _dbStacks.add(newStack);
    if (isStandart) {
      _availableStacs.add(newStack);
    }
    return newStack;
  } else {
    print("db.createStack() not created");
    return const CardsStack.empty();
  }
}

void updateStack(int id, CardsStack stack) {
  for (var element in _dbStacks) {
    if (element.id == id) {
      element = stack;
    }
  }
  for (var element in _availableStacs) {
    if (element.id == id) {
      element = stack;
    }
  }
}

void deleteStackById(int id) {
  for (var element in _dbStacks) {
    if (element.id == id) {
      _dbStacks.remove(element);
    }    
  }
  for (var element in _availableStacs) {
    if (element.id == id) {
      _availableStacs.remove(element);
    }    
  }
  if (_activeStack.id == id && _availableStacs.isNotEmpty) {
    _activeStack = _availableStacs[0];
  }
}

}*/