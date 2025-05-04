import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/bloc/event_state/root_body_es.dart';
import 'package:randomizer_new/bloc/root_body_bloc.dart';

import 'bloc/observer.dart';
import 'bloc/providers/provider_bloc.dart';
import 'view/loading_page.dart';
import 'view/root/root_page.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  void getState() async {
    runApp(
      BlocProvider(
        create: (context) => ProviderBloc(), 
        child: const MyApp()),
    );
  }
  //runApp(const MyApp());

  getState();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider(create: (_) => RootBodyBloc()..add(const RootBodyNextEvent()),
      child:
    MaterialApp(
      home: BlocBuilder<ProviderBloc, ProviderState>(
          builder: (_, state) {
          if (state is RootState) {
            return const RootPage();
          } else {
            
            return const LoadingPage();
          }
        })));
  }
}