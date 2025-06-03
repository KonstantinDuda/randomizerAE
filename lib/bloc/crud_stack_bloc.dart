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

  _onNewCard(CRUDStackNewCardEvent event, Emitter<CRUDStackState> emit) {
    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onUpdateCard(
      CRUDStackUpdateCardEvent event, Emitter<CRUDStackState> emit) {
    print("CRUDStackBloc _onUpdateCard event.card.id == ${event.card.id}");

    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onDeleteCard(
      CRUDStackDeleteCardEvent event, Emitter<CRUDStackState> emit) {

print("CRUDStackBloc delete card.id == ${event.id}");
    
    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onNewStack(CRUDStackNewStackEvent event, Emitter<CRUDStackState> emit) {
    emit(CRUDStackSuccessActionState(cards, stacks));
  }

  _onUpdateStack(
      CRUDStackUpdateStackEvent event, Emitter<CRUDStackState> emit) async {
    print("CRUDStackBloc _onUpdateStack event.stack == ${event.stack}");

    var stackFromDB = await db.getStackById(event.stack.id);
    if(stackFromDB.id == event.stack.id) {
      print("CRUDStackBloc _onUpdateStack stackFromDB.id == event.stack.id");
      
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
