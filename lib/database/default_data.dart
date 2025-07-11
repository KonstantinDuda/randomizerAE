import 'package:flutter/material.dart';

import 'cards_stack.dart';
import 'db_provider.dart';

class DefaultData {
  final _db = DBProvider();
  List<AECard> _cards = [];
  List<CardsStack> _stacks = [];
  List<HeroStack> friendFoeList = [];

  List<AECard> _ffCards = [];

  static final DefaultData _dbProvider = DefaultData._();
  DefaultData._();
  factory DefaultData() {
    return _dbProvider;
  }

  Future<List<AECard>> getCards() async {
    if (_cards.isNotEmpty) {
      print("Default Data getCards _cards.length == ${_cards.length}");
      return _cards;
    } else {
      print("Default Data getCards _cards was empty");
      return await _db.getAllCards();
    }
  }

  setCards(List<AECard> newCards) {
    _cards = newCards;
  }

  Future<List<CardsStack>> getStacks() async {
    if (_stacks.isNotEmpty) {
      print("Default Data getStacks _stacks.length == ${_stacks.length}");
      return _stacks;
    } else {
      print("Default Data getStacks _stacks was empty");
      return await _db.getAllStacks();
    }
  }

  setStacks(List<CardsStack> newStacks) {
    _stacks = newStacks;
  }

  Future<List<HeroStack>> getHeroes() async {
    if (friendFoeList.isNotEmpty) {
      print(
          "Default Data getHeroes friendFoeList.length == ${friendFoeList.length}");
      return friendFoeList;
    } else {
      print("Default Data getHeroes friendFoeList was empty");
      return await _db.getAllHeroes();
    }
  }

  setHeroes(List<HeroStack> newHeroes) {
    friendFoeList = newHeroes;
  }

  createDefaultData() async {
    var firstRunCards = await _db.getAllCards();
    if (firstRunCards.isEmpty) {
      print("DefaultData createDefaultData firstRun = true");
      createTurnOrderData();
      //checkCards();
      createCards();

      createFriendFoeHeroes();
      checkStacks();
    } else {
      _cards = firstRunCards;
      friendFoeList = await _db.getAllHeroes();
      _stacks = await _db.getAllStacks();
      print(
          "DefaultData createDefaultData firstRun.length == ${firstRunCards.length}");
    }

    /* var firstRunHeroes = await _db.getAllHeroes();
    if (firstRunHeroes.isEmpty) {
      createFriendFoeHeroes();
    } else {
      friendFoeList = firstRunHeroes;
      print(
          "DefaultData createDefaultData firstRunHeroes.length == ${firstRunHeroes.length}");
    }

    var firstRunStacks = await _db.getAllStacks();
    if (firstRunStacks.isEmpty) {
      checkStacks();
    } else {
      _stacks = firstRunStacks;
      print(
          "DefaultData createDefaultData firstRunStacks.length == ${firstRunStacks.length}");
    }*/

    //checkStacks();
    print("\n DefaultData createDefaultData is called \n");
  }

  createTurnOrderData() {
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

    _db.createCard(cardOne);
    _db.createCard(cardTwo);
    _db.createCard(cardThree);
    _db.createCard(cardFour);
    _db.createCard(cardWild);
    _db.createCard(cardNemesis);
    _db.createCard(cardFoe);
    _db.createCard(cardFriend);
    _db.createCard(cardBliz);
    _db.createCard(cardNemesisSpecific);

    _cards.addAll([
      cardOne,
      cardTwo,
      cardThree,
      cardFour,
      cardWild,
      cardNemesis,
      cardFoe,
      cardFriend,
      cardBliz,
      cardNemesisSpecific
    ]);

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
      id: 1,
      name: 'Turn Order Three',
      isActive: true,
      stackType: StackType.turnOrder,
      stackColor: const Color.fromARGB(255, 158, 158, 158),
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
      id: 2,
      name: 'Turn Order Three Bliz',
      isActive: true,
      stackType: StackType.turnOrder,
      stackColor: const Color.fromARGB(255, 76, 175, 80),
      cards: turnOrderThreeBlizList,
    );

