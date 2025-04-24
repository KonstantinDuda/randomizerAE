import 'package:flutter/material.dart';

class AECard {
  int id;
  String text;
  String imgPath;
  String source;

  AECard({
    required this.id,
    required this.text,
    required this.source,
    required this.imgPath,
  });

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
  final bool isStandart;
  final StackType stackType;
  final Color stackColor;
  final List<AECard> cards;

  CardsStack({
    required this.id,
    required this.name,
    required this.isStandart,
    required this.stackType,
    required this.stackColor,
    required this.cards,
  });

  const CardsStack.empty({
    this.id = 0,
    this.name = '',
    this.isStandart = false,
    this.stackType = StackType.turnOrder,
    this.stackColor = Colors.white,
    this.cards = const [],
  });

  // TODO: add toJson and fromJson methods

  @override
  String toString() {
    var result = 'CardsStack{id: $id, name: $name, isStandart: $isStandart,';
    return result;
  }

  //TODO: треба переписувати колір в текст перед записом в БД і навпаки
}

class HeroStack {
  CardsStack heroData;
  int energyClosetCount;
  String ability;
  String feature;

  HeroStack({
    required this.heroData,
    required this.energyClosetCount,
    required this.ability,
    required this.feature,
  });

  // TODO: add toJson and fromJson methods

  @override
  String toString() {
    var result = 'CardsStack{heroData.name: ${heroData.name}, energyClosetCount:';
    return result;
  }
}
