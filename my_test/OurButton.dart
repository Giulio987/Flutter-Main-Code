import 'package:flutter/material.dart';

class OurButton extends StatelessWidget {
  OurButton(
      {Key key,
      @required this.text,
      @required this.textColor,
      @required this.backgroundColor,
      @required this.splashColor,
      @required this.onPressed})
      : super(key: key);
  final String text;
  final Color textColor, backgroundColor, splashColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: backgroundColor,
      splashColor: splashColor,
      padding: ButtonTheme.of(context).padding,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      shape: StadiumBorder(),
    );
  }
}
