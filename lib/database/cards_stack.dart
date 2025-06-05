import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack_db.dart';

enum CardType {
  turnOrder,
  friend,
  foe,
  nemesis,
  gravehold,
  suply,
  hero,
  other,
}

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
  friendFoe,
  gravehold,
  hero,
  nemesis,
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

  /*@override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    //if(other is! CardsStackDB) return false;
    if (other is CardsStack) {
      print(id == other.id ? "true : CardsStack operator ==. id == other.id ?" : "false : CardsStack operator ==. id == other.id ?" );
      print(name == other.name ? "true : CardsStack operator ==. name == other.name &&" : "false : CardsStack operator ==. name == other.name && ?");
      print(isActive == other.isActive ? "true : CardsStack operator ==. isActive == other.isActive &&" : "false : CardsStack operator ==. isActive == other.isActive && ?");
      print(stackType == other.stackType ? "true : CardsStack operator ==. stackType == other.stackType &&" : "false : CardsStack operator ==. stackType == other.stackType && ?");
      print(stackColor == other.stackColor ? "true : CardsStack operator ==. stackColor == other.stackColor &&" : "false : CardsStack operator ==. stackColor == other.stackColor && ?");
      var cardsIsEqual = true;
      for (var i = 0; i < cards.length; i++) {
        if(cards[i] != other.cards[i]) {
          cardsIsEqual = false;
        }
      }
      print(cardsIsEqual ? "true : CardsStack operator ==. cards == other.cards ?" : "false : CardsStack operator ==. cards == other.cards ?");
      if (id == other.id &&
          name == other.name &&
          isActive == other.isActive &&
          stackType == other.stackType &&
          stackColor == other.stackColor &&
          cardsIsEqual) {
        print("CardsStack operator == true");
        return true;
      } else {
        print("CardsStack operator == false");
        return false;
      }
    }

    return false;
  }

  @override
  int get hashCode =>
      Object.hash(id, name, isActive, stackType, stackColor, cards);*/

  @override
  String toString() {
    var result = 'CardsStack{id: $id, name: $name, cards: $cards';
    return result;
  }
}

class HeroStack {
  int id;
  String name;
  bool isFriend;
  List<CardsStack> heroStacks = [];
  int energyClosetCount;
  String ability;

// Support things
  int energyPointCount = 0;
  String description = "";
  String feature = "";

  int suportThingsCount = 0;

  HeroStack({
    required this.id,
    required this.name,
    required this.isFriend,
    required this.heroStacks,
    required this.energyClosetCount,
    required this.ability,
  });

  HeroStack.empty({
    this.id = 0,
    this.name = "",
    this.isFriend = true,
    this.heroStacks = const [],
    this.energyClosetCount = 0,
    this.ability = '',
  });
  // TODO: add toJson and fromJson methods

  @override
  String toString() {
    var result = 'HeroStack name: $name, id: $id \n';
    return result;
  }
}
