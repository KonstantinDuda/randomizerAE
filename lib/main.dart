import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/crud_stack_bloc.dart';
import 'bloc/event_state/crud_stack_es.dart';
import 'bloc/event_state/turn_order_body_es.dart';
import 'bloc/history_bloc.dart';
import 'bloc/turn_order_body_bloc.dart';
import 'bloc/event_state/friend_foe_body_es.dart';
import 'bloc/friend_foe_body_bloc.dart';
import 'bloc/observer.dart';
import 'bloc/providers/provider_bloc.dart';
import 'database/default_data.dart';
import 'view/create/create_stack_page.dart';
import 'view/create/update_delete_stack_page.dart';
import 'view/loading_page.dart';
import 'view/root/root_page.dart';
import 'view/history_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var defaultData = DefaultData();
  defaultData.createDefaultData();
  
  Bloc.observer = SimpleBlocObserver();
  
  runApp(
    BlocProvider(create: (context) => ProviderBloc(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        MultiBlocProvider(
      providers: [
        BlocProvider<TurnOrderBodyBloc>(
          create: (_) => TurnOrderBodyBloc()..add(TurnOrderInitialEvent()),
        ),
        BlocProvider<FriendFoeBodyBloc>(
          create: (_) =>
              FriendFoeBodyBloc()..add(const FriendFoeBodyInitialEvent(0)),
        ),
        BlocProvider<CRUDStackBloc>(
          create: (_) => CRUDStackBloc()..add(CRUDStackInitialEvent()),
        ),
        BlocProvider<HistoryBloc>(
          create: (_) => HistoryBloc(),
        ),
      ],
      child: MaterialApp(
        home: BlocBuilder<ProviderBloc, ProviderState>(
          builder: (_, state) {
            if (state is RootState) {
              return const RootPage();
            } else if (state is UpdateDeleteState) {
              return const UpdateDeleteStackPage();
            } else if (state is CreateState) {
              return CreateStackPage(state.id);
            } else if(state is HistoryProviderState) {
              return const HistoryPage();
            } else {
              return const LoadingPage();
            }
          },
        ),
      ),
    );
  }
}
