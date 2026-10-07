import 'dart:math' as math;
import 'package:flutter/material.dart';

class PortfolioBackground extends StatefulWidget {
  const PortfolioBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<PortfolioBackground> createState() => _PortfolioBackgroundState();
}

class _PortfolioBackgroundState extends State<PortfolioBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: _BaseBackground(),
        ),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return _DecorativeBackground(
                animationValue: _controller.value,
              );
            },
          ),
        ),
        Positioned.fill(
          child: widget.child,
        ),
      ],
    );
  }
}

class _BaseBackground extends StatelessWidget {
  const _BaseBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GridPainter(),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double gridSize = 48;

    final Paint paint = Paint()
      ..color = const Color(0x0D1677FF)
      ..strokeWidth = 0.7;

    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DecorativeBackground extends StatelessWidget {
  const _DecorativeBackground({
    required this.animationValue,
  });

  final double animationValue;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;
        final double movement = math.sin(animationValue * math.pi * 2);

        return Stack(
          children: [
            Positioned(
              left: -100,
              top: -110 + (movement * 8),
              child: _GlowCircle(
                size: width > 900 ? 300 : 190,
                colors: const [
                  Color(0xFF1677FF),
                  Color(0xFF00D4FF),
                ],
              ),
            ),
            Positioned(
              left: -100,
              bottom: -120 - (movement * 8),
              child: _GlowCircle(
                size: width > 900 ? 270 : 170,
                colors: const [
                  Color(0xFF18A0FB),
                  Color(0xFF00E0FF),
                ],
              ),
            ),
            Positioned(
              right: -110,
              bottom: -130 + (movement * 7),
              child: _GlowCircle(
                size: width > 900 ? 300 : 180,
                colors: const [
                  Color(0xFF00E5FF),
                  Color(0xFF1677FF),
                ],
              ),
            ),
            Positioned(
              left: width * 0.45,
              top: height * 0.18,
              child: _SoftGlow(
                size: width > 900 ? 430 : 250,
              ),
            ),
            _buildFloatingDots(width, height),
            const Positioned.fill(
              child: CustomPaint(
                painter: _OrbitPainter(),
              ),
            ),
            if (width > 700)
              Positioned(
                left: width * 0.47,
                top: height * 0.65,
                child: const _StarDecoration(size: 22),
              ),
            if (width > 700)
              Positioned(
                left: width * 0.03,
                top: height * 0.76,
                child: const _StarDecoration(size: 12),
              ),
          ],
        );
      },
    );
  }

  Widget _buildFloatingDots(double width, double height) {
    return Stack(
      children: [
        Positioned(
          left: width * 0.37,
          top: height * 0.13,
          child: const _DotGrid(),
        ),
        Positioned(
          left: width * 0.41,
          top: height * 0.08,
          child: const _FloatingDot(size: 10),
        ),
        Positioned(
          left: width * 0.17,
          top: height * 0.91,
          child: const _FloatingDot(size: 8),
        ),
      ],
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({
    required this.size,
    required this.colors,
  });

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: 0.20),
            blurRadius: 70,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }
}

class _SoftGlow extends StatelessWidget {
  const _SoftGlow({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            const Color(0xFF00C8FF).withValues(alpha: 0.18),
            const Color(0xFF1677FF).withValues(alpha: 0.08),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class _DotGrid extends StatelessWidget {
  const _DotGrid();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 120,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 40,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          crossAxisSpacing: 13,
          mainAxisSpacing: 13,
        ),
        itemBuilder: (context, index) {
          return Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Color(0x661677FF),
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }
}

class _FloatingDot extends StatelessWidget {
  const _FloatingDot({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF4AA9FF),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  const _OrbitPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = const Color(0x401677FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final Paint cyanPaint = Paint()
      ..color = const Color(0x5521C7E8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final Path leftPath = Path();
    leftPath.moveTo(-80, size.height * 0.28);
    leftPath.cubicTo(
      size.width * 0.08,
      size.height * 0.18,
      size.width * 0.08,
      size.height * 0.55,
      -50,
      size.height * 0.68,
    );
    canvas.drawPath(leftPath, linePaint);

    final Path bottomPath = Path();
    bottomPath.moveTo(size.width * 0.45, size.height);
    bottomPath.cubicTo(
      size.width * 0.58,
      size.height * 0.84,
      size.width * 0.80,
      size.height * 0.85,
      size.width * 0.95,
      size.height * 0.67,
    );
    canvas.drawPath(bottomPath, cyanPaint);

    final Path rightPath = Path();
    rightPath.moveTo(size.width * 0.96, size.height * 0.15);
    rightPath.cubicTo(
      size.width * 0.89,
      size.height * 0.25,
      size.width * 0.91,
      size.height * 0.38,
      size.width,
      size.height * 0.45,
    );
    canvas.drawPath(rightPath, linePaint);

    final Rect leftArc = Rect.fromCircle(
      center: Offset(-25, size.height * 0.35),
      radius: 100,
    );
    canvas.drawArc(leftArc, -1.2, 2.2, false, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StarDecoration extends StatelessWidget {
  const _StarDecoration({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _StarPainter(),
    );
  }
}

class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF1677FF)
      ..style = PaintingStyle.fill;

    final double cx = size.width / 2;
    final double cy = size.height / 2;

    final Path path = Path();
    path.moveTo(cx, 0);
    path.lineTo(cx + size.width * 0.18, cy - size.height * 0.18);
    path.lineTo(size.width, cy);
    path.lineTo(cx + size.width * 0.18, cy + size.height * 0.18);
    path.lineTo(cx, size.height);
    path.lineTo(cx - size.width * 0.18, cy + size.height * 0.18);
    path.lineTo(0, cy);
    path.lineTo(cx - size.width * 0.18, cy - size.height * 0.18);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
