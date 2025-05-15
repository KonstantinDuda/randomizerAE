import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack.dart';
import 'package:randomizer_new/database/db_provider.dart';

class DbTemporary {
  var db = DBProvider();
  final List<CardsStack> _dbStacks = [];
  final List<CardsStack> _availableStacks = [];
  CardsStack _activeStack = const CardsStack.empty();
  CardsStack _activeFriendStack = const CardsStack.empty();
  CardsStack _activeFoeStack = const CardsStack.empty();
  CardsStack turnOrderOne = const CardsStack.empty();
  CardsStack turnOrderOneBliz = const CardsStack.empty();
  CardsStack turnOrderTwo = const CardsStack.empty();
  CardsStack turnOrderTwoBliz = const CardsStack.empty();
  CardsStack turnOrderThree = const CardsStack.empty();
  CardsStack turnOrderThreeBliz = const CardsStack.empty();
  CardsStack turnOrderFour = const CardsStack.empty();
  CardsStack turnOrderFourBliz = const CardsStack.empty();
  
  List<HeroStack> friendfoeList = [];
  
  static final DbTemporary _dbProvider = DbTemporary._();
  DbTemporary._();
  factory DbTemporary() { return _dbProvider;} 

  //DbTemporary() {
  createData() {
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
    stackColor: Colors.green, //Colors.grey.shade700,
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
  //setAvilableStacs();
  _activeStack = _dbStacks[4];
  
  for (var element in _dbStacks) {
    db.createStack(element);
  }
  //db.createStack(turnOrderThree);
  //db.createStack(turnOrderThreeBliz);
  getStackFromDB(turnOrderThree.id);




      //Friend and Foe creating
  //Friend and Foe Cards
  var cardDE = AECard(
      id: 10,
      text: 'Energize: \n Dalana, the Healer gains 2 charges. OR Any player gains 1 charge',
      imgPath: 'assets/images/dalana energize.png',
    );
    var cardDS = AECard(
      id: 11,
      text: 'Soothing Aura: \n Any player draws a card. OR Any player gains 2 money tokens',
      imgPath: 'assets/images/dalana soothing aura.png',
    );
    var cardDEn = AECard(
      id: 12,
      text: 'Enhance: \n Any player focuses a breach. OR Any player discards a prepped spell. '
        'If they do. Dalana, the Healer gains 3 charges',
      imgPath: 'assets/images/dalana enhance.png',
    );
    var cardDR = AECard(
      id: 13,
      text: 'Restore: \n Dalana, the Healer gains 2 charges. OR Any player returns a card '
        'from their discard pile to their hand',
      imgPath: 'assets/images/dalana restore.png',
    );
    var cardSCC = AECard(
      id: 14,
      text: 'Carrion Claw: \n The Scavenger gains 2 charges. OR Any player loses 2 charges',
      imgPath: 'assets/images/scavenger carrion claw.png',
    );
    var cardSSW = AECard(
      id: 15,
      text: 'Screeching Wail: \n The Scavenger gains 1 charge. Any player may discard a prepped spell '
        'that costs 3 money or more. If they dont, the Scavenger gains an additional 2 charges',
      imgPath: 'assets/images/scavenger screeching wail.png',
    );
    var cardSR = AECard(
      id: 16,
      text: 'Reclaim: \n Any player discards their two most expensive cards in hand and then '
        'draws a card. OR Gravehold suffers 3 damage',
      imgPath: 'assets/images/scavenger reclaim.png',
    );
    var cardSSS = AECard(
      id: 17,
      text: 'Shadow Slash: \n Gravehold suffers 3 damage. OR The Scavenger gains 3 charges and the '
        'friend gains 1 charge',
      imgPath: 'assets/images/scavenger shadow slash.png',
    );
    /*var cardD = AECard(
      id: 18,
      text: '',
      imgPath: 'assets/images/blitz.png',
    );
    var cardD = AECard(
      id: 19,
      text: '',
      imgPath: 'assets/images/blitz.png',
    );
    var cardD = AECard(
      id: 20,
      text: '',
      imgPath: 'assets/images/blitz.png',
    );
    var cardD = AECard(
      id: 21,
      text: '',
      imgPath: 'assets/images/blitz.png',
    );*/

  // Freind and Foe stacks
  CardsStack dalanaStack = CardsStack(
    id: 9,
    name: 'Dalana, the Healer',
    isActive: true,
    stackType: StackType.friendFoe,
    stackColor: Colors.blue,
    cards: [cardDE, cardDS, cardDEn, cardDR],
  );
  CardsStack scavengerStack = CardsStack(
    id: 10,
    name: 'The Scavenger',
    isActive: true,
    stackType: StackType.friendFoe,
    stackColor: Colors.red,
    cards: [cardSCC, cardSSW, cardSR, cardSSS],
  );
  _dbStacks.add(dalanaStack);
  _dbStacks.add(scavengerStack);
  setActiveFoeStack(scavengerStack.id);
  setActiveFriendStack(dalanaStack.id);
  setAvilableStacs();

  // Friend and Foe HeroStacks
  var friendDalanaTheHealer = HeroStack(
    id: 1,
    name: "Dalana, the Healer",
    heroStacks: [dalanaStack],
    energyClosetCount: 5,
    ability: "Bandage: Any player or Gravehold gains 4 life",
  );
  var foeScavenger = HeroStack(
    id: 2,
    name: "The Scavenger",
    heroStacks: [scavengerStack],
    energyClosetCount: 4,
    ability: "Cull the stragglers: The player with the lowest life suffers 4 damage",
  );
  friendfoeList.add(friendDalanaTheHealer);
  friendfoeList.add(foeScavenger);
  }

  void setAvilableStacs() {
    _availableStacks.clear();
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

  updateAvialableStack(List<int> id) {
     print("DBTemporary updateAvialableStack id == $id");
     if(id != []) {
        for (var i = 0; i < _dbStacks.length; i++) {
          for (var j in id) {
            if(_dbStacks[i].id == j) {
              bool newState = !_dbStacks[i].isActive;
              print("DBTemporary updateAvialableStack newState == $newState");
              var newStack = CardsStack(
                id: _dbStacks[i].id, name: _dbStacks[i].name, isActive: newState, 
                stackType: _dbStacks[i].stackType, 
                stackColor: _dbStacks[i].stackColor, cards: _dbStacks[i].cards
              );
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
    if(_activeStack.cards.isEmpty) {
      setActiveStack(_activeStack.id);
    }
    return _activeStack;
  }

  //void setActiveStack(int id) async {
    //var as = await db.getStackById(id);
  void setActiveStack(int id) async {
    print(_activeStack.id);
    var newAS = await db.getStackById(id);
    print("DBTemporary setActiveStack($id) on $newAS \n color: ${newAS.stackColor}");
    _activeStack = newAS;
  }

  void setActiveFriendStack(int id) async {
    _activeFriendStack = await db.getStackById(id);
  }

  void setActiveFoeStack(int id) async {
    _activeFoeStack = await db.getStackById(id);
  }

  CardsStack getActiveFriendStack() {
    return _activeFriendStack;
  }
  CardsStack getActiveFoeStack() {
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

  HeroStack getFriendFoeStackByStackId(int id) {
    print("DBTemporary getFriendFoeStackByStackId($id) \n");
    HeroStack heroStack;
    for (var element in friendfoeList) {
      for (var i = 0; i < element.heroStacks.length; i++) {
        if (element.heroStacks[i].id == id) {
          heroStack = element;
          print("DBTemporary getFriendFoeStackByStackId($id) == $heroStack \n");
        return heroStack;
        }
      }
    }
    return HeroStack.empty();
  }
}