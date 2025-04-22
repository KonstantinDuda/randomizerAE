import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/observer.dart';
import 'bloc/provider_bloc.dart';
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
    return MaterialApp(
      home: BlocBuilder<ProviderBloc, ProviderState>(
          builder: (_, state) {
          if (state is LoadingState) {
            return const LoadingPage();
          } else {
            return const RootPage();
          }
        }));
  }
}
