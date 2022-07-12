import 'package:flutter/material.dart';

class BarrierPixel extends StatelessWidget {
  const BarrierPixel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
