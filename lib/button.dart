import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? function;
  static bool holdingButton = false;

  const MyButton({
    Key? key,
    this.child,
    this.function,
  }) : super(key: key);

  bool userIsHoldingButton() {
    return holdingButton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        holdingButton = true;
        function!();
      },
      onTapUp: (details) {
        holdingButton = false;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.brown.shade300,
          child: child,
        ),
      ),
    );
  }
}
