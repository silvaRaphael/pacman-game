// ignore_for_file: sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pacman/utils/barriers_pixel.dart';
import 'package:pacman/utils/food_pixel.dart';
import 'package:pacman/utils/ghost_pixel.dart';
import 'package:pacman/utils/player_month_open.dart';
import 'package:pacman/utils/player_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum player_Direction { RIGHT, LEFT, UP, DOWN }

class _HomePageState extends State<HomePage> {
  int rowSize = 11;
  int totalNumberOfSquares = 11 * 18;
  bool gameHasStarted = false;
  int playerScore = 0;
  bool playerMouthOpen = true;
  int playerStartPos = 170;
  int playerPos = 170;
  var playerDirection = player_Direction.RIGHT;
  bool gameIsOver = false;

  int ghostPosRedIndex = 0;
  int ghostPosOrangeIndex = 0;
  int ghostPosGreenIndex = 0;

  List<int> ghostPosRed = [
    103,
    92,
    92,
    93,
    82,
    71,
    70,
    69,
    68,
    79,
    90,
    101,
    112,
    123,
    134,
    145,
    146,
    157,
    168,
    179,
    178,
    177,
    166,
    155,
    144,
    145,
    134,
    123,
    112,
    101,
    90,
    79,
    68,
    69,
    70,
    71,
    82,
    93,
    94,
    105,
    104,
  ];

  List<int> ghostPosOrange = [
    104,
    93,
    82,
    71,
    72,
    73,
    74,
    85,
    96,
    107,
    118,
    129,
    140,
    151,
    150,
    149,
    148,
    147,
    146,
    145,
    134,
    123,
    124,
    125,
    126,
    127,
    128,
    129,
    118,
    107,
    96,
    85,
    74,
    73,
    72,
    71,
    82,
    93,
    94,
    105,
  ];

  List<int> ghostPosGreen = [
    105,
    94,
    94,
    94,
    82,
    71,
    72,
    73,
    74,
    85,
    96,
    107,
    118,
    129,
    140,
    151,
    152,
    163,
    174,
    185,
    184,
    183,
    172,
    161,
    150,
    151,
    140,
    129,
    118,
    107,
    96,
    85,
    74,
    73,
    72,
    71,
    82,
    93,
    94,
    105,
  ];

