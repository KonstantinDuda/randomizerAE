import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack.dart';
import 'package:randomizer_new/database/db_provider.dart';

class TurnOrderData {
  var db = DBProvider();

  List<AECard> _cards = [];
  List<CardsStack> _stacks = [];

  List<CardsStack> stacksStandart = [];
  List<CardsStack> stacksWithThreeNemesisCards = [];
  List<CardsStack> stacksWithoutFF = [];
  List<CardsStack> stacksWithThreeNemesisCardsWithoutFF = [];

  // Turn Order Cards
  void checkCards() async {
    var listFDB = await _getCardsFromDB();
    if (listFDB.length <= 9) {
      print("TurnOrderData checkCards listFDB.length <= 9");
      createCards();
    } else {
      print("TurnOrderData checkCards listFDB.length > 9");
      _cards = listFDB;
    }
  }

  Future<List<AECard>> _getCardsFromDB() async {
    //List<AECard> list = await db.getTurnOrderCards(); //db.getAllCards();
    List<AECard> list = await db.getAllCards();

    List<AECard> result = [];

    for (var i in list) {
      if (i.imgPath.isNotEmpty) {
        var pathList = i.imgPath.split("/");
        if (pathList.length > 3) {
          if (pathList[2] == "turn order") {
            result.add(i);
          }
        }
      }
    }

    return list;
  }

  void addCardsToDB() async {
    var listFDB = await _getCardsFromDB();
    List<AECard> res = listFDB;
    if (listFDB.length != _cards.length) {
      for (var i in _cards) {
        for (var j = 0; j < listFDB.length; j++) {
          if (i.id == listFDB[j].id) {
            print(
                "TOData addCardsToDB res[j].id == ${res[j].id}, listFDB[j].id == ${listFDB[j].id}");
            res.removeAt(j);
            res.insert(j, AECard(id: 0, text: "", imgPath: ""));
          }
        }
      }
      for (var element in res) {
        if (element.id != 0) {
          db.createCard(element);
        }
      }
    }
  }

  createCards() {
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

    var cardNemesisSpecific = AECard(
      id: 10,
      text: 'Nemesis specific card',
      imgPath: 'assets/images/nemesis specific.png',
    );
    _cards.add(cardOne);
    _cards.add(cardTwo);
    _cards.add(cardThree);
    _cards.add(cardFour);
    _cards.add(cardWild);
    _cards.add(cardNemesis);
    _cards.add(cardFoe);
    _cards.add(cardFriend);
    _cards.add(cardBliz);
    _cards.add(cardNemesisSpecific);

    addCardsToDB();
  }

// Turn Order Stacks
  void checkStacks() async {
    var listFDB = await _getTOStacksFromDB();
    if (listFDB.length <= 31) {
      print("TurnOrderData checkStacks listFDB.length <= 31");
      createStacks();
    } else {
      print("TurnOrderData checkStacks listFDB.length > 31");
      _stacks = listFDB;
      stacksStandart = [
        _stacks[0],
        _stacks[1],
        _stacks[2],
        _stacks[3],
        _stacks[4],
        _stacks[5],
        _stacks[6],
        _stacks[7]
      ];
      stacksWithThreeNemesisCards = [
        _stacks[8],
        _stacks[9],
        _stacks[10],
        _stacks[11],
        _stacks[12],
        _stacks[13],
        _stacks[14],
        _stacks[15]
      ];
      stacksWithoutFF = [
        _stacks[16],
        _stacks[17],
        _stacks[18],
        _stacks[19],
        _stacks[20],
        _stacks[21],
        _stacks[22],
        _stacks[23]
      ];
      stacksWithThreeNemesisCardsWithoutFF = [
        _stacks[24],
        _stacks[25],
        _stacks[26],
        _stacks[27],
        _stacks[28],
        _stacks[29],
        _stacks[30],
        _stacks[31]
      ];
    }
  }

  Future<List<CardsStack>> _getTOStacksFromDB() async {
    var list = await db.getTurnOrderStacks();
    return list;
  }

  void addTOStackToDB() async {
    var listFDB = await _getTOStacksFromDB();
    List<CardsStack> res = listFDB;
    if (listFDB.length != _stacks.length) {
      for (var i in _stacks) {
        for (var j = 0; j < listFDB.length; j++) {
          if (i.id == listFDB[j].id) {
            print(
                "TOData checkStackData res[j].id == ${res[j].id}, listFDB[j].id == ${listFDB[j].id}");
            res.removeAt(j);
            res.insert(j, const CardsStack.empty());
          }
        }
      }
      for (var element in res) {
        if (element.id != 0) {
          db.createStack(element);
        }
      }
    }
  }

