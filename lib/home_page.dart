import 'package:flutter/material.dart';
import 'dart:math';

class OrbitAnimation extends StatefulWidget {
  const OrbitAnimation({super.key});

  @override
  State<OrbitAnimation> createState() => _OrbitAnimationState();
}

class _OrbitAnimationState extends State<OrbitAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 5), upperBound: 2 * pi);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: InteractiveViewer(
          maxScale: 10,
          child: CustomPaint(
            painter: OrbitPainter(_animationController),
            child: Container(),
          ),
        ));
  }
}

class OrbitPainter extends CustomPainter {
  final Animation<double> animation;

  OrbitPainter(this.animation);
  @override
  void paint(Canvas canvas, Size size) {
    final sunPaint = Paint()..color = Colors.yellowAccent;
    final planetPaint = Paint()..color = Colors.orange;
    final satelitePaint = Paint()..color = Colors.grey;

    final orbitPaint2 = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke;

    final orbitPaint1 = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke;

    final planetPaint1 = Paint()..color = Colors.blue;

    const o1 = 165.0;
    const o2 = 300.0;
    const o3 = 51.0;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), (65), sunPaint);

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), o1, orbitPaint2);

    canvas.drawCircle(
        Offset(size.width / 2 + o1 * cos(animation.value * 2),
            size.height / 2 + o1 * sin(animation.value * 2)),
        15,
        planetPaint);

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), o2, orbitPaint1);

    canvas.drawCircle(
        Offset(size.width / 2 + o2 * cos(animation.value),
            size.height / 2 + o2 * sin(animation.value)),
        35,
        planetPaint1);

    final moonX = size.width / 2 +
        o2 * cos(animation.value) +
        o3 * cos(animation.value * 6);
    final moonY = size.height / 2 +
        o2 * sin(animation.value) +
        o3 * sin(animation.value * 6);

    canvas.drawCircle(Offset(moonX, moonY), 8, satelitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