  List<int> food = [];

  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    88,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    187,
    188,
    189,
    190,
    191,
    192,
    193,
    194,
    195,
    196,
    197,
    21,
    32,
    43,
    54,
    65,
    76,
    87,
    98,
    109,
    120,
    131,
    142,
    153,
    164,
    175,
    186,
    169,
    158,
    159,
    160,
    171,
    137,
    136,
    138,
    135,
    139,
    162,
    173,
    141,
    133,
    156,
    167,
    91,
    102,
    113,
    114,
    115,
    116,
    117,
    106,
    95,
    84,
    80,
    78,
    111,
    86,
    119,
    81,
    83,
    58,
    59,
    60,
    61,
    62,
    64,
    56,
    24,
    35,
    30,
    41,
    37,
    38,
    39,
    26,
    28,
  ];

  void startGame() {
    gameIsOver = false;
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 180), (timer) {
      setState(() {
        movePlayer();
        eatFood();
        playerIsDead();
        playerHaveWon();
        playerMouthOpen = !playerMouthOpen;
      });
      if (gameIsOver) {
        timer.cancel();
      }
    });
    Timer.periodic(Duration(milliseconds: 180 * 3), (timer) {
      setState(() {
        ghostsMove();
      });
      if (gameIsOver) {
        timer.cancel();
      }
    });
  }

  void movePlayer() {
    switch (playerDirection) {
      case player_Direction.RIGHT:
        {
          if (!barriers.contains(playerPos + 1)) {
            playerPos += 1;
          }
        }
        break;
      case player_Direction.LEFT:
        {
          if (!barriers.contains(playerPos - 1)) {
            playerPos -= 1;
          }
        }
        break;
      case player_Direction.DOWN:
        {
          if (!barriers.contains(playerPos + rowSize)) {
            playerPos += rowSize;
          }
        }
        break;
      case player_Direction.UP:
        {
          if (!barriers.contains(playerPos - rowSize)) {
            playerPos -= rowSize;
          }
        }
        break;
    }
  }

  void eatFood() {
    if (!food.contains(playerPos) && playerPos != playerStartPos) {
      food.add(playerPos);
      playerScore += 1;
    }
  }

  void playerIsDead() {
    if (ghostPosRed[ghostPosRedIndex] == playerPos) {
      gameOver();
    }
    if (ghostPosOrange[ghostPosOrangeIndex] == playerPos) {
      gameOver();
    }
    if (ghostPosGreen[ghostPosGreenIndex] == playerPos) {
      gameOver();
    }
  }

  void resetGame() {
    setState(() {
      gameHasStarted = false;
      food = [];
      playerScore = 0;
      playerMouthOpen = true;
      playerPos = playerStartPos;
      playerDirection = player_Direction.RIGHT;

      ghostPosRedIndex = 0;
      ghostPosOrangeIndex = 0;
      ghostPosGreenIndex = 0;
    });
  }

  void ghostsMove() {
    if (ghostPosRed.length <= ghostPosRedIndex + 1) {
      ghostPosRedIndex = 0;
    } else {
      ghostPosRedIndex += 1;
    }
    if (ghostPosOrange.length <= ghostPosOrangeIndex + 1) {
      ghostPosOrangeIndex = 0;
    } else {
      ghostPosOrangeIndex += 1;
    }
    if (ghostPosGreen.length <= ghostPosGreenIndex + 1) {
      ghostPosGreenIndex = 0;
    } else {
      ghostPosGreenIndex += 1;
    }
  }

  void gameOver() {
    setState(() {
      gameIsOver = true;
    });
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Fim de jogo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sua pontuação é: ${playerScore.toString()}'),
              SizedBox(height: 10),
              MaterialButton(
                onPressed: () {
                  resetGame();
                  Navigator.pop(context);
                },
                child: const Text('Voltar'),
                color: Colors.red[400],
              ),
            ],
          ),
        );
      },
    );
  }

  void playerHaveWon() {
    if ((totalNumberOfSquares - barriers.length - 1) == playerScore) {
      setState(() {
        gameIsOver = true;
      });
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Você venceu!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sua pontuação é: ${playerScore.toString()}'),
                SizedBox(height: 10),
                MaterialButton(
                  onPressed: () {
                    resetGame();
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar'),
                  color: Colors.red[400],
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx < 0) {
                    playerDirection = player_Direction.LEFT;
                  } else if (details.delta.dx > 0) {
                    playerDirection = player_Direction.RIGHT;
                  }
                },
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy < 0) {
                    playerDirection = player_Direction.UP;
                  } else if (details.delta.dy > 0) {
                    playerDirection = player_Direction.DOWN;
                  }
                },
                child: GridView.builder(
                  itemCount: totalNumberOfSquares,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowSize,
                  ),
                  itemBuilder: (context, index) {
                    if (barriers.contains(index)) {
                      return const BarrierPixel();
                    } else if (index == playerPos) {
                      if (playerMouthOpen) {
                        switch (playerDirection) {
                          case player_Direction.RIGHT:
                            return const PlayerMonthOpen();
                          case player_Direction.LEFT:
                            return const RotatedBox(
                              quarterTurns: 2,
                              child: PlayerMonthOpen(),
                            );
                          case player_Direction.DOWN:
                            return const RotatedBox(
                              quarterTurns: 1,
                              child: PlayerMonthOpen(),
                            );

                          case player_Direction.UP:
                            return const RotatedBox(
                              quarterTurns: 3,
                              child: PlayerMonthOpen(),
                            );
                        }
                      } else {
                        return const PlayerPixel();
                      }
                    } else if (ghostPosRed[ghostPosRedIndex] == index) {
                      return GhostPixel(
                        ghost: 'lib/images/ghost-2.png',
                      );
                    } else if (ghostPosOrange[ghostPosOrangeIndex] == index) {
                      return GhostPixel(
                        ghost: 'lib/images/ghost-1.png',
                      );
                    } else if (ghostPosGreen[ghostPosGreenIndex] == index) {
                      return GhostPixel(
                        ghost: 'lib/images/ghost-3.png',
                      );
                    } else if (!food.contains(index) &&
                        index != playerStartPos) {
                      return const FoodPixel();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(1),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            color: Colors.blue[800],
                            // child: Text(
                            //   index.toString(),
                            //   style: const TextStyle(fontSize: 10),
                            // ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),

            // options
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        gameIsOver = true;
                      });
                      Timer(
                          const Duration(milliseconds: 500), () => resetGame());
                    },
                    child: Icon(
                      Icons.restart_alt,
                      size: 40,
                      color: Colors.red[400],
                    ),
                  ),
                  Text('Pontuação: ${playerScore.toString()}'),
                  MaterialButton(
                    onPressed: gameHasStarted ? () {} : startGame,
                    child: Text(
                      'J O G A R',
                      style: TextStyle(
                        fontSize: 22,
                        color: gameHasStarted ? Colors.grey[600] : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