    _db.createStack(turnOrderThree);
    _db.createStack(turnOrderThreeBliz);
    _stacks.add(turnOrderThree);
    _stacks.add(turnOrderThreeBliz);
  }

  createFriendFoeHeroes() async {
    if (friendFoeList.isEmpty) {
      //var dalanaStack = await _db.getStackById(3);
      HeroStack dalanaTheHealer = HeroStack(
          id: 1,
          name: "Dalana, The Healer",
          isFriend: true,
          heroStacks: [/*dalanaStack*/],
          energyClosetCount: 5,
          ability: "Bandage: Any player or Gravehold gains 4 life");

      //var theScavengerStack = await _db.getStackById(4);
      HeroStack theScavenger = HeroStack(
          id: 2,
          name: "The Scavenger",
          isFriend: false,
          heroStacks: [/*theScavengerStack*/],
          energyClosetCount: 4,
          ability:
              "Cull the stragglers: The player with the lowest life suffers 4 damage");

      //var adStack = await _db.getStackById(5);
      //var adSupStack = await _db.getStackById(6);
      HeroStack adelheimTheBlacksmith = HeroStack(
          id: 3,
          name: "Adelheim, The Blacksmith",
          isFriend: true,
          heroStacks: [/*adStack, adSupStack*/],
          energyClosetCount: 4,
          ability:
              "Gather scrap: Each player may return up to three cards in their discard "
              "pile that cost 0 money to their hand");

      // var myrStack = await _db.getStackById(7);
      HeroStack myrnaTheScholar = HeroStack(
          id: 4,
          name: "Myrna, The Scholar",
          isFriend: true,
          heroStacks: [/*myrStack*/],
          energyClosetCount: 4,
          ability: "Study the ancients: Myrna gains 4 Knowledge");

      //var fawnStack = await _db.getStackById(8);
      //   var fawnSupStack = await _db.getStackById(9);
      HeroStack fawnTheAlchemist = HeroStack(
          id: 5,
          name: "Fawn, The Alchemist",
          isFriend: true,
          heroStacks: [/*fawnStack, fawnSupStack*/],
          energyClosetCount: 6,
          ability:
              "Custic brew: For each spell in the Cauldron, deal damage equal to its "
              "cost twice. Then, destroy spell in the Cauldrone");

      //  var corrStack = await _db.getStackById(10);
      //  var corrSupStack = await _db.getStackById(11);
      HeroStack theCorrosion = HeroStack(
          id: 6,
          name: "The Corrosion",
          isFriend: false,
          heroStacks: [/*corrStack, corrSupStack*/],
          energyClosetCount: 5,
          ability:
              "Return to dust: Remove 2 power tokens tokens from each power in play. "
              "Gravehold suffers 5 damage");

      //var swStack = await _db.getStackById(12);
      //var swSupStack = await _db.getStackById(13);
      HeroStack theSwarm = HeroStack(
          id: 7,
          name: "The Swarm",
          isFriend: false,
          heroStacks: [/*swStack, swSupStack*/],
          energyClosetCount: 5,
          ability:
              "Call the hive: Place the bottomost minion from the nemesis discard pile "
              "back into play. If there are no minions in the nemesis discard pile, "
              "place two Broodling into play instead");

      //var culStack = await _db.getStackById(14);
      //var culSupStack = await _db.getStackById(15);
      HeroStack theCultist = HeroStack(
          id: 8,
          name: "The Cultist",
          isFriend: false,
          heroStacks: [/*culStack, culSupStack*/],
          energyClosetCount: 4,
          ability:
              "Feed the ritual: Volatile Pylon gains 2 2 life. Then remove a power token "
              "from Ritual of Flame three times");

      print("DefaultData createFriendFoeHeroes with Empty heroStacks");
      friendFoeList.clear();
      friendFoeList.addAll([
        dalanaTheHealer,
        theScavenger,
        adelheimTheBlacksmith,
        myrnaTheScholar,
        fawnTheAlchemist,
        theCorrosion,
        theSwarm,
        theCultist
      ]);
    } else if (friendFoeList.length < 8) {
      friendFoeList.clear();
      createFriendFoeHeroes();
    }
  }

  HeroStack getHeroByStackId(int stackId) {
    for (var element in friendFoeList) {
      if (element.heroStacks.isNotEmpty) {
        if (element.heroStacks[0].id == stackId) {
          print(
              "DefaultData getHeroByStackId element.heroStacks[0].id == ${element.heroStacks[0].id}");
          return element;
        }
      } else {
        print("getHeroByStackId element.heroStacks.isEmpty");
      }
    }
    return const HeroStack.empty();
  }

  void addCardsToDB() async {

    for (var element in _cards) {
      _db.createCard(element);
    }
    //var allCards = await _db.getAllCards();
    // print("FriendFoeData addCardsToDB allCards.length == ${allCards.length}");
    print("FriendFoeData addCardsToDB in comment now");
  }

  createCards() {
    var cardDE = AECard(
      id: 11,
      text:
          'Energize: \n Dalana, the Healer gains 2 charges. OR Any player gains 1 charge',
      imgPath: 'assets/images/friend foe/friend/dalana energize.png',
    );
    var cardDS = AECard(
      id: 12,
      text:
          'Soothing Aura: \n Any player draws a card. OR Any player gains 2 money tokens',
      imgPath: 'assets/images/friend foe/friend/dalana soothing aura.png',
    );
    var cardDEn = AECard(
      id: 13,
      text:
          'Enhance: \n Any player focuses a breach. OR Any player discards a prepped spell. '
          'If they do. Dalana, the Healer gains 3 charges',
      imgPath: 'assets/images/friend foe/friend/dalana enhance.png',
    );
    var cardDR = AECard(
      id: 14,
      text:
          'Restore: \n Dalana, the Healer gains 2 charges. OR Any player returns a card '
          'from their discard pile to their hand',
      imgPath: 'assets/images/friend foe/friend/dalana restore.png',
    );
    var cardSCC = AECard(
      id: 15,
      text:
          'Carrion Claw: \n The Scavenger gains 2 charges. OR Any player loses 2 charges',
      imgPath: 'assets/images/friend foe/foe/scavenger carrion claw.png',
    );
    var cardSSW = AECard(
      id: 16,
      text:
          'Screeching Wail: \n The Scavenger gains 1 charge. Any player may discard a prepped spell '
          'that costs 3 money or more. If they dont, the Scavenger gains an additional 2 charges',
      imgPath: 'assets/images/friend foe/foe/scavenger screeching wail.png',
    );
    var cardSR = AECard(
      id: 17,
      text:
          'Reclaim: \n Any player discards their two most expensive cards in hand and then '
          'draws a card. OR Gravehold suffers 3 damage',
      imgPath: 'assets/images/friend foe/foe/scavenger reclaim.png',
    );
    var cardSSS = AECard(
      id: 18,
      text:
          'Shadow Slash: \n Gravehold suffers 3 damage. OR The Scavenger gains 3 charges and the '
          'friend gains 1 charge',
      imgPath: 'assets/images/friend foe/foe/scavenger shadow slash.png',
    );
    var cardAA = AECard(
      id: 19,
      text:
          'Amplify: \n Adelheim, the Blacksmith gains 2 charges. OR Any player destroys a Spark '
          'in hand or discard pile and gains a Forged Spark',
      imgPath: 'assets/images/friend foe/friend/adelheim amplify.png',
    );
    var cardABF = AECard(
      id: 20,
      text:
          'Blazing Furnace: \n Any player destroys a Crystal in hand or discard pile and gains a Forged '
          'Crystal. OR Any player returns up to two cards from their discard pile '
          'that cost 0 money to their hand',
      imgPath: 'assets/images/friend foe/friend/adelheim blazing funrance.png',
    );
    var cardAB = AECard(
      id: 21,
      text:
          'Burnish: \n Any player destroys a Crystal or Spark in hand. That player gains the '
          'corresponding Forged card and places it into their hand. OR Any player '
          'loses 2 charges. If they do, Adelheim, the Blacksmith gains 4 charges',
      imgPath: 'assets/images/friend foe/friend/adelheim burnish.png',
    );
    var cardAPS = AECard(
      id: 22,
      text:
          'Polished steel: \n Adelheim, the Blacksmith gains 2 charges. OR Any player discards a '
          'card in hand that cost 2 money or more. If they do, they gains 3 charges',
      imgPath: 'assets/images/friend foe/friend/adelheim polished steel.png',
    );
    var cardAFC = AECard(
      id: 23,
      text: 'Forged Crystal: \n Gain 2 money',
      imgPath: 'assets/images/friend foe/friend/adelheim forged crystal.png',
    );
    var cardAFS = AECard(
      id: 24,
      text: 'Forged Spark: \n Cast: Deal 2 damage',
      imgPath: 'assets/images/friend foe/friend/adelheim forged spark.png',
    );
    var cardMAS = AECard(
      id: 25,
      text:
          'Ancient Secrets: \n Myrna, the Scholar gains 2 charges. OR Myrna, the Scholar loses 1 Knowledge. '
          'If she does, reveal the turn order deck and return it in any order',
      imgPath: 'assets/images/friend foe/friend/myrna ancient secret.png',
    );
    var cardMA = AECard(
      id: 26,
      text:
          'Archive: \n Any player draws three cards and discards any cards drawn this way that '
          'cost 3 money or more. OR Myrna loses any amount of Knowledge. The players '
          'collectively draw cards equal to the Knowledge lost this way',
      imgPath: 'assets/images/friend foe/friend/myrna archive.png',
    );
    var cardMD = AECard(
      id: 27,
      text:
          'Delve: \n Myrna, the Scholar gains 2 charges. OR Myrna, the Scholar loses 1 Knowledge. '
          'if she does, any player gains 4 money tokens',
      imgPath: 'assets/images/friend foe/friend/myrna delve.png',
    );
    var cardMS = AECard(
      id: 28,
      text:
          'Study: \n Myrna, the Scholar gains 1 charge. You may have the foe gain 1 charge. '
          'If you do, Myrna gains an additional 2 charges. OR Myrna, the Scholar '
          'loses 2 knowledge. If she does, any player casts a prepped spell '
          'without discarding it',
      imgPath: 'assets/images/friend foe/friend/myrna study.png',
    );
    var cardFAI = AECard(
      id: 29,
      text:
          'Arcane Infusion: Any player may gain an Incendiary Catalyst and place it on top of their deck. '
          'OR Any player casts a prepped spell. That spell deals an additional 1 damage',
      imgPath: 'assets/images/friend foe/friend/fawn arcane infusion.png',
    );
    var cardFBB = AECard(
      id: 30,
      text:
          'Bubbling Brew: Fawn, the Alchemist gains 2 charges. OR Any player places a spell that costs '
          '2 money or more from their hand into the Cauldron and draws a card',
      imgPath: 'assets/images/friend foe/friend/fawn bubbling brew.png',
    );
    var cardFGI = AECard(
      id: 31,
      text:
          'Gather Ingredients: Any player gains a spell that costs 5 money or less from the supply. OR '
          'Any player gains 1 charge',
      imgPath: 'assets/images/friend foe/friend/fawn gather ingredients.png',
    );
    var cardFP = AECard(
      id: 32,
      text:
          'Prepare: Fawn, the Alchemist gains 2 charges. OR Any player gains an Incendiary'
          'Catalyst and an money token',
      imgPath: 'assets/images/friend foe/friend/fawn prepare.png',
    );
    var cardFIC = AECard(
      id: 33,
      text:
          'Incendiary Catalyst: Cast: Deal 3 damage. You may place a spell that costs 2 money or more from'
          'your hand or discard pile into the Cauldron',
      imgPath: 'assets/images/friend foe/friend/fawn incendiary catalyst.png',
    );
    var cardCL = AECard(
      id: 34,
      text:
          'Leech: The Corrosion gains 2 charges. OR Any player discards a gem in hand that '
          'costs 3 money or more',
      imgPath: 'assets/images/friend foe/foe/corrosion leech.png',
    );
    var cardCE = AECard(
      id: 35,
      text:
          'Empower: Remove 1 power token from each power in play, and the nemesis gains 6 life '
          'OR Place a Draining Sign into lpay',
      imgPath: 'assets/images/friend foe/foe/corrosion empower.png',
    );
    var cardCII = AECard(
      id: 36,
      text:
          'Imbue Inevitability: The Corrosion gains 2 charges. OR Place the bottommost power card from '
          'the nemesis discard pile into play. Any player gains 2 charges',
      imgPath: 'assets/images/friend foe/foe/corrosion imbue inevitability.png',
    );
    var cardCD = AECard(
      id: 37,
      text: 'Diminish: Place a Draining Sign into play',
      imgPath: 'assets/images/friend foe/foe/corrosion diminish.png',
    );
    var cardCDS = AECard(
      id: 38,
      text:
          'Draining Sign: TO DISCARD: Spend 5 money. Return this card to the Draining Sign Pile '
          'POWER 3: Any player suffers 4 damage. Return this to the Draining Sign pile',
      imgPath: 'assets/images/friend foe/foe/corrosion draining sign.png',
    );
    var cardSwW = AECard(
      id: 39,
      text: 'Wriggle: The Swarm gains 2 charges. OR Gravehold suffers 3 damage',
      imgPath: 'assets/images/friend foe/foe/swarm wriggle.png',
    );
    var cardSwSS = AECard(
      id: 40,
      text:
          'Summoning Screech: Place a Broodling into play with 4 life. OR Any player discards a relic '
          'in hand that costs 2 money or more',
      imgPath: 'assets/images/friend foe/foe/swarm summoning screech.png',
    );
    var cardSwDD = AECard(
      id: 41,
      text:
          'Descend and Devour: Place a Broodling into play. The swarm gains 1 charge',
      imgPath: 'assets/images/friend foe/foe/swarm descend and devour.png',
    );
    var cardSwBF = AECard(
      id: 42,
      text:
          'Blistered Flesh: Place a Broodling into play and gravehold suffers 2 damage. OR The Swarm '
          'gains 3 charges and the friend gains 1 charge',
      imgPath: 'assets/images/friend foe/foe/swarm blistered flesh.png',
    );
    var cardSwB = AECard(
      id: 43,
      text:
          'Broodling: When this is discarded, return it to the Broodling deck. PERSISTENT: '
          'Any player suffers 1 damage and discards a card HEALTH: 3',
      imgPath: 'assets/images/friend foe/foe/swarm broodling.png',
    );
    var cardCuBB = AECard(
      id: 44,
      text:
          'Burn Bright: The Cultist gains 2 charges. OR Volatile Pylon gains 4 life',
      imgPath: 'assets/images/friend foe/foe/cultist burn bright.png',
    );
    var cardCuM = AECard(
      id: 45,
      text:
          'Melt: If Volatile Pylon has 5 or more life, any player discards two cards in '
          'hand. Otherwise, Volatile Pylon gains 4 life',
      imgPath: 'assets/images/friend foe/foe/cultist melt.png',
    );
    var cardCuFF = AECard(
      id: 46,
      text:
          'Feed the Flames: The Cultist gains 1 charge. Any player may discard a gem in hand that '
          'costs a 3 money or more. If they dont Volatile Pylon gains 3 life',
      imgPath: 'assets/images/friend foe/foe/cultist feed the flames.png',
    );
    var cardCuSS = AECard(
      id: 47,
      text:
          'Smothering Smog: Volatile Pylon gains 2 life and any player loses 1 charge. OR The Cultist '
          'gains 3 charges and the gains 1 charge',
      imgPath: 'assets/images/friend foe/foe/cultist smothering smog.png',
    );
    var cardCuRofF = AECard(
      id: 48,
      text:
          'Ritual of flame: POWER 5: Any player or Gravehold suffers damage equal to thelife of '
          'Volatile Pylon minus 1. Place 5 power tokens on this instead of discarding it',
      imgPath: 'assets/images/friend foe/foe/cultist ritual of flame.png',
    );
    var cardCuVP = AECard(
      id: 49,
      text:
          'Volatile Pylon: This enters play with 4 life. This minion has no maximum life. '
          'This minions life cannot be reduced below 1',
      imgPath: 'assets/images/friend foe/foe/cultist volatile pylon.png',
    );
    _ffCards.add(cardDE);
    _ffCards.add(cardDS);
    _ffCards.add(cardDEn);
    _ffCards.add(cardDR);
    _ffCards.add(cardSCC);
    _ffCards.add(cardSSW);
    _ffCards.add(cardSR);
    _ffCards.add(cardSSS);
    _ffCards.add(cardAA);
    _ffCards.add(cardABF);
    _ffCards.add(cardAB);
    _ffCards.add(cardAPS);
    _ffCards.add(cardMAS);
    _ffCards.add(cardMA);
    _ffCards.add(cardMD);
    _ffCards.add(cardMS);
    _ffCards.add(cardFAI);
    _ffCards.add(cardFBB);
    _ffCards.add(cardFGI);
    _ffCards.add(cardFP);
    _ffCards.add(cardCL);
    _ffCards.add(cardCE);
    _ffCards.add(cardCII);
    _ffCards.add(cardCD);
    _ffCards.add(cardSwW);
    _ffCards.add(cardSwSS);
    _ffCards.add(cardSwDD);
    _ffCards.add(cardSwBF);
    _ffCards.add(cardCuBB);
    _ffCards.add(cardCuM);
    _ffCards.add(cardCuFF);
    _ffCards.add(cardCuSS);

    _ffCards.add(cardAFC);
    _ffCards.add(cardAFS);
    _ffCards.add(cardFIC);
    _ffCards.add(cardCDS);
    _ffCards.add(cardSwB);
    _ffCards.add(cardCuRofF);
    _ffCards.add(cardCuVP);

    _cards.addAll(_ffCards);
    addCardsToDB();
  }

  // Friend Foe Stacks
  void checkStacks() async {
    var listFDB = await _getFFStacksFromDB();
    if (listFDB.length <= 12) {
      print("FriendFoeData checkStacks listFDB.length <= 7");
      createStacks();
    } else {
      print("FriendFoeData checkStacks listFDB.length > 7");
      if (friendFoeList.isNotEmpty) {
        if (friendFoeList.length < 8) {
          friendFoeList.clear();
          createFriendFoeHeroes();
        }
      } else {
        print("FriendFoeData checkStacks friendFoeList.isEmpty");
        createFriendFoeHeroes();
      }
    }
  }

  Future<List<CardsStack>> _getFFStacksFromDB() async {
    var list = await _db.getFriendFoeStacks();
    return list;
  }

  createStacks() {
    //checkCards();

    List<AECard> dalanaList = [
      _ffCards[0],
      _ffCards[1],
      _ffCards[2],
      _ffCards[3]
    ];
    CardsStack dalanaTheHealerStack = CardsStack(
        id: 3,
        name: "Dalana, the healer",
        isActive: true,
        stackType: StackType.friendFoe,
        stackColor: const Color.fromARGB(255, 33, 150, 243),
        cards: dalanaList);
    friendFoeList[0].heroStacks.add(dalanaTheHealerStack);
    _stacks.add(dalanaTheHealerStack);
    _db.createStack(dalanaTheHealerStack);
    print(
        "FriendFoeData createStacks dalanaTheHealerStack.name == ${dalanaTheHealerStack.name}");

    List<AECard> theScavengerList = [
      _ffCards[4],
      _ffCards[5],
      _ffCards[6],
      _ffCards[7]
    ];
    CardsStack theScavengerStack = CardsStack(
        id: 4,
        name: "The Scavenger",
        isActive: true,
        stackType: StackType.friendFoe,
        stackColor: const Color.fromARGB(255, 244, 67, 54),
        cards: theScavengerList);
//    theScavenger.heroStacks.add(theScavengerStack);
    friendFoeList[1].heroStacks.add(theScavengerStack);
    _stacks.add(theScavengerStack);
    _db.createStack(theScavengerStack);
    print(
        "FriendFoeData createStacks theScavengerStack.name == ${theScavengerStack.name}");

    List<AECard> adelheimList = [
      _ffCards[8],
      _ffCards[9],
      _ffCards[10],
      _ffCards[11]
    ];
    // List<AECard> adelheimListTwo = [
    //   _ffCards[32],
    //   _ffCards[32],
    //   _ffCards[32],
    //   _ffCards[32],
    //   _ffCards[32],
    //   _ffCards[32],
    //   _ffCards[33],
    //   _ffCards[33],
    //   _ffCards[33],
    //   _ffCards[33]
    // ];
    CardsStack adelheimTheBlacksmithStack = CardsStack(
        id: 5,
        name: "Adelheim, the blacksmith",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: const Color.fromARGB(255, 33, 150, 243),
        cards: adelheimList);
    // CardsStack adelheimTheBlacksmithSuportStack = CardsStack(
    //     id: 6,
    //     name: "Adelheim, the blacksmith. Support stack",
    //     isActive: false,
    //     stackType: StackType.friendFoe,
    //     stackColor: const Color.fromARGB(255, 33, 150, 243),
    //     cards: adelheimListTwo);
    // adelheimTheBlacksmith.heroStacks.add(adelheimTheBlacksmithStack);
    // adelheimTheBlacksmith.heroStacks.add(adelheimTheBlacksmithSuportStack);
    friendFoeList[2].heroStacks.add(adelheimTheBlacksmithStack);
    //friendFoeList[2].heroStacks.add(adelheimTheBlacksmithSuportStack);
    _stacks.add(adelheimTheBlacksmithStack);
    //_stacks.add(adelheimTheBlacksmithSuportStack);
    _db.createStack(adelheimTheBlacksmithStack);
    //_db.createStack(adelheimTheBlacksmithSuportStack);

    print(
        "FriendFoeData createStacks adelheimTheBlacksmithStack.name == ${adelheimTheBlacksmithStack.name}");

    List<AECard> myrnaList = [
      _ffCards[12],
      _ffCards[13],
      _ffCards[14],
      _ffCards[15]
    ];
    CardsStack myrnaTheScholarStack = CardsStack(
        id: 7,
        name: "Myrna, the scholar",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: const Color.fromARGB(255, 33, 150, 243),
        cards: myrnaList);
    //myrnaTheScholar.heroStacks.add(myrnaTheScholarStack);
    friendFoeList[3].heroStacks.add(myrnaTheScholarStack);
    _stacks.add(myrnaTheScholarStack);
    _db.createStack(myrnaTheScholarStack);
    print(
        "FriendFoeData createStacks myrnaTheScholarStack.name == ${myrnaTheScholarStack.name}");

    List<AECard> fawnList = [
      _ffCards[16],
      _ffCards[17],
      _ffCards[18],
      _ffCards[19]
    ];
    // List<AECard> fawnSuportList = [
    //   _ffCards[34],
    //   _ffCards[34],
    //   _ffCards[34],
    //   _ffCards[34],
    //   _ffCards[34],
    //   _ffCards[34]
    // ];
    CardsStack fawnTheAlchemistStack = CardsStack(
        id: 8,
        name: "Fawn, the alchemist",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: const Color.fromARGB(255, 33, 150, 243),
        cards: fawnList);
    // CardsStack fawnTheAlchemistSupportStack = CardsStack(
    //     id: 9,
    //     name: "Fawn, the alchemist. Support stack",
    //     isActive: false,
    //     stackType: StackType.friendFoe,
    //     stackColor: const Color.fromARGB(255, 33, 150, 243),
    //     cards: fawnSuportList);
    // fawnTheAlchemist.heroStacks.add(fawnTheAlchemistStack);
    // fawnTheAlchemist.heroStacks.add(fawnTheAlchemistSupportStack);
    friendFoeList[4].heroStacks.add(fawnTheAlchemistStack);
    //friendFoeList[4].heroStacks.add(fawnTheAlchemistSupportStack);
    _stacks.add(fawnTheAlchemistStack);
    //_stacks.add(fawnTheAlchemistSupportStack);
    _db.createStack(fawnTheAlchemistStack);
    //_db.createStack(fawnTheAlchemistSupportStack);
    print(
        "FriendFoeData createStacks fawnTheAlchemistStack.name == ${fawnTheAlchemistStack.name}");

    List<AECard> corrosionList = [
      _ffCards[20],
      _ffCards[21],
      _ffCards[22],
      _ffCards[23]
    ];
    // List<AECard> corrosionSupportList = [
    //   _ffCards[35],
    //   _ffCards[35],
    //   _ffCards[35]
    // ];
    CardsStack theCorrosionStack = CardsStack(
        id: 10,
        name: "The Corrosion",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: const Color.fromARGB(255, 244, 67, 54),
        cards: corrosionList);
    // CardsStack theCorrosionSupportStack = CardsStack(
    //     id: 11,
    //     name: "The Corrosion. Support stack",
    //     isActive: false,
    //     stackType: StackType.friendFoe,
    //     stackColor: const Color.fromARGB(255, 244, 67, 54),
    //     cards: corrosionSupportList);
    // theCorrosion.heroStacks.add(theCorrosionStack);
    // theCorrosion.heroStacks.add(theCorrosionSupportStack);
    friendFoeList[5].heroStacks.add(theCorrosionStack);
    //friendFoeList[5].heroStacks.add(theCorrosionSupportStack);
    _stacks.add(theCorrosionStack);
    //_stacks.add(theCorrosionSupportStack);
    _db.createStack(theCorrosionStack);
    //_db.createStack(theCorrosionSupportStack);
    print(
        "FriendFoeData createStacks theCorrosionStack.name == ${theCorrosionStack.name}");

    List<AECard> swarmList = [
      _ffCards[24],
      _ffCards[25],
      _ffCards[26],
      _ffCards[27]
    ];
    // List<AECard> swarmSupportList = [
    //   _ffCards[36],
    //   _ffCards[36],
    //   _ffCards[36],
    //   _ffCards[36]
    // ];
    CardsStack theSwarmStack = CardsStack(
        id: 12,
        name: "The Swarm",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: const Color.fromARGB(255, 244, 67, 54),
        cards: swarmList);
    // CardsStack theSwarmSupportStack = CardsStack(
    //     id: 13,
    //     name: "The Swarm. Support stack",
    //     isActive: false,
    //     stackType: StackType.friendFoe,
    //     stackColor: const Color.fromARGB(255, 244, 67, 54),
    //     cards: swarmSupportList);
    // theSwarm.heroStacks.add(theSwarmStack);
    // theSwarm.heroStacks.add(theSwarmSupportStack);
    friendFoeList[6].heroStacks.add(theSwarmStack);
    //friendFoeList[6].heroStacks.add(theSwarmSupportStack);
    _stacks.add(theSwarmStack);
    //_stacks.add(theSwarmSupportStack);
    _db.createStack(theSwarmStack);
    //_db.createStack(theSwarmSupportStack);
    print(
        "FriendFoeData createStacks theSwarmStack.name == ${theSwarmStack.name}");

    List<AECard> cultistList = [
      _ffCards[28],
      _ffCards[29],
      _ffCards[30],
      _ffCards[31]
    ];
    //List<AECard> cultistSupportList = [_ffCards[37], _ffCards[38]];
    CardsStack theCultistStack = CardsStack(
        id: 14,
        name: "The Cultist",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: const Color.fromARGB(255, 244, 67, 54),
        cards: cultistList);
    // CardsStack theCultistSupportStack = CardsStack(
    //     id: 15,
    //     name: "The Cultist. Support stack",
    //     isActive: false,
    //     stackType: StackType.friendFoe,
    //     stackColor: const Color.fromARGB(255, 244, 67, 54),
    //     cards: cultistSupportList);
    // theCultist.heroStacks.add(theCultistStack);
    // theCultist.heroStacks.add(theCultistSupportStack);
    friendFoeList[7].heroStacks.add(theCultistStack);
    //friendFoeList[7].heroStacks.add(theCultistSupportStack);
    _stacks.add(theCultistStack);
    //_stacks.add(theCultistSupportStack);
    _db.createStack(theCultistStack);
   // _db.createStack(theCultistSupportStack);
    print(
        "FriendFoeData createStacks theCultistStack.name == ${theCultistStack.name}");

    _db.createHero(friendFoeList[0]);
    _db.createHero(friendFoeList[1]);
    _db.createHero(friendFoeList[2]);
    _db.createHero(friendFoeList[3]);
    _db.createHero(friendFoeList[4]);
    _db.createHero(friendFoeList[5]);
    _db.createHero(friendFoeList[6]);
    _db.createHero(friendFoeList[7]);
  }
}
