import 'dart:math';

import 'package:flutter/material.dart';

class JumpingMario extends StatelessWidget {
  final String direction;
  final double size;
  const JumpingMario({super.key, required this.direction, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        child: direction == 'left'
            ? Transform(
                transform: Matrix4.rotationY(pi),
                alignment: Alignment.center,
                child: Image.asset('assets/images/MarioJump.png'),
              )
            : Image.asset('assets/images/MarioJump.png'));
  }
}
