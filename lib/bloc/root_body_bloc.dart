import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/event_state/root_body_es.dart';
import '../database/cards_stack.dart';
import '../database/db_temporary.dart';

class RootBodyBloc extends Bloc<RootBodyEvent, RootBodyState> {
  List<CardsStack> stack = [];
  List<CardsStack> alredyPlayed = [];
  final _database = DbTemporary();
  
  RootBodyBloc() : super(const RootBodyState()) {
    on<RootBodyNextEvent>(_onNext);
    on<RootBodyDelWildEvent>(_onDelWild);
    on<RootBodyShuffleEvent>(_onShuffle);
    on<RootBodyChangeSequenceEvent>(_onChangeSequence);
  }

  void _onNext(RootBodyNextEvent event, Emitter<RootBodyState> emit) {
    // Handle the next event
    if(stack.isEmpty) {
      stack = _database.getActiveStack();
      if(alredyPlayed.isNotEmpty) {
        alredyPlayed.clear();
      }
      stack.shuffle;
      print("Stack is: $stack");
      emit(RootBodySuccessActionState(stack, alredyPlayed));
    } else {
      alredyPlayed.add(stack.last);
      print(stack.last);
      stack.removeLast();
      emit(RootBodySuccessActionState(stack, alredyPlayed));
    }
    
  }

  void _onDelWild(RootBodyDelWildEvent event, Emitter<RootBodyState> emit) {
    // Handle the delete wild event


    emit(RootBodySuccessActionState(stack, alredyPlayed));
  }

  void _onShuffle(RootBodyShuffleEvent event, Emitter<RootBodyState> emit) {
    // Handle the shuffle event


    emit(RootBodySuccessActionState(stack, alredyPlayed));
  }

  void _onChangeSequence(RootBodyChangeSequenceEvent event, Emitter<RootBodyState> emit) {
    // Handle the change sequence event


    emit(RootBodySuccessActionState(stack, alredyPlayed));
  }
}