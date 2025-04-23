import 'package:flutter/material.dart';

import '../../database/cards_stack.dart';
import '../../database/db_temporary.dart';

class RootAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  const RootAppBar(this._scaffoldKey, {super.key});

  @override
  State<RootAppBar> createState() => _RootAppBarState();
}

class _RootAppBarState extends State<RootAppBar> {
  DbTemporary dbObj = DbTemporary();
  late List<CardsStack> db;
  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = dbObj.getAvialableStacks();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: Colors.blue,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text( 'Aeons End Randomizer' ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Stack(
                    children: [
                      const Icon(Icons.circle_outlined),
                      Container(
                        margin: const EdgeInsets.fromLTRB(4, 3, 0, 0),
                        child: const Icon(Icons.question_mark, size: 16),
                        ),
                    ]
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Stack(
                    children: [
                      Container(
                        width: 70,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          )
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Icon(Icons.arrow_right, size: 50),
                        ),
                    ],
                  ),
                  onTap: () {
                    widget._scaffoldKey.currentState?.openDrawer();
                  },
                ),
                SizedBox(
                  width: size.width - 80,
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: db.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        width: 20,
                        height: 40,
                        decoration: BoxDecoration(
                          color: db[index].stackColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}