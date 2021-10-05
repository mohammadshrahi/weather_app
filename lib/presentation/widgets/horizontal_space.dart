import 'package:flutter/material.dart';

///use this Widget to have horizontal space between two widgets in Row
class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace(this.spaceSize, {Key? key}) : super(key: key);
  final double spaceSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: spaceSize,
    );
  }
}
