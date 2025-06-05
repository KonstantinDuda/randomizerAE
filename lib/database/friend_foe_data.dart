import 'package:flutter/material.dart';

import 'cards_stack.dart';
import 'db_provider.dart';

class FriendFoeData {
  var db = DBProvider();

  List<AECard> _cards = [];
  List<CardsStack> _stacks = [];

  List<HeroStack> friendFoeList = [];
  HeroStack dalanaTheHealer = HeroStack(
      id: 1,
      name: "Dalana, The Healer",
      isFriend: true,
      heroStacks: [],
      energyClosetCount: 5,
      ability: "Bandage: Any player or Gravehold gains 4 life");
  HeroStack theScavenger = HeroStack(
      id: 2,
      name: "The Scavenger",
      isFriend: false,
      heroStacks: [],
      energyClosetCount: 4,
      ability:
          "Cull the stragglers: The player with the lowest life suffers 4 damage");
  HeroStack adelheimTheBlacksmith = HeroStack(
      id: 3,
      name: "Adelheim, The Blacksmith",
      isFriend: true,
      heroStacks: [],
      energyClosetCount: 4,
      ability:
          "Gather scrap: Each player may return up to three cards in their discard "
          "pile that cost 0 money to their hand");
  HeroStack myrnaTheScholar = HeroStack(
      id: 4,
      name: "Myrna, The Scholar",
      isFriend: true,
      heroStacks: [],
      energyClosetCount: 4,
      ability: "Study the ancients: Myrna gains 4 Knowledge");
  HeroStack fawnTheAlchemist = HeroStack(
      id: 5,
      name: "Fawn, The Alchemist",
      isFriend: true,
      heroStacks: [],
      energyClosetCount: 6,
      ability:
          "Custic brew: For each spell in the Cauldron, deal damage equal to its "
          "cost twice. Then, destroy spell in the Cauldrone");
  HeroStack theCorrosion = HeroStack(
      id: 6,
      name: "The Corrosion",
      isFriend: false,
      heroStacks: [],
      energyClosetCount: 5,
      ability:
          "Return to dust: Remove 2 power tokens tokens from each power in play. "
          "Gravehold suffers 5 damage");
  HeroStack theSwarm = HeroStack(
      id: 7,
      name: "The Swarm",
      isFriend: false,
      heroStacks: [],
      energyClosetCount: 5,
      ability:
          "Call the hive: Place the bottomost minion from the nemesis discard pile "
          "back into play. If there are no minions in the nemesis discard pile, "
          "place two Broodling into play instead");
  HeroStack theCultist = HeroStack(
      id: 8,
      name: "The Cultist",
      isFriend: false,
      heroStacks: [],
      energyClosetCount: 4,
      ability:
          "Feed the ritual: Volatile Pylon gains 2 2 life. Then remove a power token "
          "from Ritual of Flame three times");

// Friend Foe Cards
  void checkCards() async {
    var listFDB = await _getCardsFromDB();
    if (listFDB.length <= 38) {
      print("FriendFoeData checkCards listFDB.length <= 38");
      createCards();
    } else {
      print("FriendFoeData checkCards listFDB.length > 39");
      _cards = listFDB;
    }
  }

