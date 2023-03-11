import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class ProviderEvent extends Equatable {
  const ProviderEvent();

  @override
  List<Object> get props => [];
}

class RootEvent extends ProviderEvent {}

class AddEvent extends ProviderEvent {}

class DialogEvent extends ProviderEvent {
  final Set<int> list;
  const DialogEvent(this.list);

  @override
  List<Object> get props => [list];
}

class ProviderState extends Equatable {
  const ProviderState();

  @override
  List<Object> get props => [];
}

class RootState extends ProviderState {}

class AddState extends ProviderState {}

class DialogState extends ProviderState {
  final Set<int> list;
  const DialogState(this.list);

  @override
  List<Object> get props => [list];
}

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  ProviderBloc() : super(RootState()) {
    on<RootEvent>((event, emit) => emit(RootState()));
    on<AddEvent>((event, emit) => emit(AddState()));
    on<DialogEvent>(((event, emit) => emit(DialogState(event.list))));
  }
}
