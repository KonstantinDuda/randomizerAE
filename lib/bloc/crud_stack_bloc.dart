import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_state/crud_stack_es.dart';
import '../database/cards_stack.dart';
import '../database/db_provider.dart';

//import '../database/db_temporary.dart';

class CRUDStackBloc extends Bloc<CRUDStackEvent, CRUDStackState> {
  //final database = DbTemporary();
  final db = DBProvider();

  List<AECard> cards = [];
  List<CardsStack> stacks = [];

  CRUDStackBloc() : super(const CRUDStackSuccessActionState()) {
    on<CRUDStackInitialEvent>(_onInit);
    on<CRUDStackNewCardEvent>(_onNewCard);
    on<CRUDStackUpdateCardEvent>(_onUpdateCard);
    on<CRUDStackDeleteCardEvent>(_onDeleteCard);
    on<CRUDStackNewStackEvent>(_onNewStack);
    on<CRUDStackUpdateStackEvent>(_onUpdateStack);
    on<CRUDStackDeleteStackEvent>(_onDeleteStack);
  }

  _onInit(CRUDStackInitialEvent event, Emitter<CRUDStackState> emit) async {
    cards = await db.getAllCards();
    stacks = await db.getAllStacks();

    print("CRUDStackBlock _onInit stacks.length == ${stacks.length}");

    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onNewCard(CRUDStackNewCardEvent event, Emitter<CRUDStackState> emit) async {
    print(
        "CRUDStackBlock _onNewCard event.data == \n ${event.name}, ${event.isOptional}, ${event.textBeforeOr}, ${event.textAfterOr}, ${event.type} ");
    AECard newCard = AECard(id: 0, text: "", imgPath: "");

    void isOptionalFunc(String type) {
      print("CRUDStackBlock _onNewCard isOptionalFunc type == $type");
      
      var resultType = "";
      if(type == "Friend" || type == "Foe") {
        resultType = "friend foe/${type.toLowerCase()}/";
      } else {
        resultType = "${type.toLowerCase()}/";
      }
      if (event.isOptional) {
        print("CRUDStackBlock _onNewCard isOptionalFunc isOptional");
          if (event.textAfterOr.isNotEmpty) {
            newCard.imgPath =
                "assets/images/${resultType.toLowerCase()}${event.textBeforeOr} or ${event.textAfterOr}";
            newCard.text = "${event.textBeforeOr} OR ${event.textAfterOr}";
          }
        } else {
          print("CRUDStackBlock _onNewCard isOptionalFunc else");
          if (event.textAfterOr.isNotEmpty) {
            newCard.imgPath =
                "assets/images/${resultType.toLowerCase()}${event.textBeforeOr} ${event.textAfterOr}";
            newCard.text = "${event.textBeforeOr} ${event.textAfterOr}";
          }
        }
        //newCard.imgPath = "assets/images/${resultType.toLowerCase()}${event.textBeforeOr}";
        //newCard.text = event.textBeforeOr;
    }

    if (event.textBeforeOr.isNotEmpty) {
      print("CRUDStackBlock _onNewCard event.textBeforeOr.isNotEmpty");
      if (event.type == "Turn order") {
        isOptionalFunc("Turn order");
      } else
      if (event.type == "Friend") {
        isOptionalFunc("Friend");
      } else
      if (event.type == "Foe") {
        isOptionalFunc("Friend");
      } else
      if (event.type == "Nemesis") {
        isOptionalFunc("Friend");
      } else
      if (event.type == "Gravehold") {
        isOptionalFunc("Friend");
      } else
      if (event.type == "Suply") {
        isOptionalFunc("Friend");
      } else
      if (event.type == "Hero") {
        isOptionalFunc("Friend");
      } else {
        isOptionalFunc("Other");
      }
    }

    if(newCard.text.isNotEmpty && newCard.imgPath.isNotEmpty) {
      db.createCard(newCard);
    }

    print("CRUDStackBlock _onNewCard newCard == $newCard");

    List<AECard> newCardsList = await db.getAllCards();
    cards = newCardsList;

    emit(CRUDStackSuccessActionState(newCardsList, stacks));
  }

  _onUpdateCard(CRUDStackUpdateCardEvent event, Emitter<CRUDStackState> emit) {
    print("CRUDStackBloc _onUpdateCard event.card.id == ${event.card.id}");

    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onDeleteCard(CRUDStackDeleteCardEvent event, Emitter<CRUDStackState> emit) async {
    print("CRUDStackBloc _onDeleteCard card.id == ${event.id}");

    db.deleteCard(event.id);

    cards = await db.getAllCards();

    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onNewStack(CRUDStackNewStackEvent event, Emitter<CRUDStackState> emit) {
    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onUpdateStack(
      CRUDStackUpdateStackEvent event, Emitter<CRUDStackState> emit) async {
    print("CRUDStackBloc _onUpdateStack event.stack == ${event.stack}");

    var stackFromDB = await db.getStackById(event.stack.id);
    if (stackFromDB.id == event.stack.id &&
        stackFromDB.name == event.stack.name &&
        stackFromDB.isActive == event.stack.isActive &&
        stackFromDB.stackType == event.stack.stackType &&
        stackFromDB.stackColor == event.stack.stackColor) {
      var cardsIsEqual = true;
      for (var i = 0; i < stackFromDB.cards.length; i++) {
        stackFromDB.cards[i] == event.stack.cards[i]
            ? cardsIsEqual = true
            : cardsIsEqual = false;
      }
      if (cardsIsEqual) {
        print("CRUDStackBloc _onUpdateStack stackFromDB == event.stack");
      } else {
        print("CRUDStackBloc _onUpdateStack cardsIsEqual == $cardsIsEqual");
      }
    } else {
      print("CRUDStackBloc _onUpdateStack stackFromDB.id != event.stack.id");
    }

    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onDeleteStack(
      CRUDStackDeleteStackEvent event, Emitter<CRUDStackState> emit) async {
    var stackFromDB = await db.getStackById(event.id);
    print("CRUDStackBloc _onDeleteStack delete $stackFromDB?");

    emit(CRUDStackSuccessActionState(cards, stacks));
  }
}
