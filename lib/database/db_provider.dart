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
  static const String cardsStackTableName = "Stack_Table";
  static const String heroStackTableName = "Hero_Table";

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
        await db.execute('CREATE TABLE IF NOT EXISTS $cardsTableName ('
            "card_id INTEGER PRIMARY KEY,"
            "text TEXT,"
            "img_path TEXT)"
            /*"CREATE TABLE IF NOT EXISTS $cardsStackTableName ("
            "stack_id INTEGER PRIMARY KEY,"
            "name TEXT,"
            "is_standart TEXT,"
            "stack_type TEXT,"
            "stack_color INTEGER,"
            "cards TEXT), "
            "CREATE TABLE IF NOT EXISTS $heroStackTableName ("
            "hero_id INTEGER PRIMARY KEY,"
            "hero_stack TEXT,"
            "energy_closet_count INTEGER,"
            "ability TEXT,"
            "feature TEXT,"
            "stack_id INTEGER,"
              "FOREIGN KEY (stack_id) REFERENCES $cardsStackTableName (stack_id)"
              "ON DELETE CASCADE"
              "ON UPDATE CASCADE)"*/
            );
      },
    );
  }


// Create, Read, Update, Delete (CRUD) operations for AECard
  /*void createCard(AECard card) async {
    final db = await getDatabase;
    await db.insert(cardsTableName, card.toJson());
  }

  Future<AECard> getCardById(int id) async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(cardsTableName,
        where: "card_id = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return AECard.fromJson(maps.first);
    } else {
      return AECard(id: 0, text: '', imgPath: '');
    }
  }

  Future<AECard> getCardByText(String text) async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(cardsTableName,
        where: "text = ?",
        whereArgs: [text]);
    if (maps.isNotEmpty) {
      return AECard.fromJson(maps.first);
    } else {
      return AECard(id: 0, text: '', imgPath: '');
    }
  }

  void updateCard(AECard card) async {
    final db = await getDatabase;
    await db.update(cardsTableName, card.toJson(),
        where: "card_id = ?",
        whereArgs: [card.id]
      );
  }
  
  void deleteCard(int id) async {
    final db = await getDatabase;
    await db.delete(cardsTableName,
        where: "card_id = ?",
        whereArgs: [id]
      );
  }

  Future<List<AECard>> getAllCards() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(cardsTableName);
    return List.generate(maps.length, (i) {
      return AECard.fromJson(maps[i]);
    });
  }*/


// Create, Read, Update, Delete (CRUD) operations for CardsStack
  /*void createStack(CardsStack stack) async {
    final db = await getDatabase;
    await db.insert(cardsStackTableName, stack.toJson());
  }

  Future<CardsStack> getStackById(int id) async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(cardsStackTableName,
        where: "stack_id = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return CardsStack.fromJson(maps.first);
    } else {
      return const CardsStack.empty();
    }
  }

  Future<List<CardsStack>> getAllStacks() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(cardsStackTableName);
    return List.generate(maps.length, (i) {
      return CardsStack.fromJson(maps[i]);
    });
  }

  void updateStack(CardsStack stack) async {
    final db = await getDatabase;
    await db.update(cardsStackTableName, stack.toJson(),
        where: "stack_id = ?",
        whereArgs: [stack.id]
      );
  }


  void deleteStack(int id) async {
    final db = await getDatabase;
    await db.delete(cardsStackTableName,
        where: "stack_id = ?",
        whereArgs: [id]
      );
  }*/

}
