import 'package:flutter/material.dart';
import 'package:randomizer_new/view/root/root_app_bar.dart';
import 'package:randomizer_new/view/root/root_body.dart';

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
      drawer: RootDrawer(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //myAppBar(size),
            RootAppBar(_scaffoldKey),
            const RootBody(),
          ],
        ),
    );
  }

}


