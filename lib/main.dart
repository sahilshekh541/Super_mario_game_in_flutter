import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marioagameapp/Jumpingmario.dart';
import 'package:marioagameapp/Mushrooms.dart';
import 'package:marioagameapp/MyMario.dart';
import 'package:marioagameapp/buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double mariox = 0;
  double marioy = 1;
  double mushroomx = 0.5;
  double mushroomy = 1;
  double mariosize = 50;
  bool midrun = false;
  String direction = '';
  double time = 0;
  double height = 0;
  late double initialheight = marioy;
  bool midjump = false;

  var gamefonts = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, fontSize: 18));
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.initState();
  }

  checkIfatMushroom() {
    if ((mariox - mushroomx).abs() < 0.05 &&
        (marioy - mushroomy).abs() < 0.05) {
      setState(() {
        mushroomy = 2;
        mariosize = 100;
      });
    }
  }

  prejump() {
    time = 0;
    initialheight = marioy;
  }

  void jump() {
    if (!midjump) {
      midjump = true;
      prejump();
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialheight - height > 1) {
          midjump = false;
          timer.cancel();
          setState(() {
            marioy = 1;
          });
        } else {
          setState(() {
            marioy = initialheight - height;
          });
        }
      });
    }
  }

  rightsiderun() {
    direction = 'right';
    checkIfatMushroom();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      checkIfatMushroom();
      if (const MarioButtons().userIsHoldinbutton() == true &&
          (mariox + 0.02) < 1) {
        setState(() {
          mariox += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  leftsiderun() {
    direction = 'left';
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (const MarioButtons().userIsHoldinbutton() == true &&
          (mariox - 0.02) > -1) {
        setState(() {
          mariox -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.blue,
                      child: AnimatedContainer(
                        alignment: Alignment(mariox, marioy),
                        duration: const Duration(milliseconds: 0),
                        child: midjump
                            ? JumpingMario(
                                size: mariosize,
                                direction: direction,
                              )
                            : MyMario(
                                size: mariosize,
                                direction: direction,
                                midrun: midrun,
                              ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(mushroomx, mushroomy),
                      child: Mushroom(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "MARIO",
                                style: gamefonts,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("0000", style: gamefonts),
                            ],
                          ),
                          Column(
                            children: [
                              Text("SCORE", style: gamefonts),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("1-1", style: gamefonts),
                            ],
                          ),
                          Column(
                            children: [
                              Text("TIME", style: gamefonts),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("9999", style: gamefonts),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MarioButtons(
                          function: leftsiderun,
                          child: const Icon(
                            Icons.arrow_back,
                            size: 26,
                            color: Colors.white,
                          )),
                      MarioButtons(
                          function: jump,
                          child: const Icon(
                            Icons.arrow_upward_sharp,
                            size: 26,
                            color: Colors.white,
                          )),
                      MarioButtons(
                          function: rightsiderun,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 26,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
