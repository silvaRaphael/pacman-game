import 'package:flutter/material.dart';

class PlayerPixel extends StatelessWidget {
  const PlayerPixel({Key? key}) : super(key: key);

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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.yellow[600],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
