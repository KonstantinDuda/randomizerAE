import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cards_stack.dart';
//import 'cards_stack_db.dart';
//import 'cards_stack_db.dart';
import 'db_provider.dart';

class DefaultData {
  final _db = DBProvider();
  List<AECard> _cards = [];
  List<CardsStack> _stacks = [];
  //List<HeroStack> friendFoeList = [];

  //List<AECard> _ffCards = [];

  List<List<AECard>> story = [];

  static final DefaultData _dbProvider = DefaultData._();
  DefaultData._();
  factory DefaultData() {
    return _dbProvider;
  }

// Cards
  Future<List<AECard>> getCards() async {
    if (_cards.isNotEmpty) {
      return _cards;
    } else {
      _cards = await _db.getAllCards();
      return _cards;
    }
  }

  List<AECard> getCardsById(List<int> ids) {
    List<AECard> result = [];
    //print("DefData getCardsById: cards.length == ${_cards.length}");
    for (var id in ids) {
      //print("DefData getCardsById: id in for == $id");
      var card = _cards.firstWhere((element) => element.id == id,
          orElse: () => AECard(id: 0, name: '', text: ''));
      if (card.id != 0) {
        result.add(card);
      }
    }
    //print("DefData getCardById: result == $result");
    return result;
  }

  // setCards(List<AECard> newCards) {
  //   _cards = newCards;
  // }

  newCard(AECard card) {
    _cards.add(card);
    _db.createCard(card);
  }

  updateCard(AECard card) {
    for (var i = 0; i < _cards.length; i++) {
      if (_cards[i].id == card.id) {
        _cards[i] = card;
        _db.updateCard(card);
        // print("DefaultData updateCard card == $card");
        return _cards;
      }
    }
  }

  deleteCard(int id) {
    _db.deleteCard(id);
    _cards.removeWhere((card) => card.id == id);
  }

  // Friend Foe Cards
  void addCardsToDB() async {
    for (var element in _cards) {
      _db.createCard(element);
    }
    // print("DefaultData FriendFoeData addCardsToDB in comment now");
  }

  addCardToStory(AECard card, bool isNewTurn) {
    if (isNewTurn) {
      story.add([card]);
    } else {
      var list = story.last;
      list.add(card);
      story.removeLast();
      story.add(list);
    }
  }

// Stacks
  Future<List<CardsStack>> getStacks() async {
    if (_stacks.isNotEmpty) {
      return _stacks;
    } else {
      _stacks = await _db.getAllStacks();
      return _stacks;
    }
  }

  Future<List<CardsStack>> getAvailableStacks() async {
    List<CardsStack> aStacks = [];
    if (_stacks.isNotEmpty) {
      _stacks.map((e) {
        if (e.isActive) {
          aStacks.add(e);
        }
      });
    } else {
      _stacks = await _db.getAllStacks();
      aStacks = await _db.getAvailableStacks();
    }
    return aStacks;
  }

  Future<CardsStack> getStack(int id) async {
    // var stack = _stacks.firstWhere(((e) => e.id == id),
    //     orElse: () => const CardsStack.empty());
    // if (stack.id == 0) {
    var stack = await _db.getStackById(id);
    // }
    print("DD getStack: stack == $stack");
    return stack;
  }

  newStack(CardsStack stack) async {
    await _db.createStack(stack);
    _stacks = await _db.getAllStacks();
  }

  setStacks(List<CardsStack> newStacks) {
    _stacks = newStacks;
  }

  updateStack(CardsStack stack) {
    for (var i = 0; i < _stacks.length; i++) {
      if (_stacks[i].id == stack.id) {
        _stacks[i] = stack;
        _db.updateStack(stack);
        // // print("DefaultData updateStack stack == $stack");
        return _stacks;
      }
    }
    return _stacks;
  }

