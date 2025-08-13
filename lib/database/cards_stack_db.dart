import 'dart:ui';

import 'cards_stack.dart';

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
    return CardsStackDB(
      id: map['id'] as int,
      name: map['name'] as String,
      isStandart: map['is_standart'] == 1 ? true : false,
      stackType: _parseStackType(map['stack_type']),
      stackColor: Color(map['stack_color']),
      cardsId: (map['cards'] as String?)?.split(',').map((e) => int.parse(e)).toList() ?? [],
    );
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
      case 'StackType.turnOrder': return StackType.turnOrder; // StackType.turnOrder
      //case 'StackType.friendFoe': return StackType.friendFoe;
      case 'StackType.friend': return StackType.friend;
      case 'StackType.foe': return StackType.foe;
      // case 'StackType.gravehold': return StackType.gravehold;
      // case 'StackType.hero': return StackType.hero;
      // case 'StackType.nemesis': return StackType.nemesis;
      default: 
        return StackType.turnOrder;
    }
  }

  List<int> fromAECardToListInt(List<AECard> list) {
    List<int> listInt = [];
    for (var element in list) {
      listInt.add(element.id);
    }

      //print("CardsStackDB fromAECardToListInt listId == $listInt");
    return listInt;
  }

  @override
  String toString() {
    return "CardsStackDB{id: $id, name: $name, isStandart: $isStandart, \n stackType: $stackType, cardsId: $cardsId} \n"; //stackColor: $stackColor, cardsId: $cardsId}";
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