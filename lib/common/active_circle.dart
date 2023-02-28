import 'package:flutter/material.dart';

class ActiveCircle extends StatelessWidget {
  final double? size;
  final Color? color;
  const ActiveCircle({this.size, this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 10,
      height: size ?? 10,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.white),
        color: color ?? Colors.green,
        shape: BoxShape.circle,
      ),
    );
  }
}
