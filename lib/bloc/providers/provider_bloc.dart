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


class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  ProviderBloc() : super(RootState()) {
    on<LoadingEvent>(_onLoad);
    on<RootEvent>((event, emit) => emit(RootState()));
    on<UpdateDeleteEvent>((event, emit) => emit(UpdateDeleteState()));
    on<CreateEvent>((event, emit) => emit(CreateState(event.id)));
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