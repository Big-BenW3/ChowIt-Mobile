import 'package:flutter/material.dart';
import 'package:my_app/core/theme.dart';

// Shared building blocks: logo, buttons, headers, fields, section titles,
// and a network image that degrades to a branded tile when offline.
class ChowImage extends StatelessWidget {
  const ChowImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.icon = Icons.restaurant,
  });
  final String url;
  final BoxFit fit;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      errorBuilder: (_, _, _) => Container(
        color: ChowColors.peach,
        alignment: Alignment.center,
        child: Icon(icon, color: ChowColors.orange, size: 32),
      ),
    );
  }
}

/// ChowIt wordmark with a hand-drawn style bowl mark.
class ChowLogo extends StatelessWidget {
  const ChowLogo({super.key, this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: Size(compact ? 38 : 72, compact ? 43 : 79),
          painter: _BowlPainter(),
        ),
        Text(
          'ChowIt',
          style: TextStyle(
            fontSize: compact ? 26 : 32,
            fontWeight: FontWeight.w800,
            letterSpacing: compact ? -1.5 : -2,
            color: ChowColors.orange,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _BowlPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final orange = Paint()..color = ChowColors.orange;
    final s = size.width / 68;
    canvas.save();
    canvas.scale(s);
    // Steam curl.
    canvas.drawPath(
      Path()
        ..moveTo(29, 11)
        ..cubicTo(33, 7, 31, 3, 28, 1),
      Paint()
        ..color = ChowColors.orange
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );
    // Bowl body.
    canvas.drawPath(
      Path()
        ..moveTo(18, 18)
        ..cubicTo(27, 10, 43, 12, 50, 22)
        ..cubicTo(57, 32, 51, 42, 47, 49)
        ..cubicTo(41, 61, 32, 70, 21, 67)
        ..cubicTo(9, 63, 11, 51, 14, 42)
        ..cubicTo(16, 34, 12, 27, 18, 18)
        ..close(),
      orange,
    );
    // Smile arc.
    canvas.drawArc(
      const Rect.fromLTWH(22, 32, 22, 18),
      0.4,
      2.3,
      false,
      Paint()
        ..color = ChowColors.ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
    // Fork on the side.
    canvas.drawPath(
      Path()
        ..moveTo(51, 54)
        ..lineTo(60, 31)
        ..moveTo(53, 42)
        ..cubicTo(60, 42, 65, 34, 64, 28)
        ..cubicTo(57, 26, 51, 33, 53, 42)
        ..close(),
      orange,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Primary / secondary button with press-scale feedback.
class ChowButton extends StatefulWidget {
  const ChowButton({
    super.key,
    required this.onTap,
    required this.child,
    this.secondary = false,
  });
  final VoidCallback? onTap;
  final Widget child;
  final bool secondary;

  @override
  State<ChowButton> createState() => _ChowButtonState();
}

class _ChowButtonState extends State<ChowButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          height: 54,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.secondary ? Colors.white : ChowColors.orange,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: widget.secondary
                ? Border.all(color: ChowColors.border, width: 1.5)
                : null,
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: widget.secondary ? const Color(0xFF352F2C) : Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// Screen header with back action and optional trailing action.
class ChowTopBar extends StatelessWidget {
  const ChowTopBar({super.key, required this.title, this.onBack, this.action});
  final String title;
  final VoidCallback? onBack;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Row(
        children: [
          ChowIconButton(icon: Icons.arrow_back, onTap: onBack ?? () {}),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: ChowColors.ink,
              ),
            ),
          ),
          SizedBox(width: 44, child: action),
        ],
      ),
    );
  }
}

class ChowIconButton extends StatelessWidget {
  const ChowIconButton({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 21, color: const Color(0xFF352F2C)),
      ),
    );
  }
}

/// Labelled input with optional country-code style prefix.
class ChowField extends StatelessWidget {
  const ChowField({
    super.key,
    this.label,
    required this.hint,
    this.prefix,
    this.obscure = false,
    this.keyboard = TextInputType.text,
  });
  final String? label;
  final String hint;
  final String? prefix;
  final bool obscure;
  final TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text(
              label!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: ChowColors.ink,
              ),
            ),
          ),
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ChowColors.border, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            children: [
              if (prefix != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: ChowColors.border)),
                  ),
                  child: Text(
                    prefix!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: ChowColors.ink,
                    ),
                  ),
                ),
              Expanded(
                child: TextField(
                  obscureText: obscure,
                  keyboardType: keyboard,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: ChowColors.faint,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Small orange eyebrow label used above headings.
class ChowEyebrow extends StatelessWidget {
  const ChowEyebrow({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: ChowColors.orange,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.4,
      ),
    );
  }
}

/// Section heading with an optional trailing action.
class ChowSectionTitle extends StatelessWidget {
  const ChowSectionTitle({super.key, required this.title, this.action});
  final String title;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
              color: ChowColors.ink,
            ),
          ),
          if (action != null)
            Text(
              action!,
              style: const TextStyle(
                color: ChowColors.orange,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
        ],
      ),
    );
  }
}
