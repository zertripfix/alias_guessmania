
import 'package:flutter/material.dart';

class DuolingoButtonStyle {
  final Color normalColor;
  final Color pressedColor;
  final double cornerRadius;
  final double offset;
  final EdgeInsets padding;
  final double fontSize;
  final Color textColor;
  final Widget? icon;

  const DuolingoButtonStyle({
    this.normalColor = const Color(0xFF6D83F2),
    this.pressedColor = const Color(0xFF5A6EDB),
    this.cornerRadius = 16.0,
    this.offset = 6.0,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    this.fontSize = 16.0,
    this.textColor = Colors.white,
    this.icon,
  });
}

class ButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final DuolingoButtonStyle style;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.style = const DuolingoButtonStyle(),
  });

  @override
  ButtonWidgetState createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails _) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.style;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: s.pressedColor,
              borderRadius: BorderRadius.circular(s.cornerRadius),
            ),
          ),

          // 2) Normal background — смещаем вниз через margin
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            margin: EdgeInsets.only(top: _isPressed ? 0 : s.offset),
            decoration: BoxDecoration(
              color: s.normalColor,
              borderRadius: BorderRadius.circular(s.cornerRadius),
            ),
          ),

          // Текст и иконка, смещённые вниз/вверх
          Positioned.fill(
            child: Center(
              child: Transform.translate(
                offset: Offset(0, _isPressed ? 0 : -s.offset / 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (s.icon != null) ...[
                      s.icon!,
                      SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: s.textColor,
                        fontSize: s.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5AF178), // lighter top green
              Color(0xFF00C853), // darker bottom green
            ],
          ),
          borderRadius: BorderRadius.circular(40),
          border: const Border(
            top: BorderSide(color: Color(0xFFFFFFFF), width: 2),
            bottom: BorderSide(color: Color(0xFF0E8A42), width: 3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              offset: const Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, color: Colors.white, size: 22),
            if (icon != null)
              const SizedBox(width: 8),
            Text(
              text.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}