import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Description extends StatelessWidget {
  final String text;
  const Description(this.text, {super.key});

  _textToHtml() {
    String newText = text;
    // var rules = RegExp(r'\b(rules)\b', caseSensitive: false);
    // newText = newText.replaceAllMapped(rules, (match) {
    //   final rule = match.group(0);
    //   return '<b>$rule</b>';
    // });
    var nextRuls = RegExp(r'(^|\.[\s]*)+([^.:]+:)');
    newText = newText.replaceAllMapped(nextRuls, (match) {
      final dotAndSpace = match.group(1) ?? "";
      final rule = match.group(2)!.trim();
      final prefix = dotAndSpace.contains('.') ? '.<br>' : '';
      return '$prefix<span class="nextR">$rule</span>';
    });
    return newText;
  }

  @override
  Widget build(BuildContext context) {
    var data = _textToHtml();
    return Center(
        child: Html(
      data: data,
      style: {
        //"b": Style(fontSize: FontSize(16), fontWeight: FontWeight.bold),
        "span.nextR":
            Style(fontSize: FontSize(16), fontWeight: FontWeight.bold),
      },
    ));
  }
}
