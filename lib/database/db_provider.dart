import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'cards_stack.dart';

class DBProvider {
  late Database _aeonsEndDatabase;

  static const String cardsTableName = "Cards_Table";
  static const String stackTableName = "Stack_Table";

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
            "name TEXT)");
        await db.execute("CREATE TABLE IF NOT EXISTS $stackTableName ("
            "id INTEGER PRIMARY KEY, "
            "name TEXT, "
            "is_standart INTEGER, "
            "stack_type TEXT, "
            "stack_color INTEGER, "
            "cards TEXT, "
            "description TEXT)");
      },
    );
  }

// Create, Read, Update, Delete (CRUD) operations for AECard
  void createCard(AECard card) async {
    final db = await getDatabase;

    var x = await getCardById(card.id);
    if (x.id == 0) {
      await db.insert(
        cardsTableName, card.toMap(),
        //conflictAlgorithm: ConflictAlgorithm.abort);
      );
    } else {
      print("DBProvider createCard() card ${card.id} was in the Database \n");
    }
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
      return AECard(id: 0, text: '', name: '');
    }
  }

  void updateCard(AECard card) async {
    final db = await getDatabase;

    var cardBefore = await getCardById(card.id);
    print("DBProvider update card, card before: $cardBefore");

    await db.update(cardsTableName, card.toMap(),
        where: "id = ?", whereArgs: [card.id]);

    var cardAfter = await getCardById(card.id);
    print("DBProvider update card, card after: $cardAfter");
  }

  void deleteCard(int id) async {
    final db = await getDatabase;
    await db.delete(cardsTableName, where: "id = ?", whereArgs: [id]);

    // Delete card from all stacks // Addad 08.09.2025
    List<Map<String, dynamic>> maps = await db.query(stackTableName);
    List<CardsStack> allStacks = [];
    if (maps.isNotEmpty) {
      for (var element in maps) {
        allStacks.add(CardsStack.fromJson(element));
      }
    }
    for (var stack in allStacks) {
      if (stack.cards.any((card) => card.id == id)) {
        stack.cards.removeWhere((card) => card.id == id);
        await updateStack(stack);
      }
    }
  }

  Future<List<AECard>> getAllCards() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(cardsTableName);
    var result = List.generate(maps.length, (i) => AECard.fromMap(maps[i]));
    return result;
  }

// Create, Read, Update, Delete (CRUD) operations for CardsStack
  Future<void> createStack(CardsStack stack) async {
    final db = await getDatabase;

    var x = await getStackById(stack.id);
    if (x.id == 0) {
      await db.insert(
        stackTableName, stack.toJson(),
        //conflictAlgorithm: ConflictAlgorithm.abort);
      );
    } else {
      print(
          "DBProvider createStack() stack ${stack.id} was in the Database \n");
    }
  }

  Future<CardsStack> getStackById(int id) async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps =
        await db.query(stackTableName, where: "id = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      var newRes = await _pullCardsToStack(maps);
      print("DBProvider getStackById: newRes == $newRes");
      return newRes.first; // CardsStack.fromJson(maps.first);
    } else {
      return const CardsStack.empty();
    }
  }

  Future<List<CardsStack>> getAllStacks() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(stackTableName);

    List<CardsStack> stacks = [];
    stacks = await _pullCardsToStack(maps);

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

    List<CardsStack> availableList = await _pullCardsToStack(maps);

    return availableList;
  }

  Future<List<CardsStack>> getFriendFoeStacks() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> mapsFriend = await db.query(stackTableName,
        where: "stack_type = ?", whereArgs: ["StackType.friend"]);

    List<CardsStack> availableList = await _pullCardsToStack(mapsFriend);

    List<Map<String, dynamic>> mapsFoe = await db.query(stackTableName,
        where: "stack_type = ?", whereArgs: ["StackType.foe"]);

    availableList.addAll(await _pullCardsToStack(mapsFoe));

    return availableList;
  }

  Future<List<CardsStack>> _pullCardsToStack(
      List<Map<String, dynamic>> maps) async {
    List<CardsStack> cs = [];
    if (maps.isNotEmpty) {
      for (var element in maps) {
        print("DBProvider _pullCardsToStack element == $element");
        cs.add(CardsStack.fromJson(element));
      }
    }

    return cs;
  }

  Future<void> updateStack(CardsStack stack) async {
    final db = await getDatabase;

    await db.update(stackTableName, stack.toJson(),
        where: "id = ?", whereArgs: [stack.id]);
  }

  Future<void> deleteStack(int id) async {
    final db = await getDatabase;
    await db.delete(stackTableName, where: "id = ?", whereArgs: [id]);
  }
}
