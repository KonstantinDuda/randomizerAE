import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final Size size;
  final Color bodyColor;
  final double borderWidth;
  final Color borderColor;
  final EdgeInsetsGeometry margin;

  const MyCard(this.child, this.size,
      {this.bodyColor = Colors.white,
      this.borderColor = Colors.black,
      this.borderWidth = 2,
      this.margin = const EdgeInsets.all(5),
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      margin: margin,
      decoration: BoxDecoration(
        color: bodyColor, //stackColor,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
