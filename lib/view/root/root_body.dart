import 'package:flutter/material.dart';

class RootBody extends StatefulWidget {
  const RootBody({super.key});

  @override
  State<RootBody> createState() => _RootBodyState();
}

class _RootBodyState extends State<RootBody> {

  @override
  Widget build(BuildContext context) {
    final Size bodyContainerSize = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height - 104.5,
    );

    return Container(
      color: Colors.blue,
      height: bodyContainerSize.height,
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Column( 
      children: <Widget>[
        ColoredBox(
          color: Colors.blue,
          child: Row(
              children: <Widget>[
                const Expanded(
                  child: Center(
                    child: Text('Stack name', 
                      style: TextStyle(fontSize: 30), ))
                  ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: const Center(
                    child: Text('stack color', 
                        style: TextStyle(fontSize: 15)
                    ),
                  ),
                ),
              ],
            ),
        ),
        GestureDetector(
          child: Container(
            height: bodyContainerSize.height - 75,
            width: bodyContainerSize.width - 20,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onTap: () {
            // Handle tap event
            print("Tapped on the container");
          },
        )
      ],
    ),
    );
  }
}