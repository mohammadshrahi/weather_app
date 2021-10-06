import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/blocs/settings/bloc/settings_bloc.dart';
import 'package:weather_app/presentation/widgets/horizontal_space.dart';

class TemperatureWidget extends StatelessWidget {
  TemperatureWidget(this.text,
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
    bool isKavin =
        (BlocProvider.of<SettingsBloc>(context).state as SettingsSuccessState)
            .setting
            .isKalvin;

    if (isKavin)
      return KalvinText(
        text,
        degreeColor: degreeColor,
        style: style,
        spacing: spacing,
      );
    else
      return DegreeText(
        text,
        degreeColor: degreeColor,
        style: style,
        degreeSize: degreeSize,
        spacing: spacing,
      );
  }
}

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

class KalvinText extends StatelessWidget {
  KalvinText(this.text,
      {this.degreeColor = Colors.white, this.style, this.spacing = 2});
  String text;
  Color degreeColor;
  TextStyle? style;
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
        Text(
          'K',
          style: style,
        ),
      ],
    );
  }
}
