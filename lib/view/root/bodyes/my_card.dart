import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../database/cards_stack.dart';

class MyCard extends StatelessWidget {
  final AECard card;
  final Size size;
  final Color bodyColor;
  final double borderWidth;
  final Color borderColor;
  final EdgeInsetsGeometry margin;

  const MyCard(this.card, this.size,
      {this.bodyColor = Colors.white,
      this.borderColor = Colors.black,
      this.borderWidth = 2,
      this.margin = const EdgeInsets.all(5),
      super.key});

  @override
  Widget build(BuildContext context) {
    String name = card.name == "" ? "" : '<h1>${card.name}</h1>';
    String text = card.text == "" ? name : "${card.name}: ${card.text}";
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
      child: Center(
          child: Html(data: text, style: {
        "body": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize(20),
        ),
        "h1": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize(30),
        ),
      })),
    );
  }
}
