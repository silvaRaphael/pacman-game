import 'package:flutter/material.dart';

class PlayerMonthOpen extends StatelessWidget {
  const PlayerMonthOpen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          color: Colors.blue[800],
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Image.asset('lib/images/pacman.png'),
          ),
        ),
      ),
    );
  }
}
