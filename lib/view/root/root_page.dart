import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomizer_new/view/root/root_app_bar.dart';
import 'package:randomizer_new/view/root/bodyes/turn_order.dart';

import '../../bloc/providers/root_body_provider.dart';
import 'bodyes/friend_foe_body.dart';
import 'bodyes/loading_root_body_page.dart';
import 'root_drawer.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  createState() => _RootPage();
}

class _RootPage extends State<RootPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: const RootDrawer(),
      body: BlocProvider(
        create: (context) => RootBodyProviderBloc(), 
        child:  
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //myAppBar(size),
            RootAppBar(_scaffoldKey),
            BlocBuilder<RootBodyProviderBloc, RootBodyProviderState>(
              builder: (_, state) {
              if (state is RootBodyLoadingState) {
                return const LoadingRootBodyPage();
              } else if(state is RootBodyTurnOrderState) {
                return const TurnOrderBody();
              } else if(state is RootBodyFriendFoeState) {
                return FriendFoeBody(/*state.stack*/);
              } else {
                return const LoadingRootBodyPage();
              }
            }
          ),
            //const TurnOrderBody(),
          ],
        ),
      ),
    );
  }

}
