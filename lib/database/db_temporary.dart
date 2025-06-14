/*import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack.dart';
import 'package:randomizer_new/database/db_provider.dart';
import 'package:randomizer_new/database/default_data.dart';

class DbTemporary {
  var db = DBProvider();
  final List<CardsStack> _dbStacks = [];
  final List<CardsStack> _availableStacks = [];
  CardsStack _activeStack = const CardsStack.empty();
  CardsStack _activeFriendStack = const CardsStack.empty();
  CardsStack _activeFoeStack = const CardsStack.empty();

  List<CardsStack> turnOrderList = [];

  CardsStack turnOrderOne = const CardsStack.empty();
  CardsStack turnOrderOneBliz = const CardsStack.empty();
  CardsStack turnOrderTwo = const CardsStack.empty();
  CardsStack turnOrderTwoBliz = const CardsStack.empty();
  CardsStack turnOrderThree = const CardsStack.empty();
  CardsStack turnOrderThreeBliz = const CardsStack.empty();
  CardsStack turnOrderFour = const CardsStack.empty();
  CardsStack turnOrderFourBliz = const CardsStack.empty();

  //List<CardsStack> _otherTurnOrderStacks = [];

  List<HeroStack> friendfoeList = [];

  static final DbTemporary _dbProvider = DbTemporary._();
  DbTemporary._();
  factory DbTemporary() {
    return _dbProvider;
  }

  //DbTemporary() {
  createData() {
    // Turn order cards
    var cardOne = AECard(
      id: 1,
      text: '1',
      imgPath: 'assets/images/turn order/card1.png',
    );
    var cardTwo = AECard(
      id: 2,
      text: '2',
      imgPath: 'assets/images/turn order/card2.png',
    );
    var cardThree = AECard(
      id: 3,
      text: '3',
      imgPath: 'assets/images/turn order/card3.png',
    );
    var cardFour = AECard(
      id: 4,
      text: '4',
      imgPath: 'assets/images/turn order/card4.png',
    );
    var cardWild = AECard(
      id: 5,
      text: 'Wild',
      imgPath: 'assets/images/turn order/wild.png',
    );
    var cardNemesis = AECard(
      id: 6,
      text: 'Nemesis',
      imgPath: 'assets/images/turn order/nemesis.png',
    );
    var cardFoe = AECard(
      id: 7,
      text: 'Foe',
      imgPath: 'assets/images/turn order/foe.png',
    );
    var cardFriend = AECard(
      id: 8,
      text: 'Friend',
      imgPath: 'assets/images/turn order/friend.png',
    );
    var cardBliz = AECard(
      id: 9,
      text: 'Blitz',
      imgPath: 'assets/images/turn order/blitz.png',
    );
    
    var cardNemesisSpecific = AECard(
      id: 10,
      text: 'Nemesis specific card',
      imgPath: 'assets/images/turn order/nemesis specific.png',
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
    db.createCard(cardNemesisSpecific);


  // Turn order Stacks

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
      name: 'Turn Order Three',
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
      id: 2,
      name: 'Turn Order Three Bliz',
      isActive: true,
      stackType: StackType.turnOrder,
      stackColor: Colors.green,
      cards: turnOrderThreeBlizList,
    );
    //db.createStack(turnOrderThree);

    _dbStacks.add(turnOrderThree);
    _dbStacks.add(turnOrderThreeBliz);
    _activeStack = _dbStacks[0];

    for (var element in _dbStacks) {
      //print("DBTemporary db.createStack($element)");
      db.createStack(element);
    }
    
    DefaultData friendFoeData = DefaultData();
    friendFoeData.checkCards();
    friendFoeData.checkStacks();

  }

  void setAvilableStacs() {
    _availableStacks.clear();
    for (var element in _dbStacks) {
      if (element.isActive) {
        _availableStacks.add(element);
      }
    }
  }

  //Future<List<CardsStack>> getStacks() async {
  /*List<CardsStack>*/ getStacks() async {
    //var dbData = await db.getTurnOrderStacks();
    if (_dbStacks.isEmpty) {
      //_dbStacks.addAll(await db.getAllStacks());
      _dbStacks.add(turnOrderThree);
      //_dbStacks.add(turnOrderThreeBliz);
    } else {
      print("DBTemporary getStacks else db.getTurnOrderStacks()");// == $dbData \n");
    }
    return _dbStacks;
  }

  //Future<List<CardsStack>> getAvialableStacks() async {
  List<CardsStack> getAvialableStacks() {
    if (_availableStacks.isEmpty) {
      _availableStacks.add(turnOrderThree);
      _activeStack = _availableStacks[0];
    }

    return _availableStacks;
  }

  updateAvialableStack(List<int> id) {
    print("DBTemporary updateAvialableStack id == $id");
    if (id != []) {
      for (var i = 0; i < _dbStacks.length; i++) {
        for (var j in id) {
          if (_dbStacks[i].id == j) {
            bool newState = !_dbStacks[i].isActive;
            print("DBTemporary updateAvialableStack newState == $newState");
            var newStack = CardsStack(
                id: _dbStacks[i].id,
                name: _dbStacks[i].name,
                isActive: newState,
                stackType: _dbStacks[i].stackType,
                stackColor: _dbStacks[i].stackColor,
                cards: _dbStacks[i].cards);
            _dbStacks.remove(_dbStacks[i]);
            _dbStacks.insert(i, newStack);
          }
        }
      }
    }
    setAvilableStacs();
  }

  CardsStack getActiveStack() {
    print("DBTemporary getActiveStack _activeStack.id == ${_activeStack.id}");
    if (_activeStack.cards.isEmpty) {
      setActiveStack(_activeStack.id);
    }
    return _activeStack;
  }

  //void setActiveStack(int id) async {
  //var as = await db.getStackById(id);
  void setActiveStack(int id) async {
    //print(_activeStack.id);
    var newAS = await db.getStackById(id);
    //print("DBTemporary setActiveStack($id) on $newAS \n color: ${newAS.stackColor}");
    _activeStack = newAS;
  }

  void setActiveFriendStack(int id) async {
    if(id == 0) {
      var allStacks = await db.getAllStacks();
      for (var element in allStacks) {
        if (element.stackType == StackType.friendFoe && element.isActive && element.stackColor == Colors.blue) {
          _activeFriendStack = element;
          id = element.id;        
          break;
        }
      }
    }

    //_activeFriendStack = await db.getStackById(id);
    //print(
    //    "DBTemporary setActiveFriendStack($id) on ${_activeFriendStack.cards} \n");
    for (var i = 0; i < friendfoeList.length; i++) {
      if (friendfoeList[i].heroStacks[0].id == id) {
        friendfoeList[i].heroStacks[0] = _activeFriendStack;
     //   print(
       //     "DBTemporary setActiveFriendStack friendfoeList[i].heroStacks[0] == ${friendfoeList[i].heroStacks[0]} \n");
      }
    }
//    friendfoeList[0].heroStacks[0] = _activeFriendStack;
  }

  CardsStack getActiveFriendStack() {
    if (_activeFriendStack.cards.isNotEmpty) {
      return _activeFriendStack;
    } else {
      setActiveFriendStack(_activeFriendStack.id);
    }
    for (var i = 0; i < friendfoeList.length; i++) {
      if (friendfoeList[i].heroStacks[0].id == _activeFriendStack.id) {
        friendfoeList[i].heroStacks[0] = _activeFriendStack;
      //  print(
      //      "DBTemporary getActiveFriendStack friendfoeList[i].heroStacks[0] == ${friendfoeList[i].heroStacks[0]} \n");
      }
    }
    //print(
     //   "DBTemporary getActiveFriendStack _activeFriendStack.cards == ${_activeFriendStack.cards}");
    return _activeFriendStack;
  }

  void setActiveFoeStack(int id) async {
    //print(
    //    "DBTemporary setActiveFoeStack($id) on ${_activeFriendStack.cards} \n");
    _activeFoeStack = await db.getStackById(id);
    for (var i = 0; i < friendfoeList.length; i++) {
      if (friendfoeList[i].heroStacks[0].id == id) {
        friendfoeList[i].heroStacks[0] = _activeFoeStack;
     //   print(
     //       "DBTemporary setActiveFriendStack friendfoeList[i].heroStacks[0] == ${friendfoeList[i].heroStacks[0]} \n");
      }
    }
  }

  CardsStack getActiveFoeStack() {
    if (_activeFoeStack.cards.isNotEmpty) {
      return _activeFoeStack;
    } else {
      setActiveFoeStack(_activeFoeStack.id);
    }
    for (var i = 0; i < friendfoeList.length; i++) {
      if (friendfoeList[i].heroStacks[0].id == _activeFoeStack.id) {
        friendfoeList[i].heroStacks[0] = _activeFoeStack;
    //    print(
    //        "DBTemporary getActiveFoeStack friendfoeList[i].heroStacks[0] == ${friendfoeList[i].heroStacks[0]} \n");
      }
    }
    //print(
    //    "DBTemporary getActiveFriendStack _activeFoeStack.cards == ${_activeFoeStack.cards}");

    return _activeFoeStack;
  }

  CardsStack getStackById(int id) {
    var stack = _dbStacks[0];
    if (stack.id != 0) {
      return stack;
    } else {
      return const CardsStack.empty();
    }
  }

  // HeroStack getHeroStackByStackId(int id) {
  //   //print("DBTemporary getHeroStackByStackId($id) \n");
  //   HeroStack heroStack = HeroStack.empty();
  //   for (var element in friendfoeList) {
  //     for (var i = 0; i < element.heroStacks.length; i++) {
  //       if (element.heroStacks[i].id == id) {
  //         heroStack = element;
  //         //print("DBTemporary getHeroStackByStackId($id) == $heroStack \n");
  //         return heroStack;
  //       }
  //     }
  //   }
  //   if (heroStack.id == 0) {
  //     print("DBTemporary getHeroStackByStackId($id) == HeroStack.empty() \n");
  //   }
  //   return const HeroStack.empty();
  // }

  HeroStack getHeroById(int id) {
    print("DBTemporary getHeroById($id) \n");
    for (var element in friendfoeList) {
      print("DBTemporary getHeroById($id) element.id == ${element.id} \n");
      if (id == element.id) {
        return element;
      }
    }

    return HeroStack.empty();
  }
}*/
