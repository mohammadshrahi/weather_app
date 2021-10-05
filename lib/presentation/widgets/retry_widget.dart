import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget(
    this.message, {
    @required this.onPressed,
    Key? key,
  }) : super(key: key);
  final Function? onPressed;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            onPressed?.call();
          },
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
