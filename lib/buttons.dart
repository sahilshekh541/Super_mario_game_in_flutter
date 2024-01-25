import 'package:flutter/material.dart';

class MarioButtons extends StatelessWidget {
  final Widget? child;
  final function;
  static bool holdingbutton = false;
  bool userIsHoldinbutton() {
    return holdingbutton;
  }

  const MarioButtons({super.key, this.function, this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        holdingbutton = true;
        function();
      },
      onTapUp: (details) {
        holdingbutton = false;
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }
}
