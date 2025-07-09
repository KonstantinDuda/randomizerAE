import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'cards_stack.dart';
import 'cards_stack_db.dart';

class DBProvider {
  late Database _aeonsEndDatabase;

  static const String cardsTableName = "Cards_Table";
  static const String stackTableName = "Stack_Table";
  static const String heroTableName = "Hero_Table";

  DBProvider() {
    initDatabase();
  }

  Future<Database> get getDatabase async {
    WidgetsFlutterBinding.ensureInitialized();
    //if (_aeonsEndDatabase != null) return _aeonsEndDatabase;

    _aeonsEndDatabase = await initDatabase();
    return _aeonsEndDatabase;
  }

  initDatabase() async {
    Directory dbPath = await getApplicationDocumentsDirectory();
    String path = join(dbPath.path, "AeonsEndDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE IF NOT EXISTS $cardsTableName ("
            "id INTEGER PRIMARY KEY, "
            "text TEXT, "
            "img_path TEXT)");
        await db.execute("CREATE TABLE IF NOT EXISTS $stackTableName ("
            "id INTEGER PRIMARY KEY, "
            "name TEXT, "
            "is_standart INTEGER, "
            "stack_type TEXT, "
            "stack_color INTEGER, "
            "cards TEXT)");
        await db.execute("CREATE TABLE IF NOT EXISTS $heroTableName ("
            "id INTEGER PRIMARY KEY, "
            "name TEXT, "
            "is_friend INTEGER, "
            "ec_count INTEGER, "
            "ability TEXT, "
            "feature TEXT, "
            "stacks TEXT)");
      },
    );
  }

// Create, Read, Update, Delete (CRUD) operations for AECard
  void createCard(AECard card) async {
    final db = await getDatabase;

    //if (card.id > 0) {
      var x = await getCardById(card.id);
      if (x.id == 0) {
        await db.insert(
          cardsTableName, card.toMap(),
          //conflictAlgorithm: ConflictAlgorithm.abort);
        );
        //print("DBProvider createCard() db.insert $card \n");
      } else {
        print("DBProvider createCard() card ${card.id} was in the Database \n");
      }
    // } else {
    //   await db.insert(
    //     cardsTableName,
    //     card.toMap(),
    //   );
    //   var x = await getCardById(card.id);
    //   print("DBProvider createCard() card.id < 1 card: $x was created");
    // }

    // For debugging purposes
    /*List<Map<String, Object?>> maps = await db.query(cardsTableName);
    print("DBProvider createCard() maps == ${maps.length} \n");
    if(maps.isNotEmpty) {
      for (var element in maps) {
        AECard cardFromDB = AECard.fromMap(element);
        print("DBProvider createCard() cardFromDB == ${cardFromDB.toString()} \n");
      }
    } else {
      print("DBProvider createCard() maps.isEmpty");
    }*/
  }

  Future<AECard> getCardById(int id) async {
    final db = await getDatabase;
    List<Map<String, Object?>> maps =
        await db.query(cardsTableName, where: "id = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      //print("DBProvider getCardById($id) the ${maps.first.toString()} was in the Database \n");
      return AECard.fromMap(maps.first);
    } else {
      //print("DBProvider getCardById($id) card does not Exist \n");
      return AECard(id: 0, text: '', imgPath: '');
    }
  }

  void updateCard(AECard card) async {
    final db = await getDatabase;

    var cardBefore = await getCardById(card.id);
    print("DBProvider updste card, card before: $cardBefore");

    await db.update(cardsTableName, card.toMap(),
        where: "id = ?", whereArgs: [card.id]);

    var cardAfter = await getCardById(card.id);
    print("DBProvider updste card, card before: $cardAfter");
  }

  void deleteCard(int id) async {
    final db = await getDatabase;
    await db.delete(cardsTableName, where: "id = ?", whereArgs: [id]);
  }

  Future<List<AECard>> getAllCards() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(cardsTableName);
    var result = List.generate(maps.length, (i) => AECard.fromMap(maps[i]));
    //print("DBProvider getAllCards result == $result");
    // return List.generate(maps.length, (i) {
    //   return AECard.fromMap(maps[i]);
    // });
    return result;
  }

  // Future<List<AECard>> getTurnOrderCards() async {
  //   //final db = await getDatabase;
  //   List<CardsStack> turnOrderStacks = await getTurnOrderStacks();
  //   List<AECard> result = [];
  //   for (var i in turnOrderStacks) {
  //     for (var j in i.cards) {
  //       result.add(j);
  //     }
  //   }
  //   print("DBProvider getTurnOrderCards result == $result");

  //   return result;
  // }

  // Future<List<AECard>> getFriendFoeCards() async {
  //   // final db = await getDatabase;
  //   // List<Map<String, dynamic>> maps = await db.query(cardsTableName,
  //   //   where: "stack_type = ?",
  //   //   whereArgs: ["friendFoe"],
  //   // );
  //   // // TODO add other limitation
  //   // var result = List.generate(maps.length, (i) => AECard.fromMap(maps[i]));
  //   // print("DBProvider getTurnOrderCards result == $result");

  //   var allCards = await getAllCards();
  //   List<AECard> result = [];

  //   for (var i in allCards) {
  //     if (i.imgPath.isNotEmpty) {
  //       var pathList = i.imgPath.split("/");
  //       if (pathList.length > 3) {
  //         if (pathList[2] == "friend" || pathList[2] == "foe") {
  //           result.add(i);
  //         }
  //       }
  //     }
  //   }

  //   return result;
  // }

