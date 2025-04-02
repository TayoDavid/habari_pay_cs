import 'package:flutter/material.dart';

class Loader {
  static bool showing = false;
  static void show(BuildContext context) {
    showing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext context) => Center(
        child: Container(
          width: 60.0,
          height: 60.0,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: InlineLoader(),
        ),
      ),
    );
  }

  static void dismiss(BuildContext context) {
    if (showing) {
      Navigator.of(context).pop();
    }
  }
}

class InlineLoader extends StatelessWidget {
  final double size;
  final Color strokeColor;

  const InlineLoader({
    super.key,
    this.size = 24,
    this.strokeColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 1.5,
        valueColor: AlwaysStoppedAnimation<Color?>(strokeColor),
      ),
    );
  }
}
