import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:randomizer_new/database/cards_stack_db.dart';
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
        await db.execute("CREATE TABLE IF NOT EXISTS $cardsTableName ("
            "id INTEGER PRIMARY KEY, "
            "text TEXT, "
            "img_path TEXT)");
        await db.execute("CREATE TABLE IF NOT EXISTS $cardsStackTableName ("
            "id INTEGER PRIMARY KEY, "
            "name TEXT, "
            "is_standart INTEGER, "
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
        await db.insert(cardsTableName, card.toMap(),
          //conflictAlgorithm: ConflictAlgorithm.abort);
        );
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
      //print("DBProvider getCardById($id) the ${maps.first.toString()} was in the Database \n");
      return AECard.fromMap(maps.first);
    } else {
      //print("DBProvider getCardById($id) card does not Exist \n");
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
    //await db.insert(cardsStackTableName, stack.toMap());

    CardsStackDB stackToDB = CardsStackDB(
      id: stack.id, name: stack.name, isStandart: stack.isActive, 
      stackType: stack.stackType,  stackColor: stack.stackColor,
      cardsId: []);
    var ids = stackToDB.fromAECardToListInt(stack.cards);
    stackToDB.cardsId.addAll(ids);
    //fromCardsStackToCardsStackDB(stack);


    // For debugging purposes
    // Change to using getStackById
    List<CardsStackDB> dbList = [];
    List<Map<String, dynamic>> maps = await db.query(cardsStackTableName);
    print("DBProvider createStack() maps.length == ${maps.length} \n");
    if(maps.isNotEmpty) {
      for (var element in maps) {
        CardsStackDB stackFromDB = CardsStackDB.fromMap(element);
        if(stackFromDB.id == stack.id) {
          dbList.add(stackFromDB);
        }
        print("DBProvider createStack() stackFromDB == ${stackFromDB.toString()} \n");
      }
      if(dbList.isEmpty) {
        print("DBProvider createStack db.insert ${stackToDB.stackColor}");
        await db.insert(cardsStackTableName, stackToDB.toMap());
      }
    } else {
      print("DBProvider createStack() maps.isEmpty \n");
      await db.insert(cardsStackTableName, stackToDB.toMap());
    }
  }

  Future<CardsStack> getStackById(int id) async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(cardsStackTableName,
        where: "id = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      var csDB = CardsStackDB.fromMap(maps.first);
      List<AECard> list = [];

      for (var element in csDB.cardsId) {
        AECard card = await getCardById(element);
        if(card.id > 0) {
          list.add(card);
        }
      }

      CardsStack res = const CardsStack.empty();
      var newRes = res.csDBToCS(csDB, list);

      //print("DBProvider getStackById($id) res to return == $newRes");

      return newRes;  // CardsStack.fromJson(maps.first);
    } else {
      return const CardsStack.empty();
    }
  }

  Future<List<CardsStack>> getAvailableStacks() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> maps = await db.query(cardsStackTableName,
      where: "is_standart = ?",
      whereArgs: [1]
    );
    
    List<CardsStackDB> csDB = [];
    for (var element in maps) {
      csDB.add(CardsStackDB.fromMap(element));
    }

    List<CardsStack> availableList = [];
    for (var i = 0; i < csDB.length; i++) {
      List<AECard> list = [];
      for (var element in csDB[i].cardsId) {
        AECard card = await getCardById(element);
        if(card.id > 0) {
          list.add(card);
        }
      }
      var cs = const CardsStack.empty();
      availableList.add(cs.csDBToCS(csDB[i], list));  
    }

    return availableList;
  }

/*
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
