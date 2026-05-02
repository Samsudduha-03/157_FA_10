import 'dart:math';
import 'package:flutter/material.dart';
import 'signin_screen.dart';

class WelcomeBackScreen extends StatelessWidget {
  const WelcomeBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _bg(),
          _blotch(160, 140, 100, -20, Colors.white12),
          _blotch(200, 180, 320, 60, Colors.white10),
          _blotch(
              180, 160, size.height - 220, size.width - 170, Colors.white12),
          ..._dots(size, 45, 10, 11),
          ..._dots(size, 40, size.height * .72, 77),
          _waves(size, left: true),
          _waves(size, left: false),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Text(
                    'Enter your details',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                  child: SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignInScreen()),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(.35),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
        right: left ? null : -30,
        top: size.height * (left ? .28 : .30),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(left ? 1.0 : -1.0, 1.0),
          child: CustomPaint(
            size: const Size(160, 280),
            painter: _WavePainter(),
          ),
        ),
      );

  List<Widget> _dots(Size size, int count, double top, int seed) {
    final r = Random(seed);
    return List.generate(count, (_) {
      return Positioned(
        left: r.nextDouble() * size.width,
        top: top + r.nextDouble() * (size.height * .25),
        child: Container(
          width: r.nextDouble() * 8 + 2,
          height: r.nextDouble() * 8 + 2,
          decoration: BoxDecoration(
            color:
                const Color(0xFF4A2C8A).withOpacity(.4 + r.nextDouble() * .6),
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
