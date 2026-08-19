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
      this.margin = const EdgeInsets.all(3),
      super.key});

  @override
  Widget build(BuildContext context) {
    String textToHtml() {
      String name = card.name == "" ? "" : '<h1>${card.name}</h1>';
      // String text = card.text == ""
      //     ? name
      //     : "<h3>${card.name}</h3> <body>${card.text}</body>";
      String text = "<body>${card.text}</body>";

      var regOr = RegExp(r'\b(OR)\b',
          caseSensitive: true); // \b — це межа слова (word boundary)
      text = text.replaceAllMapped(regOr, (match) {
        final foundWorld = match.group(0); // Зберігає оригінальний регістр
        return '<h5>$foundWorld</h5>';
      });

      var regPlayer = RegExp(r'\b(player|players)\b', caseSensitive: false);
      text = text.replaceAllMapped(regPlayer, (match) {
        final foundWorld = match.group(0);
        return '<span class="player">$foundWorld</span>';
      });
      var regLife = RegExp(r'\b(\d)\s+(life)\b', caseSensitive: false);
      text = text.replaceAllMapped(regLife, (match) {
        final number = match.group(1);
        final target = match.group(2);
        return '<span class="life">$number $target</span>';
      });

      var regEnergy = RegExp(
          r'\b(\d)\s+(charges|charge)\b'); // \d+ означає будь-яке число (1, 2, 10 тощо)
      text = text.replaceAllMapped(regEnergy, (match) {
        final number = match.group(1);
        final target = match.group(2);
        return '<span class="energy">$number $target</span>';
      });
      var regMoney = RegExp(r'\b(\d)\s+(money)\b');
      text = text.replaceAllMapped(regMoney, (match) {
        final number = match.group(1);
        final target = match.group(2);
        return '<span class="money">$number $target</span>';
      });
      var regDamage = RegExp(r'\b(\d)\s+(damage)\b', caseSensitive: false);
      text = text.replaceAllMapped(regDamage, (match) {
        final number = match.group(1);
        final target = match.group(2);
        return '<span class="damage">$number $target</span>';
      });

      var regNemesis = RegExp(r'\b(nemesis)\b', caseSensitive: false);
      text = text.replaceAllMapped(regNemesis, (match) {
        final foundWorld = match.group(0);
        return '<span class="nemesis">$foundWorld</span>';
      });
      var regUnleash = RegExp(r'\b(unleash)\b', caseSensitive: false);
      text = text.replaceAllMapped(regUnleash, (match) {
        final foundWorld = match.group(0);
        return '<span class="unleash">$foundWorld</span>';
      });

      text =
          card.text == "" ? name : "<h3>${card.name}</h3> <body>$text</body>";

      return text;
    }

    double hFontSize = size.height > 250 ? 30 : 20;
    double bodyFontSize = size.height > 250 ? 18 : 12;
    String text = textToHtml();

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
          fontSize: FontSize(bodyFontSize), // FontSize(18),
        ),
        "h1": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize(hFontSize), //FontSize(30),
        ),
        "h5": Style(margin: Margins.only(top: 5, bottom: 5)),
        "span.player": Style(
          color: const Color.fromARGB(255, 3, 192, 60),
          fontWeight: FontWeight.bold,
        ),
        "span.life": Style(
          color: const Color.fromARGB(255, 3, 192, 60),
          fontWeight: FontWeight.bold,
        ),
        "span.energy": Style(
          color: const Color.fromARGB(
              255, 2, 71, 254), // const Color.fromARGB(255, 0, 191, 255),
          fontWeight: FontWeight.bold,
        ),
        "span.money": Style(
          color: const Color.fromARGB(255, 255, 126, 0),
          fontWeight: FontWeight.bold,
        ),
        "span.damage": Style(
          color: const Color.fromARGB(255, 255, 0, 0),
          fontWeight: FontWeight.bold,
        ),
        "span.nemesis": Style(
          color: const Color.fromARGB(255, 255, 0, 0),
          fontWeight: FontWeight.bold,
        ),
        "span.unleash": Style(
          color: const Color.fromARGB(255, 255, 0, 0),
          fontWeight: FontWeight.bold,
        ),
      })),
    );
  }
}
