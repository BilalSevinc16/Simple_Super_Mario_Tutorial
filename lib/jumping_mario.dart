import 'dart:math';

import 'package:flutter/material.dart';

class JumpingMario extends StatelessWidget {
  final String direction;
  final double size;

  const JumpingMario({
    Key? key,
    required this.direction,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return SizedBox(
        width: size,
        height: size,
        child: Image.asset("images/jumpingMario.png"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: SizedBox(
          width: size,
          height: size,
          child: Image.asset("images/jumpingMario.png"),
        ),
      );
    }
  }
}
