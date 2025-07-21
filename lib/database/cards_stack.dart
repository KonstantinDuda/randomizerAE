import 'package:flutter/material.dart';

import 'cards_stack_db.dart';

// enum CardType {
//   turnOrder,
//   friend,
//   foe,
//   nemesis,
//   gravehold,
//   suply,
//   hero,
//   other,
// }

/// AECard represents a card in the game with an id, text, and image path.
class AECard {
  int id = 0;
  String text = "";
  String imgPath = "";

  AECard({
    required this.id,
    required this.text,
    required this.imgPath,
  });

  AECard.fromMap(Map<String, Object?> map) {
    id = map['id'] as int;
    text = map['text'] as String;
    imgPath = map['img_path'] as String;
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'text': text,
      'img_path': imgPath,
    };
    if (id != 0) {
      map['id'] = id;
    }

    return map;
  }

  @override
  bool operator ==(Object other) {
    // if(other is AECard) {
    //   print(id == other.id ? "true: AECard operator ==. id == other.id  ?" : "false: AECard operator ==. id == other.id ?");
    //   print(text == other.text ? "true: AECard operator ==. text == other.text  ?" : "false: AECard operator ==. text == other.text ?");
    //   print(imgPath == other.imgPath ? "true: AECard operator ==. imgPath == other.imgPath ?" : "false: AECard operator ==. imgPath == other.imgPath ?");
    // }
    return other is AECard &&
        id == other.id &&
        text == other.text &&
        imgPath == other.imgPath;
  }

  @override
  int get hashCode => Object.hash(id, text, imgPath);

  @override
  String toString() {
    var result = 'AECard text: $text';//, imgPath: $imgPath';
    return result;
  }
  // TODO: add toJson and fromJson methods
}

// Stacks
enum StackType {
  turnOrder,
  friend,
  foe,
  //friendFoe,
  //gravehold,
  //hero,
  //nemesis,
}

class CardsStack {
  final int id;
  final String name;
  final bool isActive;
  final StackType stackType;
  final Color stackColor;
  final List<AECard> cards;
  //final List<int> cardsId;

  CardsStack({
    required this.id,
    required this.name,
    required this.isActive,
    required this.stackType,
    required this.stackColor,
    required this.cards,
    //required this.cardsId
  });

  const CardsStack.empty({
    this.id = 0,
    this.name = '',
    this.isActive = false,
    this.stackType = StackType.turnOrder,
    this.stackColor = Colors.white,
    this.cards = const [],
    //this.cardsId = const [],
  });

  CardsStack csDBToCS(CardsStackDB stackDB, List<AECard> list) {
    return CardsStack(
      id: stackDB.id,
      name: stackDB.name,
      isActive: stackDB.isStandart,
      stackType: stackDB.stackType,
      stackColor: stackDB.stackColor,
      cards: list,
    );
  }

  @override
  String toString() {
    var result = 'CardsStack{id: $id, name: $name, isActive: $isActive, stackType: $stackType}';//,  \n cards: $cards}';
    return result;
  }
}

class HeroStack {
  final int id;
  final String name;
  final bool isFriend;
  // final List<CardsStack> heroStacks;
  final CardsStack heroStack;
  final int energyClosetCount;
  final String ability;

// Support things
  final int energyPointCount;
  final String description;
  final String feature;

  final int suportThingsCount;

  HeroStack({
    required this.id,
    required this.name,
    required this.isFriend,
    //required this.heroStacks,
    required this.heroStack,
    required this.energyClosetCount,
    required this.ability,
    this.energyPointCount = 0,
    this.description = "",
    this.feature = "",
    this.suportThingsCount = 0,
  });

  const HeroStack.empty({
    this.id = 0,
    this.name = "",
    this.isFriend = true,
    //this.heroStacks = const [],
    this.heroStack = const CardsStack.empty(),
    this.energyClosetCount = 0,
    this.ability = '',
    this.energyPointCount = 0,
    this.description = "",
    this.feature = "",
    this.suportThingsCount = 0,
  });
  // TODO: add toJson and fromJson methods

  @override
  String toString() {
    var result = 'HeroStack id: $id, name: $name, isFriend: $isFriend, heroStack.id: ${heroStack.id}';
    return result;
  }
}