  Future<List<AECard>> _getCardsFromDB() async {
    List<AECard> list = await db.getAllCards();

    List<AECard> result = [];

    for (var i in list) {
      if (i.imgPath.isNotEmpty) {
        var pathList = i.imgPath.split("/");
        if (pathList.length > 3) {
          if (pathList[2] == "friend foe") {
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
            print("FFData addCardsToDB res[j].id == ${res[j].id}, "
                "listFDB[j].id == ${listFDB[j].id}");
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
    _cards.add(cardDE);
    _cards.add(cardDS);
    _cards.add(cardDEn);
    _cards.add(cardDR);
    _cards.add(cardSCC);
    _cards.add(cardSSW);
    _cards.add(cardSR);
    _cards.add(cardSSS);
    _cards.add(cardAA);
    _cards.add(cardABF);
    _cards.add(cardAB);
    _cards.add(cardAPS);
    _cards.add(cardMAS);
    _cards.add(cardMA);
    _cards.add(cardMD);
    _cards.add(cardMS);
    _cards.add(cardFAI);
    _cards.add(cardFBB);
    _cards.add(cardFGI);
    _cards.add(cardFP);
    _cards.add(cardCL);
    _cards.add(cardCE);
    _cards.add(cardCII);
    _cards.add(cardCD);
    _cards.add(cardSwW);
    _cards.add(cardSwSS);
    _cards.add(cardSwDD);
    _cards.add(cardSwBF);
    _cards.add(cardCuBB);
    _cards.add(cardCuM);
    _cards.add(cardCuFF);
    _cards.add(cardCuSS);

    _cards.add(cardAFC);
    _cards.add(cardAFS);
    _cards.add(cardFIC);
    _cards.add(cardCDS);
    _cards.add(cardSwB);
    _cards.add(cardCuRofF);
    _cards.add(cardCuVP);

    addCardsToDB();
  }

  // Friend Foe Stacks
  void checkStacks() async {
    var listFDB = await _getFFStacksFromDB();
    if (listFDB.length <= 7) {
      print("FriendFoeData checkStacks listFDB.length <= 7");
      createStacks();
    } else {
      print("FriendFoeData checkStacks listFDB.length > 7");
      _stacks = listFDB;
      dalanaTheHealer.heroStacks.add(listFDB[0]);
      theScavenger.heroStacks.add(listFDB[1]);
      adelheimTheBlacksmith.heroStacks.add(listFDB[2]);
      myrnaTheScholar.heroStacks.add(listFDB[3]);
      fawnTheAlchemist.heroStacks.add(listFDB[4]);
      theCorrosion.heroStacks.add(listFDB[5]);
      theSwarm.heroStacks.add(listFDB[6]);
      theCultist.heroStacks.add(listFDB[7]);
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
    }
  }

  Future<List<CardsStack>> _getFFStacksFromDB() async {
    var list = await db.getFriendFoeStacks();
    return list;
  }

  void addFFStackToDB() async {
    var listFDB = await _getFFStacksFromDB();
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
    checkCards();
    List<AECard> dalanaList = [_cards[0], _cards[1], _cards[2], _cards[3]];
    CardsStack dalanaTheHealerStack = CardsStack(
        id: 9,
        name: "Dalana, the healer",
        isActive: true,
        stackType: StackType.friendFoe,
        stackColor: Colors.blue,
        cards: dalanaList);
    dalanaTheHealer.heroStacks[0] = dalanaTheHealerStack;
    db.createStack(dalanaTheHealerStack);

    List<AECard> theScavengerList = [
      _cards[4],
      _cards[5],
      _cards[6],
      _cards[7]
    ];
    CardsStack theScavengerStack = CardsStack(
        id: 10,
        name: "The Scavenger",
        isActive: true,
        stackType: StackType.friendFoe,
        stackColor: Colors.red,
        cards: theScavengerList);
    theScavenger.heroStacks[0] = theScavengerStack;
    db.createStack(theScavengerStack);

    List<AECard> adelheimList = [_cards[8], _cards[9], _cards[10], _cards[11]];
    List<AECard> adelheimListTwo = [
      _cards[32],
      _cards[32],
      _cards[32],
      _cards[32],
      _cards[32],
      _cards[32],
      _cards[33],
      _cards[33],
      _cards[33],
      _cards[33]
    ];
    CardsStack adelheimTheBlacksmithStack = CardsStack(
        id: 11,
        name: "Adelheim, the blacksmith",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.blue,
        cards: adelheimList);
    CardsStack adelheimTheBlacksmithSuportStack = CardsStack(
        id: 17,
        name: "Adelheim, the blacksmith. Support stack",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.blue,
        cards: adelheimListTwo);
    adelheimTheBlacksmith.heroStacks[0] = adelheimTheBlacksmithStack;
    adelheimTheBlacksmith.heroStacks[1] = adelheimTheBlacksmithSuportStack;
    db.createStack(adelheimTheBlacksmithStack);
    db.createStack(adelheimTheBlacksmithSuportStack);

    List<AECard> myrnaList = [_cards[12], _cards[13], _cards[14], _cards[15]];
    CardsStack myrnaTheScholarStack = CardsStack(
        id: 12,
        name: "Myrna, the scholar",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.blue,
        cards: myrnaList);
    myrnaTheScholar.heroStacks[0] = myrnaTheScholarStack;
    db.createStack(myrnaTheScholarStack);

    List<AECard> fawnList = [_cards[16], _cards[17], _cards[18], _cards[19]];
    List<AECard> fawnSuportList = [
      _cards[34],
      _cards[34],
      _cards[34],
      _cards[34],
      _cards[34],
      _cards[34]
    ];
    CardsStack fawnTheAlchemistStack = CardsStack(
        id: 13,
        name: "Fawn, the alchemist",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.blue,
        cards: fawnList);
    CardsStack fawnTheAlchemistSupportStack = CardsStack(
        id: 18,
        name: "Fawn, the alchemist. Support stack",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.blue,
        cards: fawnSuportList);
    fawnTheAlchemist.heroStacks[0] = fawnTheAlchemistStack;
    fawnTheAlchemist.heroStacks[1] = fawnTheAlchemistSupportStack;
    db.createStack(fawnTheAlchemistStack);
    db.createStack(fawnTheAlchemistSupportStack);

    List<AECard> corrosionList = [
      _cards[20],
      _cards[21],
      _cards[22],
      _cards[23]
    ];
    List<AECard> corrosionSupportList = [_cards[35], _cards[35], _cards[35]];
    CardsStack theCorrosionStack = CardsStack(
        id: 14,
        name: "The Corrosion",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.red,
        cards: corrosionList);
    CardsStack theCorrosionSupportStack = CardsStack(
        id: 14,
        name: "The Corrosion. Support stack",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.red,
        cards: corrosionSupportList);
    theCorrosion.heroStacks[0] = theCorrosionStack;
    theCorrosion.heroStacks[1] = theCorrosionSupportStack;
    db.createStack(theCorrosionStack);
    db.createStack(theCorrosionSupportStack);

    List<AECard> swarmList = [_cards[24], _cards[25], _cards[26], _cards[27]];
    List<AECard> swarmSupportList = [
      _cards[36],
      _cards[36],
      _cards[36],
      _cards[36]
    ];
    CardsStack theSwarmStack = CardsStack(
        id: 15,
        name: "The Swarm",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.red,
        cards: swarmList);
    CardsStack theSwarmSupportStack = CardsStack(
        id: 15,
        name: "The Swarm. Support stack",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.red,
        cards: swarmSupportList);
    theSwarm.heroStacks[0] = theSwarmStack;
    theSwarm.heroStacks[1] = theSwarmSupportStack;
    db.createStack(theSwarmStack);
    db.createStack(theSwarmSupportStack);

    List<AECard> cultistList = [_cards[28], _cards[29], _cards[30], _cards[31]];
    List<AECard> cultistSupportList = [_cards[37], _cards[38]];
    CardsStack theCultistStack = CardsStack(
        id: 16,
        name: "The Cultist",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.red,
        cards: cultistList);
    CardsStack theCultistSupportStack = CardsStack(
        id: 16,
        name: "The Cultist. Support stack",
        isActive: false,
        stackType: StackType.friendFoe,
        stackColor: Colors.red,
        cards: cultistSupportList);
    theCultist.heroStacks[0] = theCultistStack;
    theCultist.heroStacks[1] = theCultistSupportStack;
    db.createStack(theCultistStack);
    db.createStack(theCultistSupportStack);
  }
}