  createStacks() {
    AECard cardOne;
    AECard cardTwo;
    AECard cardThree;
    AECard cardFour;
    AECard cardWild;
    AECard cardNemesis;
    AECard cardFoe;
    AECard cardFriend;
    AECard cardBliz;
    AECard cardNemesisSpecific;
    if (_cards.isNotEmpty && _cards.length > 9) {
      cardOne = _cards[0];
      cardTwo = _cards[1];
      cardThree = _cards[2];
      cardFour = _cards[3];
      cardWild = _cards[4];
      cardNemesis = _cards[5];
      cardFoe = _cards[6];
      cardFriend = _cards[7];
      cardBliz = _cards[8];
      cardNemesisSpecific = _cards[9];

      List<AECard> turnOrderOneList = [
        cardOne,
        cardOne,
        cardWild,
        cardNemesis,
        cardNemesis,
        cardFoe,
        cardFriend,
      ];

      var turnOrderOne = CardsStack(
        id: 1,
        name: 'Turn Order One',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
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

      var turnOrderOneBliz = CardsStack(
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

      var turnOrderTwo = CardsStack(
        id: 3,
        name: 'Turn Order Two',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
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

      var turnOrderTwoBliz = CardsStack(
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

      var turnOrderThree = CardsStack(
        id: 5,
        name: 'Turn Order Three',
        isActive: true,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
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

      var turnOrderThreeBliz = CardsStack(
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

      var turnOrderFour = CardsStack(
        id: 7,
        name: 'Turn Order Four',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
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

      var turnOrderFourBliz = CardsStack(
        id: 8,
        name: 'Turn Order Four Bliz',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderFourBlizList,
      );
      stacksStandart.add(turnOrderOne);
      stacksStandart.add(turnOrderOneBliz);
      stacksStandart.add(turnOrderTwo);
      stacksStandart.add(turnOrderTwoBliz);
      stacksStandart.add(turnOrderThree);
      stacksStandart.add(turnOrderThreeBliz);
      stacksStandart.add(turnOrderFour);
      stacksStandart.add(turnOrderFourBliz);

      // Turn order stacks with specific nemesis card
      List<AECard> turnOrderOneWSpecList = [
        cardOne,
        cardOne,
        cardWild,
        cardNemesis,
        cardNemesis,
        cardFoe,
        cardFriend,
        cardNemesisSpecific,
      ];

      var turnOrderOneWSpec = CardsStack(
        id: 9,
        name: 'Turn Order One + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderOneWSpecList,
      );

      List<AECard> turnOrderOneBlizWSpecList = [
        cardOne,
        cardOne,
        cardWild,
        cardNemesis,
        cardBliz,
        cardFoe,
        cardFriend,
        cardNemesisSpecific,
      ];

      var turnOrderOneBlizWSpec = CardsStack(
        id: 10,
        name: 'Turn Order One Bliz + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderOneBlizWSpecList,
      );

      List<AECard> turnOrderTwoWSpecList = [
        cardOne,
        cardTwo,
        cardOne,
        cardTwo,
        cardNemesis,
        cardNemesis,
        cardFoe,
        cardFriend,
        cardNemesisSpecific,
      ];

      var turnOrderTwoWSpec = CardsStack(
        id: 11,
        name: 'Turn Order Two + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderTwoWSpecList,
      );

      List<AECard> turnOrderTwoBlizWSpecList = [
        cardOne,
        cardTwo,
        cardOne,
        cardTwo,
        cardNemesis,
        cardBliz,
        cardFoe,
        cardFriend,
        cardNemesisSpecific,
      ];

      var turnOrderTwoBlizWSpec = CardsStack(
        id: 12,
        name: 'Turn Order Two Bliz + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderTwoBlizWSpecList,
      );

      List<AECard> turnOrderThreeWSpecList = [
        cardOne,
        cardTwo,
        cardThree,
        cardWild,
        cardNemesis,
        cardNemesis,
        cardFoe,
        cardFriend,
        cardNemesisSpecific,
      ];

      var turnOrderThreeWSpec = CardsStack(
        id: 13,
        name: 'Turn Order Three + Specific Nemesis card',
        isActive: true,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderThreeWSpecList,
      );

      List<AECard> turnOrderThreeBlizWSpecList = [
        cardOne,
        cardTwo,
        cardThree,
        cardWild,
        cardNemesis,
        cardBliz,
        cardFoe,
        cardFriend,
        cardNemesisSpecific,
      ];

      var turnOrderThreeBlizWSpec = CardsStack(
        id: 14,
        name: 'Turn Order Three Bliz + Specific Nemesis card',
        isActive: true,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderThreeBlizWSpecList,
      );

      List<AECard> turnOrderFourWSpecList = [
        cardOne,
        cardTwo,
        cardThree,
        cardFour,
        cardNemesis,
        cardNemesis,
        cardFoe,
        cardFriend,
        cardNemesisSpecific
      ];

      var turnOrderFourWSpec = CardsStack(
        id: 15,
        name: 'Turn Order Four + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderFourWSpecList,
      );

      List<AECard> turnOrderFourBlizWSpecList = [
        cardOne,
        cardTwo,
        cardThree,
        cardFour,
        cardNemesis,
        cardBliz,
        cardFoe,
        cardFriend,
        cardNemesisSpecific,
      ];

      var turnOrderFourBlizWSpec = CardsStack(
        id: 16,
        name: 'Turn Order Four Bliz + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderFourBlizWSpecList,
      );

      stacksWithThreeNemesisCards.add(turnOrderOneWSpec);
      stacksWithThreeNemesisCards.add(turnOrderOneBlizWSpec);
      stacksWithThreeNemesisCards.add(turnOrderTwoWSpec);
      stacksWithThreeNemesisCards.add(turnOrderTwoBlizWSpec);
      stacksWithThreeNemesisCards.add(turnOrderThreeWSpec);
      stacksWithThreeNemesisCards.add(turnOrderThreeBlizWSpec);
      stacksWithThreeNemesisCards.add(turnOrderFourWSpec);
      stacksWithThreeNemesisCards.add(turnOrderFourBlizWSpec);

      //Turn Order stacks without Friend and Foe
      List<AECard> turnOrderOneListWFF = [
        cardOne,
        cardOne,
        cardWild,
        cardNemesis,
        cardNemesis,
      ];

      var turnOrderOneWFF = CardsStack(
        id: 17,
        name: 'Turn Order One without friend and foe',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderOneListWFF,
      );

      List<AECard> turnOrderOneBlizListWFF = [
        cardOne,
        cardOne,
        cardWild,
        cardNemesis,
        cardBliz,
      ];

      var turnOrderOneBlizWFF = CardsStack(
        id: 18,
        name: 'Turn Order One Bliz without friend and foe',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderOneBlizListWFF,
      );

      List<AECard> turnOrderTwoListWFF = [
        cardOne,
        cardTwo,
        cardOne,
        cardTwo,
        cardNemesis,
        cardNemesis,
      ];

      var turnOrderTwoWFF = CardsStack(
        id: 19,
        name: 'Turn Order Two without friend and foe',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderTwoListWFF,
      );

      List<AECard> turnOrderTwoBlizListWFF = [
        cardOne,
        cardTwo,
        cardOne,
        cardTwo,
        cardNemesis,
        cardBliz,
      ];

      var turnOrderTwoBlizWFF = CardsStack(
        id: 20,
        name: 'Turn Order Two Bliz without friend and foe',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderTwoBlizListWFF,
      );

      List<AECard> turnOrderThreeListWFF = [
        cardOne,
        cardTwo,
        cardThree,
        cardWild,
        cardNemesis,
        cardNemesis,
      ];

      var turnOrderThreeWFF = CardsStack(
        id: 21,
        name: 'Turn Order Three without friend and foe',
        isActive: true,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderThreeListWFF,
      );

      List<AECard> turnOrderThreeBlizListWFF = [
        cardOne,
        cardTwo,
        cardThree,
        cardWild,
        cardNemesis,
        cardBliz,
      ];

      var turnOrderThreeBlizWFF = CardsStack(
        id: 22,
        name: 'Turn Order Three Bliz without friend and foe',
        isActive: true,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderThreeBlizListWFF,
      );

      List<AECard> turnOrderFourListWFF = [
        cardOne,
        cardTwo,
        cardThree,
        cardFour,
        cardNemesis,
        cardNemesis,
      ];

      var turnOrderFourWFF = CardsStack(
        id: 23,
        name: 'Turn Order Four without friend and foe',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderFourListWFF,
      );

      List<AECard> turnOrderFourBlizListWFF = [
        cardOne,
        cardTwo,
        cardThree,
        cardFour,
        cardNemesis,
        cardBliz,
      ];

      var turnOrderFourBlizWFF = CardsStack(
        id: 24,
        name: 'Turn Order Four Bliz without friend and foe',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderFourBlizListWFF,
      );
      stacksWithoutFF.add(turnOrderOneWFF);
      stacksWithoutFF.add(turnOrderOneBlizWFF);
      stacksWithoutFF.add(turnOrderTwoWFF);
      stacksWithoutFF.add(turnOrderTwoBlizWFF);
      stacksWithoutFF.add(turnOrderThreeWFF);
      stacksWithoutFF.add(turnOrderThreeBlizWFF);
      stacksWithoutFF.add(turnOrderFourWFF);
      stacksWithoutFF.add(turnOrderFourBlizWFF);

      // Turn order stacks without Friend and Foe + Specific nemesis card
      List<AECard> turnOrderOneWSpecListWFF = [
        cardOne,
        cardOne,
        cardWild,
        cardNemesis,
        cardNemesis,
        cardNemesisSpecific,
      ];

      var turnOrderOneWSpecWFF = CardsStack(
        id: 25,
        name: 'Turn Order One without friend and foe + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderOneWSpecListWFF,
      );

      List<AECard> turnOrderOneBlizWSpecListWFF = [
        cardOne,
        cardOne,
        cardWild,
        cardNemesis,
        cardBliz,
        cardNemesisSpecific,
      ];

      var turnOrderOneBlizWSpecWFF = CardsStack(
        id: 26,
        name: 'Turn Order One Bliz without friend and foe + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderOneBlizWSpecListWFF,
      );

      List<AECard> turnOrderTwoWSpecListWFF = [
        cardOne,
        cardTwo,
        cardOne,
        cardTwo,
        cardNemesis,
        cardNemesis,
        cardNemesisSpecific,
      ];

      var turnOrderTwoWSpecWFF = CardsStack(
        id: 27,
        name: 'Turn Order Two without friend and foe + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderTwoWSpecListWFF,
      );

      List<AECard> turnOrderTwoBlizWSpecListWFF = [
        cardOne,
        cardTwo,
        cardOne,
        cardTwo,
        cardNemesis,
        cardBliz,
        cardNemesisSpecific,
      ];

      var turnOrderTwoBlizWSpecWFF = CardsStack(
        id: 28,
        name: 'Turn Order Two Bliz without friend and foe + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderTwoBlizWSpecListWFF,
      );

      List<AECard> turnOrderThreeWSpecListWFF = [
        cardOne,
        cardTwo,
        cardThree,
        cardWild,
        cardNemesis,
        cardNemesis,
        cardNemesisSpecific,
      ];

      var turnOrderThreeWSpecWFF = CardsStack(
        id: 29,
        name: 'Turn Order Three without friend and foe + Specific Nemesis card',
        isActive: true,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderThreeWSpecListWFF,
      );

      List<AECard> turnOrderThreeBlizWSpecListWFF = [
        cardOne,
        cardTwo,
        cardThree,
        cardWild,
        cardNemesis,
        cardBliz,
        cardNemesisSpecific,
      ];

      var turnOrderThreeBlizWSpecWFF = CardsStack(
        id: 30,
        name: 'Turn Order Three Bliz without friend and foe + Specific Nemesis card',
        isActive: true,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderThreeBlizWSpecListWFF,
      );

      List<AECard> turnOrderFourWSpecListWFF = [
        cardOne,
        cardTwo,
        cardThree,
        cardFour,
        cardNemesis,
        cardNemesis,
        cardNemesisSpecific
      ];

      var turnOrderFourWSpecWFF = CardsStack(
        id: 31,
        name: 'Turn Order Four without friend and foe + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.lightGreen,
        cards: turnOrderFourWSpecListWFF,
      );

      List<AECard> turnOrderFourBlizWSpecListWFF = [
        cardOne,
        cardTwo,
        cardThree,
        cardFour,
        cardNemesis,
        cardBliz,
        cardNemesisSpecific,
      ];

      var turnOrderFourBlizWSpecWFF = CardsStack(
        id: 32,
        name: 'Turn Order Four Bliz without friend and foe + Specific Nemesis card',
        isActive: false,
        stackType: StackType.turnOrder,
        stackColor: Colors.green,
        cards: turnOrderFourBlizWSpecListWFF,
      );

      stacksWithThreeNemesisCardsWithoutFF.add(turnOrderOneWSpecWFF);
      stacksWithThreeNemesisCardsWithoutFF.add(turnOrderOneBlizWSpecWFF);
      stacksWithThreeNemesisCardsWithoutFF.add(turnOrderTwoWSpecWFF);
      stacksWithThreeNemesisCardsWithoutFF.add(turnOrderTwoBlizWSpecWFF);
      stacksWithThreeNemesisCardsWithoutFF.add(turnOrderThreeWSpecWFF);
      stacksWithThreeNemesisCardsWithoutFF.add(turnOrderThreeBlizWSpecWFF);
      stacksWithThreeNemesisCardsWithoutFF.add(turnOrderFourWSpecWFF);
      stacksWithThreeNemesisCardsWithoutFF.add(turnOrderFourBlizWSpecWFF);

      _stacks.addAll(stacksStandart);
      _stacks.addAll(stacksWithThreeNemesisCards);
      _stacks.addAll(stacksWithoutFF);
      _stacks.addAll(stacksWithThreeNemesisCardsWithoutFF);
    } else {
      checkCards();
    }
  }
}
