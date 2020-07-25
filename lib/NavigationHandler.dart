import 'package:flutter/material.dart';

class NavigationHandler extends StatelessWidget {
  final Color color;


  NavigationHandler(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}