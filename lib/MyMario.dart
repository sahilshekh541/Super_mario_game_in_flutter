import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatefulWidget {
  final String direction;
  final double size;
  final bool midrun;
  const MyMario(
      {super.key,
      required this.direction,
      required this.midrun,
      required this.size});

  @override
  State<MyMario> createState() => _MyMarioState();
}

class _MyMarioState extends State<MyMario> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.size,
        width: widget.size,
        child: widget.direction == 'left'
            ? Transform(
                transform: Matrix4.rotationY(pi),
                alignment: Alignment.center,
                child: widget.midrun
                    ? Image.asset('assets/images/MarioRun.png')
                    : Image.asset('assets/images/MarioIdle.png'),
              )
            : widget.midrun
                ? Image.asset('assets/images/MarioRun.png')
                : Image.asset('assets/images/MarioIdle.png'));
  }
}
