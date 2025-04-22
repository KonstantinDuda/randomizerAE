import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage();

  @override
  createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.rotate_right_outlined,
      size: 50.0,
      color: Colors.blue,
    );
  }
}
