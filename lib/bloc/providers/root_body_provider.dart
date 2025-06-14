import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:randomizer_new/database/cards_stack.dart';

// Events
class RootBodyProviderEvent extends Equatable {
  const RootBodyProviderEvent();

  @override
  List<Object> get props => [];
}

class RootBodyLoadingEvent extends RootBodyProviderEvent {}

class RootBodyTurnOrderEvent extends RootBodyProviderEvent {
  //final CardsStack stack;

  const RootBodyTurnOrderEvent(/*this.stack*/);

  @override 
  List<Object> get props => []; //[stack];
}

class RootBodyFriendFoeEvent extends RootBodyProviderEvent {
  // final HeroStack stack;
  
  // const RootBodyFriendFoeEvent(this.stack);
  
  // @override
  // List<Object> get props => [stack];
}



// States
class RootBodyProviderState extends Equatable {
  const RootBodyProviderState();

  @override
  List<Object> get props => [];
}

class RootBodyLoadingState extends RootBodyProviderState {}

class RootBodyTurnOrderState extends RootBodyProviderState {
  //final CardsStack stack;

  //const RootBodyTurnOrderState(this.stack);

  //@override 
  //List<Object> get props => [stack];
}

class RootBodyFriendFoeState extends RootBodyProviderState {
  // final HeroStack stack;

  // const RootBodyFriendFoeState(this.stack);

  // @override
  // List<Object> get props => [stack];
}

class RootBodyProviderBloc extends Bloc<RootBodyProviderEvent, RootBodyProviderState> {
  RootBodyProviderBloc() : super(RootBodyTurnOrderState(/*CardsStack.empty()*/)) {
    on<RootBodyLoadingEvent>((event, emit) => emit(RootBodyLoadingState()));
    on<RootBodyTurnOrderEvent>((event, emit) => emit(RootBodyTurnOrderState()));//(event.stack)));
    on<RootBodyFriendFoeEvent>((event, emit) => emit(RootBodyFriendFoeState(/*event.stack*/)));
  }
}