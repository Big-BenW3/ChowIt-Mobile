import 'package:flutter/material.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/motion.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/theme.dart';

// Tab scaffold shared by Home, Search, Orders, and Profile: scrollable
// body, the sliding dark mini-cart bar, and bottom navigation.

/// Four-destination bottom navigation.
class ChowBottomNav extends StatelessWidget {
  const ChowBottomNav({super.key, required this.active, required this.onGo});
  final Screen active;
  final ValueChanged<Screen> onGo;

  @override
  Widget build(BuildContext context) {
    const items = [
      (Screen.home, 'Home', Icons.home),
      (Screen.search, 'Search', Icons.search),
      (Screen.orders, 'Orders', Icons.shopping_bag),
      (Screen.profile, 'Profile', Icons.person),
    ];
    return Container(
      height: 78,
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 10),
      decoration: const BoxDecoration(
        color: Color(0xF2FFFFFF),
        border: Border(top: BorderSide(color: ChowColors.border)),
      ),
      child: Row(
        children: [
          for (final item in items)
            Expanded(
              child: GestureDetector(
                onTap: () => onGo(item.$1),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.$3,
                      size: 21,
                      color: active == item.$1
                          ? ChowColors.orange
                          : const Color(0xFF9B938E),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.$2,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: active == item.$1
                            ? ChowColors.orange
                            : const Color(0xFF9B938E),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Persistent dark mini-cart bar above the bottom nav.
class MiniCartBar extends StatelessWidget {
  const MiniCartBar({super.key, required this.count, required this.onView});
  final int count;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onView,
      child: Container(
        height: 58,
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ChowColors.dark,
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF332319).withValues(alpha: 0.19),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.shopping_bag, size: 19, color: Color(0xFFFFAE81)),
            const SizedBox(width: 5),
            Text(
              '$count',
              style: const TextStyle(
                color: Color(0xFFFFAE81),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'View order',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            const Spacer(),
            Text(
              naira(2500 * count),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tab scaffold with scroll body, mini-cart, and bottom nav.
class ChowShell extends StatelessWidget {
  const ChowShell({
    super.key,
    required this.active,
    required this.onGo,
    required this.child,
    this.cartCount = 0,
  });
  final Screen active;
  final ValueChanged<Screen> onGo;
  final Widget child;
  final int cartCount;

  @override
  Widget build(BuildContext context) {
    final showMiniCart =
        cartCount > 0 && active != Screen.orders && active != Screen.profile;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
            child: Entrance(child: child),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 260),
          switchInCurve: ChowCurves.enter,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) => SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: showMiniCart
              ? MiniCartBar(
                  key: const ValueKey('mini-cart'),
                  count: cartCount,
                  onView: () => onGo(Screen.cart),
                )
              : const SizedBox.shrink(key: ValueKey('no-cart')),
        ),
        ChowBottomNav(active: active, onGo: onGo),
      ],
    );
  }
}
