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
  final bool isStandart;
  final StackType stackType;
  final Color stackColor;
  final List<AECard> cards;
  //final List<int> cardsId;

  CardsStack({
    required this.id,
    required this.name,
    required this.isStandart,
    required this.stackType,
    required this.stackColor,
    required this.cards,
    //required this.cardsId
  });

  const CardsStack.empty({
    this.id = 0,
    this.name = '',
    this.isStandart = false,
    this.stackType = StackType.turnOrder,
    this.stackColor = Colors.white,
    this.cards = const [],
    //this.cardsId = const [],
  });

// This worked
  /*factory CardsStack.fromJson(Map<String, dynamic> json) {
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
  Map<String, Object?> toMap() {
    List<int> list = [];
    for (var element in cards) {
      list.add(element.id);
    }
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
  }*/

  /*factory CardsStack.fromJson(Map<String, dynamic> json) {
    var map = <String, dynamic>{
      'id': json['id'],
      'name': json['name'],
      'isStandart': json['is_standart'],
      'stackType': StackType.values[json['stack_type']],
      'stackColor': Color(json['stack_color'] as int),
      'cards': json['cards'] as List<int>,
    };

    return CardsStack(
      id: map['id'],
      name: map['name'],
      isStandart: map['isStandart'] == 0 ? false : true,
      stackType: map['stackType'],
      stackColor: map['stackColor'],
      cardsId: List<int>.from(map['cards']),
      
    );
  }

Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isStandart': isStandart ? 1 : 0,
      'stackType': stackType.index,
      'stackColor': stackColor.toARGB32(),
      'cards': cardsId.map((card) => card.toMap()).toList(),
    };
  }*/
  

  // TODO: add toJson and fromJson methods
  CardsStack csDBToCS(CardsStackDB stackDB, List<AECard> list) {
    return CardsStack(
      id: stackDB.id,
      name: stackDB.name,
      isStandart: stackDB.isStandart,
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