// Create, Read, Update, Delete (CRUD) operations for CardsStack
  void createStack(CardsStack stack) async {
    final db = await getDatabase;
    //await db.insert(stackTableName, stack.toMap());

    CardsStackDB stackToDB = CardsStackDB(
        id: stack.id,
        name: stack.name,
        isStandart: stack.isActive,
        stackType: stack.stackType,
        stackColor: stack.stackColor,
        cardsId: []);
    var ids = stackToDB.fromAECardToListInt(stack.cards);
    stackToDB.cardsId.addAll(ids);
    //fromCardsStackToCardsStackDB(stack);
    //print("DBProvider createStack() stackToDB == $stackToDB \n");

    // For debugging purposes
    // Change to using getStackById
    List<CardsStackDB> dbList = [];
    List<Map<String, dynamic>> maps = await db.query(stackTableName);
    //print("DBProvider createStack() maps.length == ${maps.length} \n");
    if (maps.isNotEmpty) {
      for (var element in maps) {
        CardsStackDB stackFromDB = CardsStackDB.fromMap(element);
        if (stackFromDB.id == stack.id) {
          dbList.add(stackFromDB);
        }
        //print(
        //    "DBProvider createStack() stackFromDB == ${stackFromDB.toString()} \n");
      }
      if (dbList.isEmpty) {
        //print("DBProvider createStack db.insert $stackToDB");
        await db.insert(stackTableName, stackToDB.toMap());
      }
    } else {
      //print("DBProvider createStack() maps.isEmpty \n");
      await db.insert(stackTableName, stackToDB.toMap());
    }
  }

  Future<CardsStack> getStackById(int id) async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps =
        await db.query(stackTableName, where: "id = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      var csDB = CardsStackDB.fromMap(maps.first);
      List<AECard> list = [];

      for (var element in csDB.cardsId) {
        AECard card = await getCardById(element);
        if (card.id > 0) {
          list.add(card);
        }
      }

      CardsStack res = const CardsStack.empty();
      var newRes = res.csDBToCS(csDB, list);

      //print("DBProvider getStackById($id) res to return == $newRes");

      return newRes; // CardsStack.fromJson(maps.first);
    } else {
      return const CardsStack.empty();
    }
  }

  Future<List<CardsStack>> getAllStacks() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(stackTableName);

    List<CardsStack> stacks = [];
    stacks = await _pullCardsToStack(maps);
    //print("DBProvider getAllStacks() stacks == $stacks");

    return stacks;
  }

  Future<List<CardsStack>> getAvailableStacks() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db
        .query(stackTableName, where: "is_standart = ?", whereArgs: [1]);

    List<CardsStack> availableList = [];
    availableList = await _pullCardsToStack(maps);

    return availableList;
  }

  Future<List<CardsStack>> getTurnOrderStacks() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(stackTableName,
        where: "stack_type = ?", whereArgs: ["StackType.turnOrder"]);

    print("DBProvider getTurnOrderStacks() maps == $maps");
    List<CardsStack> availableList = await _pullCardsToStack(maps);
    print("DBProvider getTurnOrderStacks() availableList == $availableList");

    return availableList;
  }

  Future<List<CardsStack>> getFriendFoeStacks() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(stackTableName,
        where: "stack_type = ?", whereArgs: ["StackType.friendFoe"]);

    List<CardsStack> availableList = await _pullCardsToStack(maps);

    return availableList;
  }

  Future<List<CardsStack>> _pullCardsToStack(
      List<Map<String, dynamic>> maps) async {
    List<CardsStackDB> csDB = [];
    List<CardsStack> availableList = [];
    if (maps.isNotEmpty) {
      for (var element in maps) {
        csDB.add(CardsStackDB.fromMap(element));
      }

      if (csDB.isNotEmpty) {
        for (var i = 0; i < csDB.length; i++) {
          List<AECard> list = [];
          for (var id in csDB[i].cardsId) {
            AECard card = await getCardById(id);
            if (card.id > 0) {
              list.add(card);
            }
          }

          var cs = const CardsStack.empty();
          availableList.add(cs.csDBToCS(csDB[i], list));
        }
      }
    }

    return availableList;
  }

  Future<void> updateStack(CardsStack stack) async {
    final db = await getDatabase;
    CardsStackDB stackDB = CardsStackDB(
        id: stack.id,
        name: stack.name,
        isStandart: stack.isActive,
        stackType: stack.stackType,
        stackColor: stack.stackColor,
        cardsId: stack.cards.map((card) => card.id).toList());

    var stackBefore = await getStackById(stack.id);
    print(
        "DBProvider update stack, stack before: $stackBefore  stackBefore.color == ${stackBefore.stackColor} \n"); // stackDB == $stackDB

    await db.update(stackTableName, stackDB.toMap(),
        where: "id = ?", whereArgs: [stack.id]);

    var stackAfter = await getStackById(stack.id);
    print(
        "DBProvider update stack, stack after: $stackAfter stackAfter.color == ${stackAfter.stackColor} \n");
  }

  Future<void> deleteStack(int id) async {
    final db = await getDatabase;
    await db.delete(stackTableName, where: "id = ?", whereArgs: [id]);
  }

  // CRUD for Hero
  void createHero(HeroStack hero) async {
    final db = await getDatabase;
    //await db.insert(stackTableName, stack.toMap());

    HeroStackDB heroToDB = HeroStackDB(
      id: hero.id,
      name: hero.name,
      isFriend: hero.isFriend,
      energyClosetCount: hero.energyClosetCount,
      ability: hero.ability,
      feature: hero.feature,
      stacksId: [],
    );

    var ids = heroToDB.fromCardsStackToListInt(hero.heroStacks);
    heroToDB.stacksId.addAll(ids);
    print("DBProvider createHero() heroToDB == $heroToDB \n");

    var isHeroEmpty = await getHeroById(hero.id);
    if (isHeroEmpty.id != 0) {
      print("DBProvider createHero() HeroStack was in DB. Is it need to update?");
    } else {
      db.insert(heroTableName, heroToDB.toMap());
      print("DBProvider createHero() $heroToDB insert to DB");
    }
  }

  Future<HeroStack> getHeroById(int id) async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(
      heroTableName,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      var hDB = HeroStackDB.fromMap(maps.first);
      List<CardsStack> csList = [];

      for (var element in hDB.stacksId) {
        CardsStack stack = await getStackById(element);
        if (stack.id > 0) {
          csList.add(stack);
        }
      }

      HeroStack res = HeroStack(
        id: hDB.id,
        name: hDB.name,
        isFriend: hDB.isFriend,
        heroStacks: csList,
        energyClosetCount: hDB.energyClosetCount,
        ability: hDB.ability,
      );
      return res;
    } else {
      return const HeroStack.empty();
    }
  }

  Future<List<HeroStack>> getAllHeroes() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(heroTableName);

    List<HeroStack> stacks = [];
    stacks = await _pullStacksToHero(maps);
    //print("DBProvider getAllStacks() stacks == $stacks");

    return stacks;
  }

  _pullStacksToHero(List<Map<String, dynamic>> maps) async {
    List<HeroStackDB> hsDB = [];
    List<HeroStack> availableList = [];
    if (maps.isNotEmpty) {
      for (var element in maps) {
        hsDB.add(HeroStackDB.fromMap(element));
      }

      if (hsDB.isNotEmpty) {
        for (var i = 0; i < hsDB.length; i++) {
          List<CardsStack> list = [];
          for (var id in hsDB[i].stacksId) {
            CardsStack stack = await getStackById(id);
            if (stack.id > 0) {
              list.add(stack);
            }
          }

          var hs = HeroStack(
              id: hsDB[i].id,
              name: hsDB[i].name,
              isFriend: hsDB[i].isFriend,
              heroStacks: list,
              energyClosetCount: hsDB[i].energyClosetCount,
              ability: hsDB[i].ability, feature: hsDB[i].feature);
          availableList.add(hs);
        }
      }
    }

    return availableList;
  }
}
