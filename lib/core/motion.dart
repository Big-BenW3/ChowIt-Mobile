import 'package:flutter/material.dart';

// Signature motion: quick decisive entrances, faster exits, transform and
// opacity only. Entrance wraps one section at a time; PopIn is reserved
// for rare success moments. Both stand down under reduced-motion settings.
abstract final class ChowCurves {
  static const enter = Cubic(0.22, 1, 0.36, 1);
  static const move = Cubic(0.25, 1, 0.5, 1);
}

/// Staggered fade-and-rise entrance. One entrance per container: wrap the
/// section, not every child. Skipped when reduced motion is on.
class Entrance extends StatefulWidget {
  const Entrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.distance = 14.0,
  });
  final Widget child;
  final Duration delay;
  final double distance;

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;
    final curved = CurvedAnimation(
      parent: _controller,
      curve: ChowCurves.enter,
    );
    return FadeTransition(
      opacity: curved,
      child: AnimatedBuilder(
        animation: curved,
        builder: (_, child) => Transform.translate(
          offset: Offset(0, (1 - curved.value) * widget.distance),
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}

/// Soft scale pop for success moments. Rare moments earn personality.
class PopIn extends StatelessWidget {
  const PopIn({super.key, required this.child, this.delay = Duration.zero});
  final Widget child;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
      builder: (_, t, child) => Opacity(
        opacity: t,
        child: Transform.scale(
          scale: 0.85 + 0.15 * Curves.easeOutBack.transform(t),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
