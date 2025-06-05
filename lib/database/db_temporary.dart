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
      id: 49,
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
      cardOne,
      cardTwo,
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
      cardOne,
      cardTwo,
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
      //print("DBTemporary db.createStack($element)");
      db.createStack(element);
    }
    
    //Am I need it here? getStackFromDB(turnOrderThree.id);

    //Friend and Foe creating
    //Friend and Foe Cards
    var cardDE = AECard(
      id: 10,
      text:
          'Energize: \n Dalana, the Healer gains 2 charges. OR Any player gains 1 charge',
      imgPath: 'assets/images/friend/dalana energize.png',
    );
    var cardDS = AECard(
      id: 11,
      text:
          'Soothing Aura: \n Any player draws a card. OR Any player gains 2 money tokens',
      imgPath: 'assets/images/friend/dalana soothing aura.png',
    );
    var cardDEn = AECard(
      id: 12,
      text:
          'Enhance: \n Any player focuses a breach. OR Any player discards a prepped spell. '
          'If they do. Dalana, the Healer gains 3 charges',
      imgPath: 'assets/images/friend/dalana enhance.png',
    );
    var cardDR = AECard(
      id: 13,
      text:
          'Restore: \n Dalana, the Healer gains 2 charges. OR Any player returns a card '
          'from their discard pile to their hand',
      imgPath: 'assets/images/friend/dalana restore.png',
    );
    var cardSCC = AECard(
      id: 14,
      text:
          'Carrion Claw: \n The Scavenger gains 2 charges. OR Any player loses 2 charges',
      imgPath: 'assets/images/foe/scavenger carrion claw.png',
    );
    var cardSSW = AECard(
      id: 15,
      text:
          'Screeching Wail: \n The Scavenger gains 1 charge. Any player may discard a prepped spell '
          'that costs 3 money or more. If they dont, the Scavenger gains an additional 2 charges',
      imgPath: 'assets/images/foe/scavenger screeching wail.png',
    );
    var cardSR = AECard(
      id: 16,
      text:
          'Reclaim: \n Any player discards their two most expensive cards in hand and then '
          'draws a card. OR Gravehold suffers 3 damage',
      imgPath: 'assets/images/foe/scavenger reclaim.png',
    );
    var cardSSS = AECard(
      id: 17,
      text:
          'Shadow Slash: \n Gravehold suffers 3 damage. OR The Scavenger gains 3 charges and the '
          'friend gains 1 charge',
      imgPath: 'assets/images/foe/scavenger shadow slash.png',
    );
  //   var cardAA = AECard(
  //     id: 18,
  //     text: 'Amplify: \n Adelheim, the Blacksmith gains 2 charges. OR Any player destroys a Spark '
  //       'in hand or discard pile and gains a Forged Spark',
  //     imgPath: 'assets/images/adelheim amplify.png',
  //   );
  //   var cardABF = AECard(
  //     id: 19,
  //     text: 'Blazing Furnace: \n Any player destroys a Crystal in hand or discard pile and gains a Forged '
  //       'Crystal. OR Any player returns up to two cards from their discard pile '
  //       'that cost 0 money to their hand',
  // imgPath: 'assets/images/adelheim blazing funrance.png',
  //   );
  //   var cardAB = AECard(
  //     id: 20,
  //     text: 'Burnish: \n Any player destroys a Crystal or Spark in hand. That player gains the '
  //       'corresponding Forged card and places it into their hand. OR Any player ' 
  //       'loses 2 charges. If they do, Adelheim, the Blacksmith gains 4 charges',
  //     imgPath: 'assets/images/adelheim burnish.png',
  //   );
  //   var cardAPS = AECard(
  //     id: 21,
  //     text: 'Polished steel: \n Adelheim, the Blacksmith gains 2 charges. OR Any player discards a '
  //       'card in hand that cost 2 money or more. If they do, they gains 3 charges',
  //     imgPath: 'assets/images/adelheim polished steel.png',
  //   );
  //   var cardAFC = AECard(
  //     id: 22,
  //     text: 'Forged Crystal: \n Gain 2 money',
  //     imgPath: 'assets/images/adelheim forged crystal.png',
  //   );
  //   var cardAFS = AECard(
  //     id: 23,
  //     text: 'Forged Spark: \n Cast: Deal 2 damage',
  //     imgPath: 'assets/images/adelheim forged spark.png',
  //   );
  //   var cardMAS = AECard(
  //     id: 24,
  //     text: 'Ancient Secrets: \n Myrna, the Scholar gains 2 charges. OR Myrna, the Scholar loses 1 Knowledge. '
  //       'If she does, reveal the turn order deck and return it in any order',
  //     imgPath: 'assets/images/ancient secret.png',
  //   );
  //   var cardMA = AECard(
  //     id: 25,
  //     text: 'Archive: \n Any player draws three cards and discards any cards drawn this way that '
  //       'cost 3 money or more. OR Myrna loses any amount of Knowledge. The players '
  //       'collectively draw cards equal to the Knowledge lost this way',
  //     imgPath: 'assets/images/myrna archive.png',
  //   );
  //   var cardMD = AECard(
  //     id: 26,
  //     text: 'Delve: \n Myrna, the Scholar gains 2 charges. OR Myrna, the Scholar loses 1 Knowledge. '
  //       'if she does, any player gains 4 money tokens',
  //     imgPath: 'assets/images/myrna delve.png',
  //   );
  //   var cardMS = AECard(
  //     id: 27,
  //     text: 'Study: \n Myrna, the Scholar gains 1 charge. You may have the foe gain 1 charge. '
  //       'If you do, Myrna gains an additional 2 charges. OR Myrna, the Scholar '
  //       'loses 2 knowledge. If she does, any player casts a prepped spell ' 
  //       'without discarding it',
  //     imgPath: 'assets/images/myrna study.png',
  //   );
  //   var cardFAI = AECard(
  //     id: 28,
  //     text: 'Arcane Infusion: Any player may gain an Incendiary Catalyst and place it on top of their deck. '
  //       'OR Any player casts a prepped spell. That spell deals an additional 1 damage',
  //     imgPath: 'assets/images/fawn arcane infusion.png',
  //   );
  //   var cardFBB = AECard(
  //     id: 29,
  //     text: 'Bubbling Brew: Fawn, the Alchemist gains 2 charges. OR Any player places a spell that costs '
  //       '2 money or more from their hand into the Cauldron and draws a card',
  //     imgPath: 'assets/images/fawn bubbling brew.png',
  //   );
  //   var cardFGI = AECard(
  //     id: 30,
  //     text: 'Gather Ingredients: Any player gains a spell that costs 5 money or less from the supply. OR '
  //       'Any player gains 1 charge',
  //     imgPath: 'assets/images/fawn gather ingredients.png',
  //   );
  //   var cardFP = AECard(
  //     id: 31,
  //     text: 'Prepare: Fawn, the Alchemist gains 2 charges. OR Any player gains an Incendiary' 
  //       'Catalyst and an money token',
  //     imgPath: 'assets/images/fawn prepare.png',
  //   );
  //   var cardFIC = AECard(
  //     id: 32,
  //     text: 'Incendiary Catalyst: Cast: Deal 3 damage. You may place a spell that costs 2 money or more from' 
  //       'your hand or discard pile into the Cauldron',
  //     imgPath: 'assets/images/fawn incendiary catalyst.png',
  //   );
  //   var cardCL = AECard(
  //     id: 33,
  //     text: 'Leech: The Corrosion gains 2 charges. OR Any player discards a gem in hand that '
  //       'costs 3 money or more',
  //     imgPath: 'assets/images/corrosion leech.png',
  //   );
  //   var cardCE = AECard(
  //     id: 34,
  //     text: 'Empower: Remove 1 power token from each power in play, and the nemesis gains 6 life ' 
  //       'OR Place a Draining Sign into lpay',
  //     imgPath: 'assets/images/corrosion empower.png',
  //   );
  //   var cardCII = AECard(
  //     id: 35,
  //     text: 'Imbue Inevitability: The Corrosion gains 2 charges. OR Place the bottommost power card from '
  //       'the nemesis discard pile into play. Any player gains 2 charges',
  //     imgPath: 'assets/images/corrosion imbue inevitability.png',
  //   );
  //   var cardCD = AECard(
  //     id: 36,
  //     text: 'Diminish: Place a Draining Sign into play',
  //     imgPath: 'assets/images/corrosion diminish.png',
  //   );
  //   var cardCDS = AECard(
  //     id: 37,
  //     text: 'Draining Sign: TO DISCARD: Spend 5 money. Return this card to the Draining Sign Pile '
  //       'POWER 3: Any player suffers 4 damage. Return this to the Draining Sign pile',
  //     imgPath: 'assets/images/corrosion draining sign.png',
  //   );
  //   var cardSwW = AECard(
  //     id: 38,
  //     text: 'Wriggle: The Swarm gains 2 charges. OR Gravehold suffers 3 damage',
  //     imgPath: 'assets/images/swarm wriggle.png',
  //   );
  //   var cardSwSS = AECard(
  //     id: 39,
  //     text: 'Summoning Screech: Place a Broodling into play with 4 life. OR Any player discards a relic '
  //       'in hand that costs 2 money or more',
  //     imgPath: 'assets/images/swarm summoning screech.png',
  //   );
  //   var cardSwDD = AECard(
  //     id: 40,
  //     text: 'Descend and Devour: Place a Broodling into play. The swarm gains 1 charge',
  //     imgPath: 'assets/images/swarm descend and devour.png',
  //   );
  //   var cardSwBF = AECard(
  //     id: 41,
  //     text: 'Blistered Flesh: Place a Broodling into play and gravehold suffers 2 damage. OR The Swarm ' 
  //       'gains 3 charges and the friend gains 1 charge',
  //     imgPath: 'assets/images/swarm blistered flesh.png',
  //   );
  //   var cardSwB = AECard(
  //     id: 42,
  //     text: 'Broodling: When this is discarded, return it to the Broodling deck. PERSISTENT: '
  //       'Any player suffers 1 damage and discards a card HEALTH: 3',
  //     imgPath: 'assets/images/swarm broodling.png',
  //   );
  //   var cardCuBB = AECard(
  //     id: 43,
  //     text: 'Burn Bright: The Cultist gains 2 charges. OR Volatile Pylon gains 4 life',
  //     imgPath: 'assets/images/cultist burn bright.png',
  //   );
  //   var cardCuM = AECard(
  //     id: 44,
  //     text: 'Melt: If Volatile Pylon has 5 or more life, any player discards two cards in '
  //       'hand. Otherwise, Volatile Pylon gains 4 life',
  //     imgPath: 'assets/images/cultist melt.png',
  //   );
  //   var cardCuFF = AECard(
  //     id: 45,
  //     text: 'Feed the Flames: The Cultist gains 1 charge. Any player may discard a gem in hand that '
  //       'costs a 3 money or more. If they dont Volatile Pylon gains 3 life',
  //     imgPath: 'assets/images/cultist feed the flames.png',
  //   );
  //   var cardCuSS = AECard(
  //     id: 46,
  //     text: 'Smothering Smog: Volatile Pylon gains 2 life and any player loses 1 charge. OR The Cultist ' 
  //       'gains 3 charges and the gains 1 charge',
  //     imgPath: 'assets/images/cultist smothering smog.png',
  //   );
  //   var cardCuRofF = AECard(
  //     id: 47,
  //     text: 'Ritual of flame: POWER 5: Any player or Gravehold suffers damage equal to thelife of ' 
  //       'Volatile Pylon minus 1. Place 5 power tokens on this instead of discarding it',
  //     imgPath: 'assets/images/cultist ritual of flame.png',
  //   );
  //   var cardCuVP = AECard(
  //     id: 48,
  //     text: 'Volatile Pylon: This enters play with 4 life. This minion has no maximum life. '
  //       'This minions life cannot be reduced below 1',
  //     imgPath: 'assets/images/cultist volatile pylon.png',
  //   );
    db.createCard(cardDE);
    db.createCard(cardDS);
    db.createCard(cardDEn);
    db.createCard(cardDR);
    db.createCard(cardSCC);
    db.createCard(cardSSW);
    db.createCard(cardSR);
    db.createCard(cardSSS);
    // db.createCard(cardAA);
    // db.createCard(cardABF);
    // db.createCard(cardAB);
    // db.createCard(cardAPS);
    // db.createCard(cardMAS);
    // db.createCard(cardMA);
    // db.createCard(cardMD);
    // db.createCard(cardMS);
    // db.createCard(cardFAI);
    // db.createCard(cardFBB);
    // db.createCard(cardFGI);
    // db.createCard(cardFP);
    // db.createCard(cardCL);
    // db.createCard(cardCE);
    // db.createCard(cardCII);
    // db.createCard(cardCD);
    // db.createCard(cardSwW);
    // db.createCard(cardSwSS);
    // db.createCard(cardSwDD);
    // db.createCard(cardSwBF);
    // db.createCard(cardCuBB);
    // db.createCard(cardCuM);
    // db.createCard(cardCuFF);
    // db.createCard(cardCuSS);
    

    // db.createCard(cardAFC);
    // db.createCard(cardAFS);
    // db.createCard(cardFIC);
    // db.createCard(cardCDS);
    // db.createCard(cardSwB);
    // db.createCard(cardCuRofF);
    // db.createCard(cardCuVP);

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
    // CardsStack adelheimStack = CardsStack(
    //   id: 11,
    //   name: 'Adelheim, the Blacksmith',
    //   isActive: false,
    //   stackType: StackType.friendFoe,
    //   stackColor: Colors.blue,
    //   cards: [cardAA, cardABF, cardAB, cardAPS],
    // );
    // CardsStack myrnaStack = CardsStack(
    //   id: 12,
    //   name: 'Myrna, the Scholar',
    //   isActive: false,
    //   stackType: StackType.friendFoe,
    //   stackColor: Colors.blue,
    //   cards: [cardMAS, cardMA, cardMD, cardMS],
    // );
    // CardsStack fawnStack = CardsStack(
    //   id: 13,
    //   name: 'Fawn, the Alchemist',
    //   isActive: false,
    //   stackType: StackType.friendFoe,
    //   stackColor: Colors.blue,
    //   cards: [cardFAI, cardFBB, cardFGI, cardFP],
    // );
    // CardsStack corrosionStack = CardsStack(
    //   id: 14,
    //   name: 'The Corrosion',
    //   isActive: false,
    //   stackType: StackType.friendFoe,
    //   stackColor: Colors.red,
    //   cards: [cardCL, cardCE, cardCII, cardCD],
    // );
    // CardsStack swarmStack = CardsStack(
    //   id: 15,
    //   name: 'The Swarm',
    //   isActive: false,
    //   stackType: StackType.friendFoe,
    //   stackColor: Colors.red,
    //   cards: [cardSwW, cardSwSS, cardSwDD, cardSwBF],
    // );
    // CardsStack cultistStack = CardsStack(
    //   id: 16,
    //   name: 'The Cultist',
    //   isActive: false,
    //   stackType: StackType.friendFoe,
    //   stackColor: Colors.red,
    //   cards: [cardCuBB, cardCuM, cardCuFF, cardCuSS],
    // );

    db.createStack(dalanaStack);
    db.createStack(scavengerStack);
    _dbStacks.add(dalanaStack);
    _dbStacks.add(scavengerStack);
    setActiveFoeStack(scavengerStack.id);
    setActiveFriendStack(dalanaStack.id);
    setAvilableStacs();
    _activeFriendStack = dalanaStack;
    _activeFoeStack = scavengerStack;

    // db.createStack(adelheimStack);
    // db.createStack(myrnaStack);
    // db.createStack(fawnStack);
    // db.createStack(corrosionStack);
    // db.createStack(swarmStack);
    // db.createStack(cultistStack);
    // _dbStacks.add(adelheimStack);
    // _dbStacks.add(myrnaStack);
    // _dbStacks.add(fawnStack);
    // _dbStacks.add(corrosionStack);
    // _dbStacks.add(swarmStack);
    // _dbStacks.add(cultistStack);

    // Friend and Foe HeroStacks
    var friendDalanaTheHealer = HeroStack(
      id: 1,
      name: "Dalana, the Healer",
      isFriend: true,
      heroStacks: [dalanaStack],
      energyClosetCount: 5,
      ability: "Bandage: Any player or Gravehold gains 4 life",
    );
    var foeScavenger = HeroStack(
      id: 2,
      name: "The Scavenger",
      isFriend: false,
      heroStacks: [scavengerStack],
      energyClosetCount: 4,
      ability:
          "Cull the stragglers: The player with the lowest life suffers 4 damage",
    );
    friendfoeList.add(friendDalanaTheHealer);
    friendfoeList.add(foeScavenger);
  
    // var friendAdelheim = HeroStack(id: 3, name: 'Adelheim, the Blacksmith', isFriend: true, heroStacks: [adelheimStack], energyClosetCount: 4, ability: "Gather scrap: Each player may return up to three cards in their discard pile that cost 0 money to their hand");
    // var friendMyrna = HeroStack(id: 4, name: 'Myrna, the Scholar', isFriend: true, heroStacks: [myrnaStack], energyClosetCount: 4, ability: "Study the ancients: Myrna gains 4 Knowledge");
    // var friendFawn = HeroStack(id: 5, name: 'Fawn, the Alchemist', isFriend: true, heroStacks: [fawnStack], energyClosetCount: 6, ability: "Custic brew: For each spell in the Cauldron, deal damage equal to its cost twice. Then, destroy spell in the Cauldrone");
    // var foeCorrosion = HeroStack(id: 6, name: 'The Corrosion', isFriend: false, heroStacks: [corrosionStack], energyClosetCount: 5, ability: "Return to dust: Remove 2 power tokens from each power in play. Gravehold suffers 5 damage");
    // var foeSwarm = HeroStack(id: 7, name: 'The Swarm', isFriend: false, heroStacks: [swarmStack], energyClosetCount: 5, ability: "Call the hive: Place the bottomost minion from the nemesis discard pile back into play. If there are no minions in the nemesis discard pile, place two Broodling into play instead");
    // var foeCultist = HeroStack(id: 8, name: 'The Cultist', isFriend: false, heroStacks: [cultistStack], energyClosetCount: 4, ability: "Feed the ritual: Volatile Pylon gains 2 life. Then remove a power token from Ritual of Flame three times");
    // friendfoeList.add(friendAdelheim);
    // friendfoeList.add(friendMyrna);
    // friendfoeList.add(friendFawn);
    // friendfoeList.add(foeCorrosion);
    // friendfoeList.add(foeSwarm);
    // friendfoeList.add(foeCultist);
  }

  void setAvilableStacs() {
    _availableStacks.clear();
    for (var element in _dbStacks) {
      if (element.isActive) {
        _availableStacks.add(element);
      }
    }
  }

  /*getStackFromDB(int id) async {
    var tos = await db.getStackById(id);
    print("\n");
    print("\n");
    print("\n");
    print("\n");
    print("DBTemporary getStackFromDB($id) == $tos \n");
    print("\n");
    print("\n");
    print("\n");
    print("\n");
  }*/

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
    _activeFriendStack = await db.getStackById(id);
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

  HeroStack getHeroStackByStackId(int id) {
    //print("DBTemporary getHeroStackByStackId($id) \n");
    HeroStack heroStack = HeroStack.empty();
    for (var element in friendfoeList) {
      for (var i = 0; i < element.heroStacks.length; i++) {
        if (element.heroStacks[i].id == id) {
          heroStack = element;
          //print("DBTemporary getHeroStackByStackId($id) == $heroStack \n");
          return heroStack;
        }
      }
    }
    if (heroStack.id == 0) {
      print("DBTemporary getHeroStackByStackId($id) == HeroStack.empty() \n");
    }
    return HeroStack.empty();
  }

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
}
