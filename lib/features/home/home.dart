import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/shell.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

// Discovery home: greeting header, auto-advancing promo carousel (pauses
// while touched), categories, featured restaurants, specials, budget
// picks, and recommendations. Plus buttons report up to the root cart.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onGo,
    required this.cartCount,
    required this.onAdd,
  });
  final ValueChanged<Screen> onGo;
  final int cartCount;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return ChowShell(
      active: Screen.home,
      onGo: onGo,
      cartCount: cartCount,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deliver to · Home',
                    style: TextStyle(fontSize: 10, color: ChowColors.muted),
                  ),
                  GestureDetector(
                    onTap: () => onGo(Screen.addresses),
                    child: const Row(
                      children: [
                        Text(
                          '24 Akin Adesola St',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: ChowColors.ink,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, size: 14),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ChowColors.orange,
                ),
                child: const Text(
                  'AO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Ada',
                    style: TextStyle(fontSize: 12, color: ChowColors.muted),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'What can we get you?',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                      color: ChowColors.ink,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => onGo(Screen.cart),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ChowColors.border),
                    color: Colors.white,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag,
                        size: 21,
                        color: Color(0xFF352F2C),
                      ),
                      if (cartCount > 0)
                        Positioned(
                          top: 2,
                          right: 2,
                          child: Container(
                            width: 17,
                            height: 17,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ChowColors.orange,
                            ),
                            child: Text(
                              '$cartCount',
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          GestureDetector(
            onTap: () => onGo(Screen.search),
            child: Container(
              height: 51,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ChowColors.border, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, size: 19, color: Color(0xFF9A918B)),
                  SizedBox(width: 10),
                  Text(
                    'Search restaurants or meals',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9A918B)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const _HeroCarousel(),
          const ChowSectionTitle(
            title: 'Explore categories',
            action: 'See all',
          ),
          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: ChowData.categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 13),
              itemBuilder: (_, i) {
                final c = ChowData.categories[i];
                return GestureDetector(
                  onTap: () => onGo(Screen.search),
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: 63,
                    child: Column(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3E9),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Icon(
                            c.icon,
                            size: 26,
                            color: ChowColors.orange,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          c.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 9,
                            color: ChowColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const ChowSectionTitle(
            title: 'Featured restaurants',
            action: 'See all',
          ),
          SizedBox(
            height: 205,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: ChowData.restaurants.length,
              separatorBuilder: (_, _) => const SizedBox(width: 13),
              itemBuilder: (_, i) {
                final r = ChowData.restaurants[i];
                return GestureDetector(
                  onTap: () => onGo(Screen.restaurant),
                  child: Container(
                    width: 245,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ChowColors.border),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(19),
                          ),
                          child: SizedBox(
                            height: 118,
                            width: double.infinity,
                            child: ChowImage(url: r.image),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(13, 12, 13, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 12,
                                    color: ChowColors.gold,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    r.meta,
                                    style: const TextStyle(
                                      color: ChowColors.muted,
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                r.fee,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: ChowColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const ChowSectionTitle(title: 'ChowIt specials', action: 'See all'),
          for (final m in ChowData.meals.take(2))
            _MealRow(meal: m, onTap: () => onGo(Screen.item), onAdd: onAdd),
          const ChowSectionTitle(title: 'Good food under ₦2,000'),
          Container(
            height: 115,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ChowColors.yellow,
              borderRadius: BorderRadius.circular(19),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: const SizedBox(
                    width: 94,
                    height: 94,
                    child: ChowImage(url: ChowPhotos.pastry),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sweet Crumbs',
                        style: TextStyle(fontSize: 9, color: ChowColors.muted),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Fresh glazed doughnuts',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 9),
                      Text(
                        '₦1,800',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => onGo(Screen.item),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ChowColors.orange,
                    ),
                    child: const Icon(Icons.add, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const ChowSectionTitle(title: 'You will love these'),
          for (final m in ChowData.meals)
            GestureDetector(
              onTap: () => onGo(Screen.item),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: ChowColors.border)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: SizedBox(
                        width: 92,
                        height: 82,
                        child: ChowImage(url: m.image),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m.name,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${m.restaurant} · 25–35 min',
                            style: const TextStyle(
                              fontSize: 9,
                              color: ChowColors.muted,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            naira(m.price),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: ChowColors.muted,
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

class _MealRow extends StatelessWidget {
  const _MealRow({
    required this.meal,
    required this.onTap,
    required this.onAdd,
  });
  final Meal meal;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ChowColors.border),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: SizedBox(
                width: 82,
                height: 82,
                child: ChowImage(url: meal.image),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.restaurant.toUpperCase(),
                    style: const TextStyle(
                      color: ChowColors.orange,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Smoky, generous and made fresh',
                    style: TextStyle(fontSize: 9, color: ChowColors.muted),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    naira(meal.price),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onAdd,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ChowColors.orange,
                ),
                child: const Icon(Icons.add, size: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Auto-advancing promo carousel, pausing while the user drags.
class _HeroCarousel extends StatefulWidget {
  const _HeroCarousel();
  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  final _controller = PageController();
  int _page = 0;
  Timer? _timer;
  bool _held = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_held || !mounted || !_controller.hasClients) return;
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _page = i % 3),
            itemBuilder: (_, i) => Container(
              margin: const EdgeInsets.only(right: 0),
              decoration: BoxDecoration(
                color: ChowColors.darkCard,
                borderRadius: BorderRadius.circular(22),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  const Positioned.fill(
                    left: null,
                    child: SizedBox(
                      width: 220,
                      child: ChowImage(url: ChowPhotos.hero),
                    ),
                  ),
                  Container(
                    width: 250,
                    padding: const EdgeInsets.fromLTRB(21, 24, 0, 20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2F251F), Colors.transparent],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CHOWIT PICK',
                          style: TextStyle(
                            color: Color(0xFFFFB68F),
                            fontSize: 9,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'A little treat goes a long way.',
                          style: TextStyle(
                            fontSize: 21,
                            height: 1.14,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Explore meals',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: ChowColors.ink,
                                ),
                              ),
                              SizedBox(width: 7),
                              Icon(
                                Icons.arrow_forward,
                                size: 13,
                                color: ChowColors.ink,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 11,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < 3; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _page == i ? 16 : 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: _page == i
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
              ],
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTapDown: (_) => setState(() => _held = true),
              onTapUp: (_) => setState(() => _held = false),
              onTapCancel: () => setState(() => _held = false),
              behavior: HitTestBehavior.translucent,
            ),
          ),
        ],
      ),
    );
  }
}
