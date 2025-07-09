import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/default_data.dart';
import 'event_state/crud_stack_es.dart';
import '../database/cards_stack.dart';
import '../database/db_provider.dart';

class CRUDStackBloc extends Bloc<CRUDStackEvent, CRUDStackState> {
  final defaultData = DefaultData();
  final db = DBProvider();

  List<AECard> cards = [];
  List<CardsStack> stacks = [];

  CRUDStackBloc() : super(const CRUDStackSuccessActionState()) {
    on<CRUDStackInitialEvent>(_onInit);
    on<CRUDStackNewCardEvent>(_onNewCard);
    //on<CRUDStackUpdateCardEvent>(_onUpdateCard);
    on<CRUDStackDeleteCardEvent>(_onDeleteCard);
    on<CRUDStackNewStackEvent>(_onNewStack);
    on<CRUDStackUpdateStackEvent>(_onUpdateStack);
    on<CRUDStackUpdateAvailableListEvent>(_onUpdateAvailableList);
    on<CRUDStackDeleteStackEvent>(_onDeleteStack);
  }

  _onInit(CRUDStackInitialEvent event, Emitter<CRUDStackState> emit) async {
    print("CRUDStackBlock _onInit event == $event");

    cards = await defaultData.getCards();
    stacks = await defaultData.getStacks();

    // cards = await db.getAllCards();
    // stacks = await db.getAllStacks();

    print("CRUDStackBlock _onInit carts.length == ${cards.length}");
    print("CRUDStackBlock _onInit stacks.length == ${stacks.length}");

    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onNewCard(CRUDStackNewCardEvent event, Emitter<CRUDStackState> emit) async {
    print(
        "CRUDStackBlock _onNewCard event.data == \n ${event.id} ${event.name}, ${event.isOptional}, ${event.textBeforeOr}, ${event.textAfterOr}, ${event.type} ");
    AECard newCard = AECard(id: event.id, text: "", imgPath: "");
    var cardName = event.name.isNotEmpty ? event.name : "";
    var cardIsOptional = event.isOptional;
    var cardTextBeforeOr = "";
    var cardTextAfterOr = "";
    var cardType = event.type;
    if (event.textBeforeOr.isNotEmpty && event.textAfterOr.isNotEmpty) {
      cardTextBeforeOr = event.textBeforeOr;
      cardTextAfterOr = event.textAfterOr;
    } else if (event.textBeforeOr.isEmpty && event.textAfterOr.isNotEmpty) {
      cardTextBeforeOr = event.textAfterOr;
    } else if (event.textBeforeOr.isNotEmpty && event.textAfterOr.isEmpty) {
      cardTextBeforeOr = event.textBeforeOr;
    }

    void isOptionalFunc(String type) {
      print("CRUDStackBlock _onNewCard isOptionalFunc type == $type");

      var resultType = "";
      if (type == "Friend" || type == "Foe") {
        resultType = "friend foe/${type.toLowerCase()}/";
      } else {
        resultType = "${type.toLowerCase()}/";
      }

      if (cardIsOptional) {
        print("CRUDStackBlock _onNewCard isOptionalFunc event.isOptional \n");
        if (type == "Turn order") {
          if (cardTextAfterOr.isNotEmpty) {
            newCard.imgPath =
                "assets/images/${resultType.toLowerCase()}$cardTextBeforeOr or $cardTextAfterOr.png";
            newCard.text = "$cardTextBeforeOr OR $cardTextAfterOr";
          } else {
            newCard.imgPath =
                "assets/images/${resultType.toLowerCase()}$cardTextBeforeOr.png";
            newCard.text = cardTextBeforeOr;
          }
        } else {
          newCard.imgPath =
              "assets/images/${resultType.toLowerCase()}$cardName.png";
          if (cardTextAfterOr.isNotEmpty) {
            newCard.text = "$cardName: $cardTextBeforeOr OR $cardTextAfterOr";
          } else {
            newCard.text = "$cardName: $cardTextBeforeOr";
          }
        }
      } else {
        print(
            "CRUDStackBlock _onNewCard isOptionalFunc event.isOptional ELSE: \n");
        if (type == "Turn order") {
          if (cardTextAfterOr.isNotEmpty) {
            newCard.imgPath =
                "assets/images/${resultType.toLowerCase()}$cardTextBeforeOr $cardTextAfterOr.png";
            newCard.text = "$cardTextBeforeOr $cardTextAfterOr";
          } else {
            newCard.imgPath =
                "assets/images/${resultType.toLowerCase()}$cardTextBeforeOr.png";
            newCard.text = cardTextBeforeOr;
          }
        } else {
          newCard.imgPath =
              "assets/images/${resultType.toLowerCase()}$cardName.png";
          if (cardTextAfterOr.isNotEmpty) {
            newCard.text = "$cardName: $cardTextBeforeOr $cardTextAfterOr";
          } else {
            newCard.text = "$cardName: $cardTextBeforeOr";
          }
        }
      }
    }

    if (cardTextBeforeOr.isNotEmpty) {
      print("CRUDStackBlock _onNewCard event.textBeforeOr.isNotEmpty");
      if (cardType == "Turn order") {
        isOptionalFunc("Turn order");
      } else if (cardType == "Friend") {
        isOptionalFunc("Friend");
      } else if (cardType == "Foe") {
        isOptionalFunc("Foe");
      } else if (cardType == "Nemesis") {
        isOptionalFunc("Nemesis");
      } else if (cardType == "Gravehold") {
        isOptionalFunc("Gravehold");
      } else if (cardType == "Suply") {
        isOptionalFunc("Suply");
      } else if (cardType == "Hero") {
        isOptionalFunc("Hero");
      } else {
        isOptionalFunc("Other");
      }
    }

    if (newCard.id == 0) {
      if (newCard.text.isNotEmpty && newCard.imgPath.isNotEmpty) {
        print(
            "CRUDStackBlock _onNewCard newCard.id == 0 \n create newCard == $newCard");
        db.createCard(newCard);
      }
    } else if (newCard.text.isNotEmpty && newCard.imgPath.isNotEmpty) {
      print(
          "CRUDStackBlock _onNewCard newCard.id != 0 \n update newCard == $newCard");
      db.updateCard(newCard);
    }

    print("CRUDStackBlock _onNewCard newCard == $newCard");

    List<AECard> newCardsList = await db.getAllCards();
    cards = newCardsList;

    emit(CRUDStackSuccessActionState(newCardsList, stacks));
  }

  // _onUpdateCard(CRUDStackUpdateCardEvent event, Emitter<CRUDStackState> emit) {
  //   print("CRUDStackBloc _onUpdateCard event.card.id == ${event.id}");

  //   emit(CRUDStackSuccessActionState(cards, stacks));
  // }

  _onDeleteCard(
      CRUDStackDeleteCardEvent event, Emitter<CRUDStackState> emit) async {
    print("CRUDStackBloc _onDeleteCard card.id == ${event.id}");

    //db.deleteCard(event.id);

    //cards = await db.getAllCards();

    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onNewStack(CRUDStackNewStackEvent event, Emitter<CRUDStackState> emit) {
    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onUpdateStack(
      CRUDStackUpdateStackEvent event, Emitter<CRUDStackState> emit) async {
    print("CRUDStackBloc _onUpdateStack event.stack == ${event.stack}");
    var stacksFromDB = await db.getAllStacks();

// This was commented
    var stackFromDB = await db.getStackById(event.stack.id);
    if (stackFromDB.id == 0) {
      print("CRUDStackBloc _onUpdateStack stackFromDB.id == 0");
      db.createStack(event.stack);
    } else {
      print("CRUDStackBloc _onUpdateStack stackFromDB.id != 0");
      if (stackFromDB.name == event.stack.name &&
          stackFromDB.isActive == event.stack.isActive &&
          stackFromDB.stackType == event.stack.stackType &&
          stackFromDB.stackColor == event.stack.stackColor &&
          stackFromDB.cards.length == event.stack.cards.length) {
        var cardsIsEqual = true;
        for (var i = 0; i < stackFromDB.cards.length; i++) {
          stackFromDB.cards[i] == event.stack.cards[i]
              ? cardsIsEqual = true
              : cardsIsEqual = false;
        }
        if (cardsIsEqual) {
          print("CRUDStackBloc _onUpdateStack stackFromDB == event.stack");
        } else {
          db.updateStack(event.stack);
          print("CRUDStackBloc _onUpdateStack cardsIsEqual == $cardsIsEqual");
        }
      } else {
        print(
            "CRUDStackBloc _onUpdateStack stackFromDB.id == event.stack.id, stackFromDB != event.stack");
        db.updateStack(event.stack);
      }
    }

    var newStacks = await db.getAllStacks();
    stacks = newStacks;

    emit(CRUDStackSuccessActionState(cards, newStacks));
// This was commented

    print(
        "CRUDStackBloc _onUpdateStack stacks.length == ${stacksFromDB.length}, newStacks.length == ${newStacks.length}");
  }

  _onUpdateAvailableList(CRUDStackUpdateAvailableListEvent event,
      Emitter<CRUDStackState> emit) async {
    print("CRUDStackBloc _onUpdateAvailableList event.List<id> == ${event.id}");

    var ddStacks = await defaultData.getStacks();
    List<CardsStack> newStackList = [];

    for (var i = 0; i < ddStacks.length; i++) {
      CardsStack localStack = ddStacks[i];
      for (var j = 0; j < event.id.length; j++) {
        if (ddStacks[i].id == event.id[j]) {
          // print(
          //     "CRUDStackBloc _onUpdateAvailableList ddStacks[$i].id == event.id[$j]");

          localStack = CardsStack(
              id: ddStacks[i].id,
              name: ddStacks[i].name,
              isActive: ddStacks[i].isActive == true ? false : true,
              stackType: ddStacks[i].stackType,
              stackColor: ddStacks[i].stackColor,
              cards: ddStacks[i].cards);
        }
      }
      newStackList.add(localStack);
    }
    stacks = newStackList;
    defaultData.setStacks(newStackList);

    // for (var i = 0; i < ddStacks.length; i++) {
    //   print(
    //       "CRUDStackBloc _onUpdateAvailableList ddStacks[$i].isActive \t ${ddStacks[i].name} == ${ddStacks[i].isActive}");
    //   print(
    //       "CRUDStackBloc _onUpdateAvailableList newStackList[$i].isActive \t ${newStackList[i].name} == ${newStackList[i].isActive}");
    // }

    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onDeleteStack(
      CRUDStackDeleteStackEvent event, Emitter<CRUDStackState> emit) async {
    //var stackFromDB = await db.getStackById(event.id);
    print("CRUDStackBloc _onDeleteStack delete ${event.id}?");
    // db.deleteStack(event.id);

    // var newStacks = await db.getAllStacks();
    // stacks = newStacks;

    // emit(CRUDStackSuccessActionState(cards, newStacks));
  }
}
