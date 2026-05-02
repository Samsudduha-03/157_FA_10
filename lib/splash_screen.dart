import 'dart:math';
import 'package:flutter/material.dart';
import 'welcome_back_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeBackScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _bg(),
          _blotch(200, 180, 80, -30, Colors.white12),
          _blotch(
              220, 200, size.height - 300, size.width - 200, Colors.white24),
          _blotch(180, 160, 350, 80, Colors.white10),
          _waves(size, left: true),
          _waves(size, left: false),
          ..._dots(size, 40, Rect.fromLTWH(60, 20, size.width - 60, 200), 42),
          ..._dots(size, 45,
              Rect.fromLTWH(0, size.height * .75, size.width, 200), 99),
        ],
      ),
    );
  }

  Widget _bg() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB8B0F0), Color(0xFF9B8FE8), Color(0xFFAFA8EE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );

  Widget _blotch(w, h, top, left, color) => Positioned(
        top: top,
        left: left,
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(w * .4),
          ),
        ),
      );

  Widget _waves(Size size, {required bool left}) => Positioned(
        left: left ? -10 : null,
        right: left ? null : -10,
        top: size.height * (left ? .35 : .30),
        child: Transform(
          transform: Matrix4.identity()..scale(left ? 1.0 : -1.0, 1.0),
          alignment: Alignment.center,
          child: CustomPaint(
            size: const Size(160, 260),
            painter: _WavePainter(),
          ),
        ),
      );

  List<Widget> _dots(Size size, int count, Rect area, int seed) {
    final rand = Random(seed);
    return List.generate(count, (_) {
      return Positioned(
        left: area.left + rand.nextDouble() * area.width,
        top: area.top + rand.nextDouble() * area.height,
        child: Container(
          width: rand.nextDouble() * 8 + 2,
          height: rand.nextDouble() * 8 + 2,
          decoration: BoxDecoration(
            color: const Color(0xFF4A2C8A)
                .withOpacity(.4 + rand.nextDouble() * .6),
            shape: BoxShape.circle,
          ),
        ),
      );
    });
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = const Color(0xFF4A2C8A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int i = 0; i < 12; i++) {
      final o = (i / 12) * s.width * .6;
      final path = Path()
        ..moveTo(o, 0)
        ..cubicTo(o + s.width * .3, s.height * .2, o - s.width * .1,
            s.height * .5, o + s.width * .2, s.height * .75)
        ..cubicTo(o + s.width * .5, s.height * .9, o + s.width * .1,
            s.height * .95, o + s.width * .3, s.height);
      c.drawPath(path, p);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
