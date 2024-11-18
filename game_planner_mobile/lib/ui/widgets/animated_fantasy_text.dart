import 'package:flutter/material.dart';

class AnimatedFantasyText extends StatefulWidget {
  const AnimatedFantasyText({super.key});

  @override
  _AnimatedFantasyTextState createState() => _AnimatedFantasyTextState();
}

class _AnimatedFantasyTextState extends State<AnimatedFantasyText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);

    _color1 = ColorTween(
      begin: const Color(0xFF9147FF),
      end: const Color(0xFFFF71CE),
    ).animate(_controller);

    _color2 = ColorTween(
      begin: const Color(0xFFFF71CE),
      end: const Color(0xFF9147FF),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 48,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(3, 3),
              color: Colors.black54,
              blurRadius: 4,
            ),
          ],
        ),
        children: [
          const TextSpan(text: 'Where '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [_color1.value!, _color2.value!],
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    );
                  },
                  child: const Text(
                    'fantasy',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          const TextSpan(text: '\nbecome reality'),
        ],
      ),
    );
  }
}
