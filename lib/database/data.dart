enum CardType {
  gem,
  spell,
  relic,
  turnOrderCard,
  curse,
  attack,
  power,
  minion,
}

class AECard {
  int id;
  String cardId;
  String name;
  String text;
  CardType type;
  int cost;
  String imgPath;
  
  AECard({
    required this.id,
    required this.cardId,
    required this.name,
    required this.text,
    required this.type,
    required this.cost,
    required this.imgPath,
  });

  factory AECard.fromMap(Map<String, dynamic> map) {
    return AECard(
      id: map['id'] as int,
      cardId: map['card_id'] as String,
      name: map['name'] as String,
      text: map['text'] as String,
      type: _typeFormDB(map['card_type']),
      cost: map['cost'] as int,
      imgPath: map['img_path'] as String,
    );
  }

  static _typeFormDB(String type) {
    switch (type) {
      case 'gem': return CardType.gem;
      case 'spell': return CardType.spell;
      case 'relic': return CardType.relic;
      case 'turnOrderCard': return CardType.turnOrderCard;
      case 'curse': return CardType.curse;
      case 'attack': return CardType.attack;
      case 'power': return CardType.power;
      case 'minion': return CardType.minion;
    }
    return CardType.turnOrderCard;
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'card_id': cardId,
      'name': name,
      'text': text,
      'card_type': type.toString(),
      'cost': cost,
      'img_path': imgPath,
    };
    if (id != 0) {
      map['id'] = id;
    }

    return map;
  }
} 

