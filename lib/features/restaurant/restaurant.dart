import 'package:flutter/material.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

class _MenuEntry {
  const _MenuEntry({
    required this.name,
    required this.desc,
    required this.price,
    required this.image,
    this.badge,
  });
  final String name;
  final String desc;
  final int price;
  final String image;
  final String? badge;
}

// Restaurant detail: cover photo, overlapping vendor mark, sticky
// category tabs that filter the menu below. Plus buttons open the item
// customiser.
class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key, required this.onGo});
  final ValueChanged<Screen> onGo;
  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  int _tab = 0;
  static const _tabs = ['Popular', 'Rice meals', 'Soups', 'Sides'];
  static const _menus = [
    [
      _MenuEntry(
        name: 'Smoky party jollof',
        desc: 'Smoky rice, tender protein and signature pepper sauce.',
        price: 2500,
        image: ChowPhotos.jollof,
      ),
      _MenuEntry(
        name: 'Grilled chicken bowl',
        desc: 'Smoky rice, tender protein and signature pepper sauce.',
        price: 4500,
        image: ChowPhotos.rice,
      ),
      _MenuEntry(
        name: 'Egusi & soft swallow',
        desc: 'Smoky rice, tender protein and signature pepper sauce.',
        price: 3800,
        image: ChowPhotos.egusi,
        badge: 'Popular',
      ),
    ],
    [
      _MenuEntry(
        name: 'Smoky party jollof',
        desc: 'Firewood party rice with fried plantain.',
        price: 2500,
        image: ChowPhotos.jollof,
      ),
      _MenuEntry(
        name: 'Grilled chicken bowl',
        desc: 'Golden fried rice with crispy chicken.',
        price: 4500,
        image: ChowPhotos.rice,
      ),
    ],
    [
      _MenuEntry(
        name: 'Egusi & soft swallow',
        desc: 'Cocoyam-thickened egusi with stockfish.',
        price: 3800,
        image: ChowPhotos.egusi,
        badge: 'Popular',
      ),
    ],
    [
      _MenuEntry(
        name: 'Sweet fried plantain',
        desc: 'Golden, caramelised slices.',
        price: 1200,
        image: ChowPhotos.platter,
      ),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 250,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const ChowImage(url: ChowPhotos.hero),
                Positioned(
                  top: 22,
                  left: 18,
                  child: GestureDetector(
                    onTap: () => widget.onGo(Screen.home),
                    child: Container(
                      width: 43,
                      height: 43,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xF0FFFFFF),
                      ),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                  ),
                ),
                Positioned(
                  top: 22,
                  right: 18,
                  child: Container(
                    width: 43,
                    height: 43,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xF0FFFFFF),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: ChowColors.ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 34, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'OPEN NOW',
                      style: TextStyle(
                        color: ChowColors.green,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Mama Jollof',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: ChowColors.ink,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Local favourites · Rice · Grills',
                      style: TextStyle(fontSize: 11, color: ChowColors.muted),
                    ),
                    const SizedBox(height: 13),
                    const Row(
                      children: [
                        Icon(Icons.star, size: 13, color: Color(0xFFF0A400)),
                        SizedBox(width: 4),
                        Text(
                          '4.8 (320)',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF665F5B),
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(
                          Icons.schedule,
                          size: 13,
                          color: Color(0xFF665F5B),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '25–35 min',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF665F5B),
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(
                          Icons.shopping_bag,
                          size: 13,
                          color: Color(0xFF665F5B),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '₦650 delivery',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF665F5B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -25,
                left: 20,
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ChowColors.dark,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: ChowColors.warm, width: 4),
                  ),
                  child: const Text(
                    'MJ',
                    style: TextStyle(
                      color: Color(0xFFFF9F6C),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _TabsDelegate(
            tabs: _tabs,
            active: _tab,
            onTap: (i) => setState(() => _tab = i),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ChowSectionTitle(title: 'Popular right now'),
                const Text(
                  'The meals people keep coming back for.',
                  style: TextStyle(fontSize: 10, color: ChowColors.muted),
                ),
                const SizedBox(height: 3),
                for (final m in _menus[_tab])
                  GestureDetector(
                    onTap: () => widget.onGo(Screen.item),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: ChowColors.border),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  m.desc,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    height: 1.45,
                                    color: ChowColors.muted,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      'From ${naira(m.price)}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    if (m.badge != null) ...[
                                      const SizedBox(width: 7),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ChowColors.greenSoft,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Text(
                                          m.badge!,
                                          style: const TextStyle(
                                            color: ChowColors.green,
                                            fontSize: 7,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                  width: 105,
                                  height: 105,
                                  child: ChowImage(url: m.image),
                                ),
                              ),
                              Positioned(
                                right: 7,
                                bottom: 7,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF2B1B13,
                                        ).withValues(alpha: 0.13),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 17,
                                    color: ChowColors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TabsDelegate extends SliverPersistentHeaderDelegate {
  _TabsDelegate({
    required this.tabs,
    required this.active,
    required this.onTap,
  });
  final List<String> tabs;
  final int active;
  final ValueChanged<int> onTap;

  @override
  double get minExtent => 56;
  @override
  double get maxExtent => 56;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color(0xEEFFFCF9),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 6),
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => onTap(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: active == i ? ChowColors.orange : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              tabs[i],
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: active == i ? Colors.white : ChowColors.ink,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _TabsDelegate old) => old.active != active;
}
