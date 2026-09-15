import 'package:flutter/material.dart';

Widget dialogButton(String text, VoidCallback onPressed, BuildContext context,
    {String navigation = ""}) {
  return GestureDetector(
      child: Container(
        //height: 45,
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
      onTap: () {
        onPressed();
        Navigator.of(context).pop(navigation);
      });
}