class MyData {

// Turn order cards
creatingCards() {
var toOne = AECard(
  id: 1, cardId: "", name: '1', text: '1',
  type: CardType.turnOrderCard, cost: 0,
  imgPath: 'assets/images/toOne.png',
);
var toTwo = AECard(
  id: 2, cardId: "", name: '2', text: '2',
  type: CardType.turnOrderCard, cost: 0,
  imgPath: 'assets/images/toTwo.png',
);
var toThree = AECard(
  id: 3, cardId: "", name: '3', text: '3',
  type: CardType.turnOrderCard, cost: 0,
  imgPath: 'assets/images/toThree.png',
);
var toFour = AECard(
  id: 4, cardId: "", name: '4', text: '4',
  type: CardType.turnOrderCard, cost: 0,
  imgPath: 'assets/images/toFour.png',
);
var toWild = AECard(
  id: 5, cardId: "", name: 'Wild', text: 'Wild',
  type: CardType.turnOrderCard, cost: 0,
  imgPath: 'assets/images/toWild.png',
);
var cardNemesis = AECard(
  id: 6, cardId: "", name: 'Nemesis', text: 'Nemesis',
  type: CardType.turnOrderCard, cost: 0,
  imgPath: 'assets/images/toNemesis.png',
);
var toFoe = AECard(
  id: 7, cardId: "", name: 'Foe', text: 'Foe',
  type: CardType.turnOrderCard, cost: 0,
  imgPath: 'assets/images/toFoe.png',
);
var toFriend = AECard(
  id: 8, cardId: "", name: 'Friend', text: 'Friend',
  type: CardType.turnOrderCard, cost: 0,
  imgPath: 'assets/images/toFriend.png',
);
var toBliz = AECard(
  id: 9, cardId: "", name: 'Bliz', 
  text: 'Setup: Use this card if you want to increse the difficulty '
      ' of the nemesis. Replace a nemesis turn order card in the '
      ' turn order deck with this turn order card. Rules: When this '
      ' turn order card is drawn, resolve the nemesis main phase '
      ' once. Then resolve the nemesis turn as usual. This card '
      ' counts as a nemesis turn order card',
  type: CardType.turnOrderCard, cost: 0,
  imgPath: 'assets/images/toBliz.png',
);

// Friends cards
var friendMyrnaStudy = AECard(
  id: 10, cardId: "ATD-2a-09", name: 'Study', 
  text: 'Myrna, the Scholar gains 1 charge. You may have the foe gain 1 charge. '
        'If you do, Myrna gains an additional 2 charges. OR Myrna, the Scholar '
        'loses 2 knowledge. If she does, any player casts a prepped spell ' 
        'without discarding it',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/myrna study.png',
);
var friendMyrnaAncyent = AECard(
  id: 11, cardId: "ATD-2a-10", name: 'Ancient Secrets', 
  text: 'Myrna, theScholar gains 2 charges. OR Myrna, the Scholar loses 1 Knowledge. '
        'If she does, reveal the turn order deck and return it in any order',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/ancient secret.png',
);
var friendMyrnaArchive = AECard(
  id: 12, cardId: "ATD-2a-11", name: 'Archive', 
  text: 'Any player draws three cards and discards any cards drawn this way that '
        'cost 3 money or more. OR Myrna loses any amount of Knowledge. The players '
        'collectively draw cards equal to the Knowledge lost this way',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/myrna archive.png',
);
var friendMyrnaDelve = AECard(
  id: 13, cardId: "ATD-2a-12", name: 'Delve', 
  text: 'Myrna, the Scholar gains 2 charges. OR Myrna, the Scholar loses 1 Knowledge. '
        'if she does, any player gains 4 money tokens',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/myrna delve.png',
);
var friendDalanaEnergize = AECard(
  id: 14, cardId: "ATD-1c-60", name: 'Energize', 
  text: 'Dalana, the Healer gains 2 charges. OR Any player gains 1 charge',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/dalana energize.png',
);
var friendDalanaSoothingAura = AECard(
  id: 15, cardId: "ATD-1c-61", name: 'Soothing Aura', 
  text: 'Any player draws a card. OR Any player gains 2 money tokens',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/dalana soothing aura.png',
);
var friendDalanaEnhance = AECard(
  id: 16, cardId: "ATD-1c-62", name: 'Enhance', 
  text: 'Any player focuses a breach. OR Any player discards a prepped spell. '
        'If they do. Dalana, the Healer gains 3 charges',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/dalana enhance.png',
);
var friendDalanaRestore = AECard(
  id: 17, cardId: "ATD-1c-63", name: 'Restore', 
  text: 'Dalana, the Healer gains 2 charges. OR Any player returns a card '
        'from their discard pile to their hand',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/dalana restore.png',
);
var friendFawnAInfusion = AECard(
  id: 18, cardId: "ATD-3a-17", name: 'Arcane Infusion', 
  text: 'Any player may gain an Incendiary Catalyst and place it on top of their deck. '
        'OR Any player casts a prepped spell. That spell deals an additional 1 damage',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/fawn arcane infusion.png',
);
var friendFawnBBrew = AECard(
  id: 19, cardId: "ATD-3a-18", name: 'Bubbling Brew', 
  text: 'Fawn, the Alchemist gains 2 charges. OR Any player places a spell that costs '
        '2 money or more from their hand into the Cauldron and draws a card',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/fawn bubbling brew.png',
);
var friendFawnGIngredients = AECard(
  id: 20, cardId: "ATD-3a-19", name: 'Gather Ingredients', 
  text: 'Any player gains a spell that costs 5 money or less from the supply. OR '
        'Any player gains 1 charge',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/fawn gather ingredients.png',
);
var friendFawnPrepare = AECard(
  id: 21, cardId: "ATD-3a-20", name: 'Prepare', 
  text: 'Fawn, the Alchemist gains 2 charges. OR Any player gains an Incendiary' 
        'Catalyst and an money token',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/fawn prepare.png',
);
var friendFawnICatalyst = AECard(
  id: 22, cardId: "ATD-3a-21", name: 'Incendiary Catalyst', 
  text: 'Cast: Deal 3 damage. You may place a spell that costs 2 money or more from' 
        'your hand or discard pile into the Cauldron',
  type: CardType.spell, cost: 4,
  imgPath: 'assets/images/fawn incendiary catalyst.png',
);
var friendAdelheimAmplify = AECard(
  id: 23, cardId: "ATD-4-08", name: 'Amplify', 
  text: 'Adelheim, the Blacksmith gains 2 charges. OR Any player destroys a Spark '
        'in hand or discard pile and gains a Forged Spark',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/adelheim amplify.png',
);
var friendAdelheimBFurnace = AECard(
  id: 24, cardId: "ATD-4-09", name: 'Blazing Furnace', 
  text: 'Any player destroys a Crystal in hand or discard pile and gains a Forged '
        'Crystal. OR Any player returns up to two cards from their discard pile '
        'that cost 0 money to their hand',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/adelheim blazing funrance.png',
);
var friendAdelheimBurnish = AECard(
  id: 25, cardId: "ATD-4-10", name: 'Burnish', 
  text: 'Any player destroys a Crystal or Spark in hand. That player gains the '
        'corresponding Forged card and places it into their hand. OR Any player ' 
        'loses 2 charges. If they do, Adelheim, the Blacksmith gains 4 charges',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/adelheim burnish.png',
);
var friendAdelheimPSteel = AECard(
  id: 26, cardId: "ATD-4-11", name: 'Polished steel', 
  text: 'Adelheim, the Blacksmith gains 2 charges. OR Any player discards a '
        'card in hand that cost 2 money or more. If they do, they gains 3 charges',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/adelheim polished steel.png',
);
var friendAdelheimFCrystal = AECard(
  id: 27, cardId: "ATD-4-12", name: 'Forged Crystal', 
  text: 'Gain 2 money',
  type: CardType.gem, cost: 0,
  imgPath: 'assets/images/adelheim forged crystal.png',
);
var friendAdelheimFSpark = AECard(
  id: 28, cardId: "ATD-4-18", name: 'Forged Spark', 
  text: 'Cast: Deal 2 damage',
  type: CardType.spell, cost: 0,
  imgPath: 'assets/images/adelheim forged spark.png',
);
var foeScavengerCClaw = AECard(
  id: 29, cardId: "ATD-2a-13", name: 'Carrion Claw', 
  text: 'The Scavenger gains 2 charges. OR Any player loses 2 charges',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/scavenger carrion claw.png',
);
var foeScavengerSWail = AECard(
  id: 30, cardId: "ATD-2a-14", name: 'Screeching Wail', 
  text: 'The Scavenger gains 1 charge. Any player may discard a prepped spell '
        'that costs 3 money or more. If they dont, the Scavenger gains an ' 
        'additional 2 charges',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/scavenger screeching wail.png',
);
var foeScavengerReclaim = AECard(
  id: 31, cardId: "ATD-2a-15", name: 'Reclaim', 
  text: 'Any player discards their two most expensive cards in hand and then '
        'draws a card. OR Gravehold suffers 3 damage',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/scavenger reclaim.png',
);
var foeScavengerSSlash = AECard(
  id: 32, cardId: "ATD-2a-16", name: 'Shadow Slash', 
  text: 'Gravehold suffers 3 damage. OR The Scavenger gains 3 charges and the '
        'friend gains 1 charge',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/scavenger shadow slash.png',
);
var foeCorrosionLeech = AECard(
  id: 33, cardId: "ATD-3a-27", name: 'Leech', 
  text: 'The Corrosion gains 2 charges. OR Any player discards a gem in hand that '
        'costs 3 money or more',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/corrosion leech.png',
);
var foeCorrosionEmpower = AECard(
  id: 34, cardId: "ATD-3a-28", name: 'Empower', 
  text: 'Remove 1 power token from each power in play, and the nemesis gains 6 life ' 
        'OR Place a Draining Sign into lpay',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/corrosion empower.png',
);
var foeCorrosionIInevitability = AECard(
  id: 35, cardId: "ATD-3a-29", name: 'Imbue Inevitability', 
  text: 'The Corrosion gains 2 charges. OR Place the bottommost power card from '
        'the nemesis discard pile into play. Any player gains 2 charges',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/corrosion imbue inevitability.png',
);
var foeCorrosionDiminish = AECard(
  id: 36, cardId: "ATD-3a-30", name: 'Diminish', 
  text: 'Place a Draining Sign into play',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/corrosion diminish.png',
);
var foeCorrosionDSign = AECard(
  id: 37, cardId: "ATD-3a-31", name: 'Draining Sign', 
  text: 'TO DISCARD: Spend 5 money. Return this card to the Draining Sign Pile '
        'POWER 3: Any player suffers 4 damage. Return this to the Draining Sign pile',
  type: CardType.power, cost: 0,
  imgPath: 'assets/images/corrosion draining sign.png',
);
var foeSwarmWriggle = AECard(
  id: 38, cardId: "ATD-1c-51", name: 'Wriggle', 
  text: 'The Swarm gains 2 charges. OR Gravehold suffers 3 damage',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/swarm wriggle.png',
);
var foeSwarmSScreech = AECard(
  id: 39, cardId: "ATD-1c-52", name: 'Summoning Screech', 
  text: 'Place a Broodling into play with 4 life. OR Any player discards a relic '
        'in hand that costs 2 money or more',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/swarm summoning screech.png',
);
var foeSwarmDDevour = AECard(
  id: 40, cardId: "ATD-1c-53", name: 'Descend and Devour', 
  text: 'Place a Broodling into play. The swarm gains 1 charge',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/swarm descend and devour.png',
);
var foeSwarmBFlesh = AECard(
  id: 41, cardId: "ATD-1c-54", name: 'Blistered Flesh', 
  text: 'Place a Broodling into play and gravehold suffers 2 damage. OR The Swarm ' 
        'gains 3 charges and the friend gains 1 charge',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/swarm blistered flesh.png',
);
var foeSwarmBroodling = AECard(
  id: 42, cardId: "ATD-1c-55", name: 'Broodling', 
  text: 'When this is discarded, return it to the Broodling deck. PERSISTENT: '
        'Any player suffers 1 damage and discards a card HEALTH: 3',
  type: CardType.minion, cost: 0,
  imgPath: 'assets/images/swarm broodling.png',
);
var foeCultistBBright = AECard(
  id: 43, cardId: "ATD-4-22", name: 'Burn Bright', 
  text: 'The Cultist gains 2 charges. OR Volatile Pylon gains 4 life',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/cultist burn bright.png',
);
var foeCultistMelt = AECard(
  id: 44, cardId: "ATD-4-23", name: 'Melt', 
  text: 'If Volatile Pylon has 5 or more life, any player discards two cards in '
        'hand. Otherwise, Volatile Pylon gains 4 life',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/cultist melt.png',
);
var foeCultistFFlames = AECard(
  id: 45, cardId: "ATD-4-24", name: 'Feed the Flames', 
  text: 'The Cultist gains 1 charge. Any player may discard a gem in hand that '
        'costs a 3 money or more. If they dont Volatile Pylon gains 3 life',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/cultist feed the flames.png',
);
var foeCultistSSmog = AECard(
  id: 46, cardId: "ATD-4-25", name: 'Smothering Smog', 
  text: 'Volatile Pylon gains 2 life and any player loses 1 charge. OR The Cultist ' 
        'gains 3 charges and the gains 1 charge',
  type: CardType.attack, cost: 0,
  imgPath: 'assets/images/cultist smothering smog.png',
);
var foeCultistRFlame = AECard(
  id: 47, cardId: "ATD-4-26", name: 'Ritual of flame', 
  text: 'POWER 5: Any player or Gravehold suffers damage equal to thelife of ' 
        'Volatile Pylon minus 1. Place 5 power tokens on this instead of discarding it',
  type: CardType.power, cost: 0,
  imgPath: 'assets/images/cultist ritual of flame.png',
);
var foeCultistVPylon = AECard(
  id: 48, cardId: "ATD-4-27", name: 'Volatile Pylon', 
  text: 'This enters play with 4 life. This minion has no maximum life. '
        'This minions life cannot be reduced below 1',
  type: CardType.minion, cost: 0,
  imgPath: 'assets/images/cultist volatile pylon.png',
);
/*var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);
var  = AECard(
  id: , cardId: "", name: '', 
  text: '',
  type: CardType, cost: 0,
  imgPath: 'assets/images/.png',
);*/
}
}