  deleteStack(int id) {
    _db.deleteStack(id);
    _stacks.removeWhere((stack) => stack.id == id);
  }

// Heroes
  /*Future<List<HeroStack>> getHeroes() async {
    if (friendFoeList.isNotEmpty) {
      return friendFoeList;
    } else {
      friendFoeList = await _db.getAllHeroes();
      return friendFoeList;
    }
  }
  HeroStack getHeroByStackId(int stackId) {
    for (var element in friendFoeList) {
      if (element.heroStack.id == stackId) {
         return element;
      }
    }
    return const HeroStack.empty();
  }
  newHero(HeroStack hero) async {
    //friendFoeList.add(hero);
    _db.createHero(hero);
    friendFoeList = await _db.getAllHeroes();
    // // print("DefaultData newHero hero == $hero");
  }
  updateHero(int id, HeroStack hero) async {
    int index = friendFoeList.indexWhere((hero) => hero.id == id);
    if (index != -1) {
      friendFoeList[index] = hero;
      _db.updateHero(hero);
      // print("DefaultData updateHero hero == ${hero.name}");
      return friendFoeList;
    } else {
      // print("DefaultData updateHero hero with id $id not found");
    }
  }
  deleteHero(int id) async {
    await _db.deleteHero(id);
    friendFoeList.removeWhere((hero) => hero.id == id);
  }
  setHeroes(List<HeroStack> newHeroes) {
    friendFoeList = newHeroes;
  }*/

// Default Data
  createDefaultData() async {
    var firstRunCards = await _db.getAllCards();
    if (firstRunCards.isEmpty) {
      // If the database is empty, create default data
      //Cards
      final String responseCards = await rootBundle.loadString(
        'assets/json/cards.json',
      );
      final jsonCards = await json.decode(responseCards);
      var toCards =
          (jsonCards['cards'] as List).map((e) => AECard.fromMap(e)).toList();
      _cards.addAll(toCards);
      print(
          "DefData createDD: _cards.length == ${_cards.length} after TOCards generate");

      final String responseFfCards = await rootBundle.loadString(
        'assets/json/ff_cards.json',
      );
      final jsonFfCards = await json.decode(responseFfCards);
      var fFcards = (jsonFfCards['ff_cards'] as List)
          .map((e) => AECard.fromMap(e))
          .toList();
      _cards.addAll(fFcards);
      print("default_data. createDD: _cards.length == ${_cards.length}");

      for (var element in _cards) {
        _db.createCard(element);
      }
      print(
          "DefData createDD: _cards.length == ${_cards.length} after fFCards generate");

      var cardsLength = await _db.getAllCards();
      print("DefData createDD: cardsLength == $cardsLength from _db");
    } else {
      print("default_data. firstRunCards.isNotEmpty");
      _cards = firstRunCards;
    }

// Stacks
    var firstRunStacks = await _db.getAllStacks();
    if (firstRunStacks.isEmpty) {
      final String responseStacks = await rootBundle.loadString(
        'assets/json/stacks.json',
      );
      final jsonStacks = await json.decode(responseStacks);
      var dbStacks = (jsonStacks['to_stacks'] as List<dynamic>)
          .map((e) => CardsStack.fromJson(e))
          .toList();
// Friend Foe stacks
      final String responseFFStacks = await rootBundle.loadString(
        'assets/json/ff_stacks.json',
      );
      final jsonFFStacks = await json.decode(responseFFStacks);
      var dbFFStacks = (jsonFFStacks['ff_stacks'] as List<dynamic>)
          .map((e) => CardsStack.fromJson(e))
          .toList();

      _stacks.addAll(dbStacks);
      _stacks.addAll(dbFFStacks);
      print("default_data. createDD: _stacks.length: ${_stacks.length}");
      for (var element in _stacks) {
        _db.createStack(element);
      }
    } else {
      print("default_data. firstRunStacks.isNotEmpty");
      _stacks = firstRunStacks;
    }
  }
}
