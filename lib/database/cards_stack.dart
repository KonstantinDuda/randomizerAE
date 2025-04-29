import 'package:flutter/material.dart';

class AECard {
  int id = 0;
  String text = "";
  String imgPath = "";

  AECard({
    required this.id,
    required this.text,
    required this.imgPath,
  });

  /*factory AECard.fromJson(Map<String, dynamic> json) {
    return AECard(
      id: json['id'],
      text: json['text'],
      imgPath: json['img_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'img_path': imgPath,
    };
  }*/

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
  final bool isStandart;
  final StackType stackType;
  final Color stackColor;
  final List<AECard> cards;

  /*int id = 0;
  String name = "";
  bool isStandart = false;
  StackType stackType = StackType.turnOrder;
  Color stackColor = Colors.white;
  List<AECard> cards = [];*/

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

  factory CardsStack.fromJson(Map<String, dynamic> json) {
    var map = <String, dynamic>{
      'id': json['id'],
      'name': json['name'],
      'isStandart': json['isStandart'],
      'stackType': StackType.values[json['stackType']],
      //'stackColor': Color(json['stackColor'].fromARGB32()), // Assuming fromARGB32 is a method to convert int to Color
      'stackColor': Color(json['stackColor'] as int),
      'cards': (json['cards'] as List)
          .map((card) => AECard.fromMap(card))
          .toList(),
    };

    return CardsStack(
      id: map['id'],
      name: map['name'],
      isStandart: map['isStandart'] == 0 ? false : true,
      stackType: map['stackType'],
      stackColor: map['stackColor'],
      cards: List<AECard>.from(map['cards']),
    );
  }

  /*Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isStandart': isStandart ? 1 : 0,
      'stackType': stackType.index,
      'stackColor': stackColor.toARGB32(),
      'cards': cards.map((card) => card.toMap()).toList(),
    };
  }*/

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'name': name,
      'isStandart': isStandart ? 1 : 0,
      'stackType': stackType.index,
      'stackColor': stackColor.toARGB32(),
      'cards': cards.map((card) => card.toMap()).toList(),
    };
    if (id != 0) {
      map['id'] = id;
    }

    return map;
  }

  // TODO: add toJson and fromJson methods

  @override
  String toString() {
    var result = 'CardsStack{id: $id, name: $name, cards: $cards';
    return result;
  }

  //TODO: треба переписувати колір в текст перед записом в БД і навпаки
}

class HeroStack {
  int id;
  CardsStack heroStack;
  int energyClosetCount;
  String ability;
  String feature;

  HeroStack({
    required this.id,
    required this.heroStack,
    required this.energyClosetCount,
    required this.ability,
    required this.feature,
  });

  // TODO: add toJson and fromJson methods

  @override
  String toString() {
    var result = 'CardsStack{heroData.name: ${heroStack.name}, energyClosetCount:';
    return result;
  }
}
