import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_super_mario_tutorial/button.dart';
import 'package:simple_super_mario_tutorial/jumping_mario.dart';
import 'package:simple_super_mario_tutorial/mario.dart';
import 'package:simple_super_mario_tutorial/shrooms.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1.03;
  double marioSize = 60;
  double shroomX = 0.5;
  double shroomY = 1.03;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midRun = false;
  bool midJump = false;
  var gameFont = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  );
  static double blockX = -0.3;
  static double blockY = 0.3;
  double moneyX = blockX;
  double moneyY = blockY;
  int money = 0;

  void checkIfAteShrooms() {
    if ((marioX - shroomX).abs() < 0.05 && (marioY - shroomY).abs() < 0.05) {
      setState(() {
        // if eaten, move the shroom off the screen
        shroomX = 2;
        marioSize = 120;
        marioY = 1.07;
      });
    }
  }

  // SHOW ME THE MONEY
  void releaseMoney() {
    money++;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        moneyY -= 0.1;
      });
      if (moneyY < -1) {
        timer.cancel();
        moneyY = blockY;
      }
    });
  }

  // FALL OFF THE PLATFORM
  void fall() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        marioY += 0.05;
      });
      if (marioY > 1) {
        marioY = 1;
        timer.cancel();
        midJump = false;
      }
    });
  }

  // CHECK IF MARIO IS ON THE PLATFORM
  bool onPlatform(double x, double y) {
    if ((x - blockX).abs() < 0.05 && (y - blockY).abs() < 0.3) {
      midJump = false;
      marioY = blockY - 0.28;
      return true;
    } else {
      return false;
    }
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    // this first if statement disables the double jump
    if (midJump == false) {
      midJump = true;
      preJump();
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;
        if (initialHeight - height > 1) {
          midJump = false;
          setState(() {
            marioY = 1.03;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = "right";
    checkIfAteShrooms();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      checkIfAteShrooms();
      if (const MyButton().userIsHoldingButton() == true &&
          (marioX + 0.02) < 1) {
        setState(() {
          marioX += 0.02;
          midRun = !midRun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = "left";
    checkIfAteShrooms();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      checkIfAteShrooms();
      if (const MyButton().userIsHoldingButton() == true &&
          (marioX - 0.02) > -1) {
        setState(() {
          marioX -= 0.02;
          midRun = !midRun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    color: Colors.blue,
                    child: AnimatedContainer(
                      alignment: Alignment(marioX, marioY),
                      duration: const Duration(milliseconds: 0),
                      child: midJump
                          ? JumpingMario(
                              direction: direction,
                              size: marioSize,
                            )
                          : MyMario(
                              direction: direction,
                              midRun: midRun,
                              size: marioSize,
                            ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(shroomX, shroomY),
                    child: const MyShroom(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "MARIO",
                              style: gameFont,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "0000",
                              style: gameFont,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "WORLD",
                              style: gameFont,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "1-1",
                              style: gameFont,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "TIME",
                              style: gameFont,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "9999",
                              style: gameFont,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(
                      function: moveLeft,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    MyButton(
                      function: jump,
                      child: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
                    ),
                    MyButton(
                      function: moveRight,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
