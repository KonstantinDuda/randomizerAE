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
    print("Database was initialized \n");
    print("Database was initialized \n");
    print("Database was initialized \n");
    print("Database was initialized \n");
    print("Database was initialized \n");
    print("Database was initialized \n");
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
            await db.execute("CREATE TABLE IF NOT EXISTS $cardsStackTableName ("
            "id INTEGER PRIMARY KEY, "
            "name TEXT, "
            "is_standart TEXT, "
            "stack_type TEXT, "
            "stack_color INTEGER, "
            "cards TEXT)");
            
            /*"CREATE TABLE IF NOT EXISTS $heroStackTableName ("
            "id INTEGER PRIMARY KEY,"
            "hero_stack TEXT,"
            "energy_closet_count INTEGER,"
            "ability TEXT,"
            "feature TEXT,"
            "stack_id INTEGER,"
              "FOREIGN KEY (stack_id) REFERENCES $cardsStackTableName (id)"
              "ON DELETE CASCADE"
              "ON UPDATE CASCADE)"*/
            
      },
    );
  }


// Create, Read, Update, Delete (CRUD) operations for AECard
  void createCard(AECard card) async {
    final db = await getDatabase;
    if(card.id > 0) {
      var x = await getCardById(card.id);
      if(x.id == 0) {
        await db.insert(cardsTableName, card.toMap());
        print("DBProvider createCard() db.insert $card \n");
      } else {
        print("DBProvider createCard() card was in the Database \n");
      }
    }
    

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
    List<Map<String, Object?>> maps = await db.query(cardsTableName,
        where: "id = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      print("DBProvider getCardById($id) the ${maps.first.toString()} was in the Database \n");
      return AECard.fromMap(maps.first);
    } else {
      print("DBProvider getCardById($id) card does not Exist \n");
      return AECard(id: 0, text: '', imgPath: '');
    }
  }

  /*Future<AECard> getCardByText(String text) async {
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
  void createStack(CardsStack stack) async {
    final db = await getDatabase;
    await db.insert(cardsStackTableName, stack.toMap());

    // For debugging purposes
    List<Map<String, Object?>> maps = await db.query(cardsStackTableName);
    print("DBProvider createStack() maps == ${maps.length} \n");
    if(maps.isNotEmpty) {
      for (var element in maps) {
        AECard stackFromDB = AECard.fromMap(element);
        print("DBProvider createStack() stackFromDB == ${stackFromDB.toString()} \n");
      }
    } else {
      print("DBProvider createStack() maps.isEmpty \n");
    }
  }

  /*Future<CardsStack> getStackById(int id) async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(cardsStackTableName,
        where: "stack_id = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return CardsStack.fromJson(maps.first);
    } else {
      return const const CardsStack.empty();
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
