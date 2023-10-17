import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  final String direction;
  final bool midRun;
  final double size;

  const MyMario({
    Key? key,
    required this.direction,
    required this.midRun,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return SizedBox(
        width: size,
        height: size,
        child: midRun
            ? Image.asset("images/standingMario.png")
            : Image.asset("images/runningMario.png"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
          width: size,
          height: size,
          child: midRun
              ? Image.asset("images/standingMario.png")
              : Image.asset("images/runningMario.png"),
        ),
      );
    }
  }
}
