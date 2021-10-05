import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/horizontal_space.dart';

class DegreeText extends StatelessWidget {
  DegreeText(this.text,
      {this.degreeColor = Colors.white,
      this.style,
      this.degreeSize = 5,
      this.spacing = 2});
  String text;
  Color degreeColor;
  TextStyle? style;
  double degreeSize;
  double spacing;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: style,
        ),
        HorizontalSpace(spacing),
        Container(
          width: degreeSize,
          height: degreeSize,
          decoration: BoxDecoration(
              border: Border.all(color: degreeColor, width: 1),
              shape: BoxShape.circle),
        )
      ],
    );
  }
}
