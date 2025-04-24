import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/event_state/root_body_es.dart';
import '../database/cards_stack.dart';
import '../database/db_temporary.dart';

class RootBodyBloc extends Bloc<RootBodyEvent, RootBodyState> {
  late CardsStack stack = const CardsStack.empty();
  late CardsStack alreadyPlayed = const CardsStack.empty();
  final _database = DbTemporary();
  
  RootBodyBloc() : super(const RootBodySuccessActionState()) {
    on<RootBodyNextEvent>(_onNext);
    on<RootBodyDelWildEvent>(_onDelWild);
    on<RootBodyShuffleEvent>(_onShuffle);
    on<RootBodyChangeSequenceEvent>(_onChangeSequence);
  }

  void _onNext(RootBodyNextEvent event, Emitter<RootBodyState> emit) {
    // Handle the next event
    if(stack.id == 0) {
      stack = _database.getActiveStack();
      if(alreadyPlayed.id != 0) {
        alreadyPlayed = const CardsStack.empty();
      }
      stack.cards.shuffle();
      print("RootBodyBloc _onNext stack.id == 0 stack == $stack");
      emit(RootBodySuccessActionState(stack, alreadyPlayed));
    } else {
      alreadyPlayed = stack;
      alreadyPlayed.cards.clear();
      alreadyPlayed.cards.add(stack.cards.last);

      stack.cards.removeLast();

      print("RootBodyBloc _onNext stack == $stack");
      emit(RootBodySuccessActionState(stack, alreadyPlayed));
    }
    
  }

  void _onDelWild(RootBodyDelWildEvent event, Emitter<RootBodyState> emit) {
    // Handle the delete wild event


    emit(RootBodySuccessActionState(stack, alreadyPlayed));
  }

  void _onShuffle(RootBodyShuffleEvent event, Emitter<RootBodyState> emit) {
    // Handle the shuffle event
    if(stack.cards.isEmpty) {
      stack = _database.getActiveStack();
      stack.cards.shuffle();
    emit(RootBodySuccessActionState(stack, alreadyPlayed));
  }
  }

  void _onChangeSequence(RootBodyChangeSequenceEvent event, Emitter<RootBodyState> emit) {
    // Handle the change sequence event


    emit(RootBodySuccessActionState(stack, alreadyPlayed));
  }
}