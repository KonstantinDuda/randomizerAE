import 'dart:convert';

import 'package:flutter/material.dart';

import 'cards_stack_db.dart';
import 'default_data.dart';

/// AECard represents a card in the game with an id, text, and image path.
class AECard {
  int id = 0;
  String name = "";
  String text = "";

  AECard({
    required this.id,
    required this.name,
    required this.text,
  });

  AECard.fromMap(Map<String, Object?> map) {
    id = map['id'] as int;
    name = map['name'] as String;
    text = map['text'] as String;
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'text': text,
      'name': name,
    };
    if (id != 0) {
      map['id'] = id;
    }

    return map;
  }

  @override
  bool operator ==(Object other) {
    return other is AECard && id == other.id && text == other.text;
  }

  @override
  int get hashCode => Object.hash(id, text);

  @override
  String toString() {
    var result = 'AECard text: $text';
    return result;
  }
}

// Stacks
enum StackType {
  none,
  turnOrder,
  friend,
  foe,
  other,
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
  final String description;
  //final List<int> cardsId;

  CardsStack({
    required this.id,
    required this.name,
    required this.isActive,
    required this.stackType,
    required this.stackColor,
    required this.cards,
    required this.description,
    //required this.cardsId
  });

  const CardsStack.empty({
    this.id = 0,
    this.name = '',
    this.isActive = false,
    this.stackType = StackType.turnOrder,
    this.stackColor = const Color.fromARGB(255, 255, 255, 255), //Colors.white,
    this.cards = const [],
    this.description = "",
    //this.cardsId = const [],
  });

  Map<String, dynamic> toJson() {
    var cardIds = cards.map((e) => e.id).toList();
    var json = <String, Object?>{
      'name': name,
      'is_standart': isActive ? 1 : 0,
      'stack_type': stackType.toString(),
      'stack_color': stackColor.toARGB32(),
      'cards': jsonEncode(cardIds),
      'description': description,
    };
    if (id != 0) {
      json['id'] = id;
    }

    return json;
  }

  factory CardsStack.fromJson(Map<String, dynamic> json) {
    var stackType = _parseStackType(json["stack_type"]);
    var ids = json["cards"];
    final List<int> parsedCardIds =
        ids is String ? List<int>.from(jsonDecode(ids)) : List<int>.from(ids);

    var db = DefaultData();
    var cards = db.getCardsById(parsedCardIds);

    return CardsStack(
        id: json["id"] as int,
        name: json["name"] as String,
        isActive: json['is_standart'] == 1 ? true : false,
        stackType: stackType,
        stackColor: Color(json['stack_color']),
        cards: cards,
        description: json["description"]);
  }

  static StackType _parseStackType(String type) {
    switch (type) {
      case 'StackType.turnOrder':
        return StackType.turnOrder;
      case 'StackType.friend':
        return StackType.friend;
      case 'StackType.foe':
        return StackType.foe;
      case 'StackType.other':
        return StackType.other;
      default:
        return StackType.turnOrder;
    }
  }

  CardsStack csDBToCS(CardsStackDB stackDB, List<AECard> list) {
    return CardsStack(
      id: stackDB.id,
      name: stackDB.name,
      isActive: stackDB.isStandart,
      stackType: stackDB.stackType,
      stackColor: stackDB.stackColor,
      cards: list,
      description: "",
    );
  }

  @override
  String toString() {
    var result =
        'CardsStack{id: $id, name: $name, isActive: $isActive, cards.length: ${cards.length}}'; //,  \n cards: $cards}';
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
  final String description;
  final String feature;

  HeroStack({
    required this.id,
    required this.name,
    required this.isFriend,
    //required this.heroStacks,
    required this.heroStack,
    required this.energyClosetCount,
    required this.ability,
    this.description = "",
    this.feature = "",
  });

  const HeroStack.empty({
    this.id = 0,
    this.name = "",
    this.isFriend = true,
    //this.heroStacks = const [],
    this.heroStack = const CardsStack.empty(),
    this.energyClosetCount = 0,
    this.ability = '',
    this.description = "",
    this.feature = "",
  });
  // TODO: add toJson and fromJson methods

  @override
  String toString() {
    var result =
        'HeroStack id: $id, name: $name, isFriend: $isFriend, heroStack.id: ${heroStack.id}, cards.length: ${heroStack.cards.length}';
    return result;
  }
}
