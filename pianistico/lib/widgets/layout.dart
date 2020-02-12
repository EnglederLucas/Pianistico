import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {

  TextDivider({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          Expanded(
              child: Divider()
          ),

          Text(text),

          Expanded(
              child: Divider()
          ),
        ]
    );
  }
}
