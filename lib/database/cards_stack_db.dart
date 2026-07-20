import 'dart:ui';

import 'cards_stack.dart';

/// class CardsStackDB {
///   final int id;
///   final String name;
///   final bool isStandart;
///   final StackType stackType;
///   final Color stackColor;
///   final List<int> cardsId;
///
/// It is used to store the data of the CardsStack class in the database. It is used to convert the data from the database to the CardsStack class and vice versa.
/// It is stored in the database as a List of id-value.

class CardsStackDB {
  final int id;
  final String name;
  final bool isStandart;
  final StackType stackType;
  final Color stackColor;
  final List<int> cardsId;

  CardsStackDB({
    required this.id,
    required this.name,
    required this.isStandart,
    required this.stackType,
    required this.stackColor,
    required this.cardsId,
  });

  factory CardsStackDB.fromMap(Map<String, dynamic> map) {
    var id = map['id'] as int;
    var name = map['name'] as String;
    var isStandart = map['is_standart'] == 1 ? true : false;
    var stackType = _parseStackType(map['stack_type']);
    var stackColor = Color(map['stack_color']);
    var cardsIdString = (map['cards'] as String);
    List<int> cardsIDs = [];
    if (cardsIdString.isNotEmpty) {
      cardsIDs = cardsIdString.split(',').map((e) => int.parse(e)).toList();
    }
    var result = CardsStackDB(
      id: id,
      name: name,
      isStandart: isStandart,
      stackType: stackType,
      stackColor: stackColor,
      cardsId: cardsIDs,
    );

    return result;
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'name': name,
      'is_standart': isStandart ? 1 : 0,
      'stack_type': stackType.toString(),
      'stack_color': stackColor.toARGB32(),
      'cards': cardsId.join(','),
    };
    if (id != 0) {
      map['id'] = id;
    }

    return map;
  }

  static StackType _parseStackType(String type) {
    switch (type) {
      case 'StackType.turnOrder':
        return StackType.turnOrder;
      case 'StackType.friend':
        return StackType.friend;
      case 'StackType.foe':
        return StackType.foe;
      default:
        return StackType.turnOrder;
    }
  }

  List<int> fromAECardToListInt(List<AECard> list) {
    List<int> listInt = [];
    for (var element in list) {
      listInt.add(element.id);
    }
    return listInt;
  }

  @override
  String toString() {
    return "CardsStackDB{id: $id, name: $name, cardsId: $cardsId} \n";
  }
}

class HeroStackDB {
  final int id;
  final String name;
  final bool isFriend;
  final int energyClosetCount;
  final String ability;
  final String feature;
  final String description;
  //final List<int> stacksId;
  final int stackId;

  HeroStackDB({
    required this.id,
    required this.name,
    required this.isFriend,
    required this.energyClosetCount,
    required this.ability,
    required this.feature,
    required this.description,
    //required this.stacksId,
    required this.stackId,
  });

  factory HeroStackDB.fromMap(Map<String, dynamic> map) {
    return HeroStackDB(
      id: map['id'] as int,
      name: map['name'] as String,
      isFriend: map['is_friend'] == 1 ? true : false,
      energyClosetCount: map['ec_count'] as int,
      ability: map['ability'] as String,
      feature: map['feature'] as String,
      description: map['description'] as String,
      //stacksId: (map['stacks'] as String?)?.split(',').map((e) => int.parse(e)).toList() ?? [],
      stackId: map['stack_id'] as int,
    );
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'name': name,
      'is_friend': isFriend ? 1 : 0,
      'ec_count': energyClosetCount,
      'ability': ability,
      'feature': feature,
      'description': description,
      //'stacks': stacksId.join(','),
      'stack_id': stackId,
    };
    if (id != 0) {
      map['id'] = id;
    }

    return map;
  }

  List<int> fromCardsStackToListInt(List<CardsStack> list) {
    List<int> listInt = [];
    for (var element in list) {
      listInt.add(element.id);
    }

    //print("HeroStackDB fromCardsStackToListInt listId == $listInt");
    return listInt;
  }

  @override
  String toString() {
    return "HeroStackDB{id: $id, name: $name, stackId: $stackId} \n";
  }
}
