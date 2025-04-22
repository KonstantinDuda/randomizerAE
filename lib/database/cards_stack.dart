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

  factory AECard.fromJson(Map<String, dynamic> json) {
    return AECard(
      id: json['id'],
      text: json['text'],
      source: json['source'],
      imgPath: json['imgPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'source': source,
      'imgPath': imgPath,
    };
  }
}

class CardsStack {
  int id;
  String name;
  bool isStandart;
  Color stackColor;
  List<AECard> cards;

  CardsStack({
    required this.id,
    required this.name,
    required this.isStandart,
    required this.stackColor,
    required this.cards,
  });

  factory CardsStack.fromJson(Map<String, dynamic> json) {
    var cardsFromJson = json['cards'] as List;
    List<AECard> cardsList =
        cardsFromJson.map((i) => AECard.fromJson(i)).toList();

    return CardsStack(
      id: json['id'],
      name: json['name'],
      isStandart: json['isStandart'],
      stackColor: json['stackColor'],
      cards: cardsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isStandart': isStandart,
      'stackColor': stackColor,
      'cards': cards.map((card) => card.toJson()).toList(),
    };
  }

  @override
  String toString() {
    var result = 'CardsStack{id: $id, name: $name, isStandart: $isStandart,'
                  ' stackColor: $stackColor cards: $cards';
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

  factory HeroStack.fromJson(Map<String, dynamic> json) {
    return HeroStack(
      heroData: CardsStack.fromJson(json['heroData']),
      energyClosetCount: json['energyClosetCount'],
      ability: json['ability'],
      feature: json['feature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heroData': heroData.toJson(),
      'energyClosetCount': energyClosetCount,
      'ability': ability,
      'feature': feature,
    };
  }

  @override
  String toString() {
    var result = 'CardsStack{heroData: ${heroData.toString()}, energyClosetCount:'
                    ' $energyClosetCount, ability: $ability, feature: $feature';
    return result;
  }
}
