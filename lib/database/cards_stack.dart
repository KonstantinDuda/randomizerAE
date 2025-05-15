import 'package:flutter/material.dart';
import 'package:randomizer_new/database/cards_stack_db.dart';

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
  String toString() {
    var result = 'AECard text: $text';
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


  @override
  String toString() {
    var result = 'CardsStack{id: $id, name: $name, cards: $cards';
    return result;
  }

}

class HeroStack {
  int id;
  String name;
  //CardsStack heroStack;
  int energyClosetCount;
  String ability;

// Support things  
  int energyPointCount = 0;
  String description = "";
  String feature = "";
  List <CardsStack> heroStacks = [];
  int suportThingsCount = 0;

  HeroStack({
    required this.id,
    required this.name,
    required this.heroStacks,
    required this.energyClosetCount,
    required this.ability,
  });

  HeroStack.empty({
    this.id = 0,
    this.name = "",
    this.heroStacks = const [],
    this.energyClosetCount = 0,
    this.ability = '',
  });
  // TODO: add toJson and fromJson methods

  @override
  String toString() {
    var result = 'CardsStack {heroData.name: ${heroStacks[0].name}}';
    return result;
  }
}
