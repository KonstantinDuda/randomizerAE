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
    on<CRUDDataFromDBEvent>(_onDBData);
    on<CRUDStackFilterEvent>(_onFilter);
  }

  _onInit(CRUDStackInitialEvent event, Emitter<CRUDStackState> emit) async {
    //print("CRUDStackBlock _onInit event == $event");

    cards = await defaultData.getCards();
    stacks = await defaultData.getStacks();

    emit(CRUDStackSuccessActionState(cards.toList(), stacks.toList()));
  }

  _onNewCard(CRUDStackNewCardEvent event, Emitter<CRUDStackState> emit) async {
    print(
        "CRUDStackNewCard event.card.name == ${event.card.name} \n event.card.text == ${event.card.text}");
    AECard newCard = event.card;

    if (newCard.name.isEmpty && newCard.text.isNotEmpty) {
      var cardName = newCard.text.split(' ').first;
      newCard.name = cardName;
    }

    print(
        "CRUDStackNewCard newCard == $newCard, cards.length == ${cards.length}");
    cards.add(
        AECard(id: cards.last.id + 1, name: newCard.name, text: newCard.text));
    defaultData.newCard(newCard);
    print(
        "\n CRUDStackNewCard after getCards cards.length == ${cards.length} \n");

    emit(CRUDStackSuccessActionState(
        /*newCardsList*/ cards.toList(), stacks.toList()));
  }

  // _onUpdateCard(CRUDStackUpdateCardEvent event, Emitter<CRUDStackState> emit) {
  //   print("CRUDStackBloc _onUpdateCard event.card.id == ${event.id}");

  //   emit(CRUDStackSuccessActionState(cards, stacks));
  // }

  _onDeleteCard(
      CRUDStackDeleteCardEvent event, Emitter<CRUDStackState> emit) async {
    //print("CRUDStackBloc _onDeleteCard card.id == ${event.id}");

    defaultData.deleteCard(event.id);
    cards = await defaultData.getCards();

    emit(CRUDStackSuccessActionState(cards.toList(), stacks.toList()));
  }

  _onNewStack(CRUDStackNewStackEvent event, Emitter<CRUDStackState> emit) {
    emit(CRUDStackSuccessActionState(cards.toList(), stacks.toList()));
  }

  _onUpdateStack(
      CRUDStackUpdateStackEvent event, Emitter<CRUDStackState> emit) async {
    //print("CRUDStackBloc _onUpdateStack event.stack == ${event.stack}");
    //var stacksFromDB = await db.getAllStacks();
    List<CardsStack> newStacks = [];
    //print(
    //"CRUDStackBloc _onUpdateStack event.stack.description == ${event.stack.description}");

    var stackFromDB = await db.getStackById(event.stack.id);
    if (stackFromDB.id == 0) {
      //print("CRUDStackBloc _onUpdateStack stackFromDB.id == 0");
      defaultData.newStack(event.stack);
      newStacks = await defaultData.getStacks();
    } else {
      //print("CRUDStackBloc _onUpdateStack stackFromDB.id != 0");
      if (stackFromDB.name == event.stack.name &&
          stackFromDB.isActive == event.stack.isActive &&
          stackFromDB.stackType == event.stack.stackType &&
          stackFromDB.stackColor == event.stack.stackColor &&
          stackFromDB.cards.length == event.stack.cards.length &&
          stackFromDB.description == event.stack.description) {
        var cardsIsEqual = true;
        for (var i = 0; i < stackFromDB.cards.length; i++) {
          stackFromDB.cards[i] == event.stack.cards[i]
              ? cardsIsEqual = true
              : cardsIsEqual = false;
        }
        if (cardsIsEqual) {
          //print("CRUDStackBloc _onUpdateStack stackFromDB == event.stack");
        } else {
          //db.updateStack(event.stack);
          newStacks = defaultData.updateStack(event.stack);
          //print("CRUDStackBloc _onUpdateStack cardsIsEqual == $cardsIsEqual");
        }
      } else {
        //print(
        //"CRUDStackBloc _onUpdateStack stackFromDB.id == event.stack.id, stackFromDB != event.stack");
        //db.updateStack(event.stack);
        newStacks = defaultData.updateStack(event.stack);
      }
    }

    //var newStacks = await db.getAllStacks();
    //defaultData.setStacks(newStacks);
    stacks =
        newStacks; // TODO: Новостворені карти не додаються до нового стосу, та він не відображається у боковому меню,
    // Але в БД все записується коректно, адже після перезаходу в програму новостворена катра там є і в боковому меню стос є
    cards = await defaultData.getCards();

    emit(CRUDStackSuccessActionState(cards.toList(), newStacks.toList()));

    // print(
    //     "CRUDStackBloc _onUpdateStack stacks.length == ${stacksFromDB.length}, newStacks.length == ${stacks.length}");
  }

  _onUpdateAvailableList(CRUDStackUpdateAvailableListEvent event,
      Emitter<CRUDStackState> emit) async {
    //print("CRUDStackBloc _onUpdateAvailableList event.List<id> == ${event.id}");

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
            cards: ddStacks[i].cards,
            description: ddStacks[i].description,
          );
          defaultData
              .updateStack(localStack); // Added to update the stack in DB
        }
      }
      newStackList.add(localStack);
    }
    stacks = newStackList;
    defaultData.setStacks(newStackList);

    //print(
    // "CRUDStackBloc _onUpdateAvailableList newStackList.length == ${newStackList.length}");

    emit(CRUDStackSuccessActionState(cards.toList(), stacks.toList()));
  }

  _onDeleteStack(
      CRUDStackDeleteStackEvent event, Emitter<CRUDStackState> emit) async {
    //print("CRUDStackBloc _onDeleteStack delete ${event.id}?");
    defaultData.deleteStack(event.id);
    stacks = await defaultData.getStacks();

    emit(CRUDStackSuccessActionState(cards.toList(), stacks.toList()));
  }

  _onDBData(CRUDDataFromDBEvent event, Emitter<CRUDStackState> emit) async {
    //print("CRUDStackBloc _onDBData event == $event");

    var localCards = await db.getAllCards();
    var localStacks = await db.getAllStacks();

    //print("CRUDStackBloc _onDBData localCards.length == ${localCards.length}");
    //print(
    //"CRUDStackBloc _onDBData localStacks.length == ${localStacks.length}");

    emit(
        CRUDStackSuccessActionState(localCards.toList(), localStacks.toList()));
  }

  _onFilter(CRUDStackFilterEvent event, Emitter<CRUDStackState> emit) async {
    //print(
    //"CRUDStackBloc _onFilter event.filterType == ${event.filterType}, event.filterString == ${event.filterString}");

    List<CardsStack> filteredStacks = [];
    List<AECard> filteredCards = [];

    if (event.filterType == "All") {
      filteredStacks = stacks;
    } else if (event.filterType == "Turn order") {
      for (var stack in stacks) {
        if (stack.stackType == StackType.turnOrder) {
          filteredStacks.add(stack);
        }
      }
    } else if (event.filterType == "Friends and Foes") {
      for (var stack in stacks) {
        if (stack.stackType == StackType.friend ||
            stack.stackType == StackType.foe) {
          filteredStacks.add(stack);
        }
      }
    } else if (event.filterType == "Friends") {
      for (var stack in stacks) {
        if (stack.stackType == StackType.friend) {
          filteredStacks.add(stack);
        }
      }
    } else if (event.filterType == "Foes") {
      for (var stack in stacks) {
        if (stack.stackType == StackType.foe) {
          filteredStacks.add(stack);
        }
      }
    } else if (event.filterType == "Other") {
      for (var stack in stacks) {
        if (stack.stackType == StackType.other) {
          filteredStacks.add(stack);
        }
      }
    }

    if (event.filterString.isNotEmpty) {
      if (filteredStacks.isNotEmpty) {
        filteredStacks = filteredStacks.where((stack) {
          return stack.name
              .toLowerCase()
              .contains(event.filterString.toLowerCase());
        }).toList();
      }
      for (var card in cards) {
        if (card.name
            .toLowerCase()
            .contains(event.filterString.toLowerCase())) {
          filteredCards.add(card);
        }
      }
    } else {
      filteredCards = cards;
    }
    // if (filteredStacks.isEmpty) {
    //   filteredStacks = stacks;
    // }

    //print(
    //"CRUDStackBloc _onFilter filteredStacks.length == ${filteredStacks.length}");

    emit(CRUDStackSuccessActionState(filteredCards.toList(),
        filteredStacks.toList(), event.filterType, event.filterString));
  }
}
