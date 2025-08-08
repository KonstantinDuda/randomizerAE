import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
class ProviderEvent extends Equatable {
  const ProviderEvent();

  @override
  List<Object> get props => [];
}

class LoadingEvent extends ProviderEvent {}

class RootEvent extends ProviderEvent {}

class UpdateDeleteEvent extends ProviderEvent {}

class CreateEvent extends ProviderEvent {
  final int id;

  const CreateEvent(this.id);
}

class HistoryProviderEvent extends ProviderEvent {}

class HeroListEvent extends ProviderEvent {}

class HeroCreateEvent extends ProviderEvent {}


// States
class ProviderState extends Equatable {
  const ProviderState();

  @override
  List<Object> get props => [];
}

class LoadingState extends ProviderState {}

class RootState extends ProviderState {}

class UpdateDeleteState extends ProviderState {}

class CreateState extends ProviderState {
  final int id;

  const CreateState(this.id);
}

class HistoryProviderState extends ProviderState {}

class HeroListState extends ProviderState {}

class HeroCreateState extends ProviderState {}


class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  ProviderBloc() : super(RootState()) {
    on<LoadingEvent>(_onLoad);
    on<RootEvent>((event, emit) => emit(RootState()));
    on<UpdateDeleteEvent>((event, emit) => emit(UpdateDeleteState()));
    on<CreateEvent>((event, emit) => emit(CreateState(event.id)));
    on<HistoryProviderEvent>((event, emit) => emit(HistoryProviderState()));
    on<HeroListEvent>((event, emit) => emit(HeroListState()));
    on<HeroCreateEvent>((event, emit) => emit(HeroCreateState()));
  }

  _onLoad(LoadingEvent event, Emitter<ProviderState> emit) {
    print("ProviderBloc _onLoad");
    try {
    emit(LoadingState());  
    } catch (e) {
      print("Error in ProviderBloc _onLoad: $e");
    }
    
  }
}