import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/event_state/create_stack_es.dart';
import '../database/cards_stack.dart';
import '../database/db_provider.dart';

//import '../database/db_temporary.dart';

class CreateStackBloc extends Bloc<CreateStackEvent, CreateStackState> {
  //final database = DbTemporary();
  final db = DBProvider();

  List<AECard> cards = [];
  List<CardsStack> stacks = [];
  

  CreateStackBloc() : super(const CreateStackSuccessActionState()) {
    on<CreateStackInitialEvent>(_onInit);
    on<CreateStackNewCardEvent>(_onNewCard);
    on<CreateStackUpdateCardEvent>(_onUpdateCard);
    on<CreateStackDeleteCardEvent>(_onDeleteCard);
    on<CreateStackNewStackEvent>(_onNewStack);
    on<CreateStackUpdateStackEvent>(_onUpdateStack);
    on<CreateStackDeleteStackEvent>(_onDeleteStack);
  }

  _onInit(CreateStackInitialEvent event, Emitter<CreateStackState> emit) async {
    cards = await db.getAllCards();
    stacks = await db.getAllStacks();

    print("CreateStackBlock _onInit stacks.length == ${stacks.length}");

    emit(CreateStackSuccessActionState(cards, stacks));
  }

  _onNewCard(CreateStackNewCardEvent event, Emitter<CreateStackState> emit) {

 emit(CreateStackSuccessActionState(cards, stacks));
  }

  _onUpdateCard(CreateStackUpdateCardEvent event, Emitter<CreateStackState> emit) {
    print("CreateStackBloc _onUpdateCard event.card.id == ${event.card.id}");

 emit(CreateStackSuccessActionState(cards, stacks));
  }

  _onDeleteCard(CreateStackDeleteCardEvent event, Emitter<CreateStackState> emit) {

 emit(CreateStackSuccessActionState(cards, stacks));
  }

  _onNewStack(CreateStackNewStackEvent event, Emitter<CreateStackState> emit) {

 emit(CreateStackSuccessActionState(cards, stacks));
  }

  _onUpdateStack(CreateStackUpdateStackEvent event, Emitter<CreateStackState> emit) {

 emit(CreateStackSuccessActionState(cards, stacks));
  }

  _onDeleteStack(CreateStackDeleteStackEvent event, Emitter<CreateStackState> emit) {

 emit(CreateStackSuccessActionState(cards, stacks));
  }

}