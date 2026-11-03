import 'package:flutter/material.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/shell.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

// Search has two states: a landing state (categories, popular searches,
// suggestions) and a results state once the user types. Tapping a
// category fills the query instead of navigating away.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.onGo, required this.cartCount});
  final ValueChanged<Screen> onGo;
  final int cartCount;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _controller.text;
    return ChowShell(
      active: Screen.search,
      onGo: widget.onGo,
      cartCount: widget.cartCount,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Search',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                  color: ChowColors.ink,
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ChowColors.border),
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.tune,
                  size: 21,
                  color: Color(0xFF352F2C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 51,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ChowColors.border, width: 1.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 19, color: Color(0xFF9A918B)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      hintText: 'Search restaurants or meals',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9A918B),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (query.isNotEmpty)
                  GestureDetector(
                    onTap: () => setState(_controller.clear),
                    child: const Icon(
                      Icons.close,
                      size: 19,
                      color: Color(0xFF9A918B),
                    ),
                  ),
              ],
            ),
          ),
          if (query.isEmpty) ...[
            const SizedBox(height: 28),
            const Text(
              'What are you craving?',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: ChowColors.ink,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Browse a category or search for something specific.',
              style: TextStyle(fontSize: 11, color: ChowColors.muted),
            ),
            const SizedBox(height: 19),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.4,
              children: [
                for (final c in ChowData.categories)
                  GestureDetector(
                    onTap: () => setState(() => _controller.text = c.name),
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ChowColors.border),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E9),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Icon(
                              c.icon,
                              size: 21,
                              color: ChowColors.orange,
                            ),
                          ),
                          const SizedBox(width: 11),
                          Expanded(
                            child: Text(
                              c.name,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const ChowSectionTitle(title: 'Popular searches'),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (final term in ChowData.popularSearches)
                  GestureDetector(
                    onTap: () => setState(() => _controller.text = term),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ChowColors.border),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        term,
                        style: const TextStyle(
                          fontSize: 10,
                          color: ChowColors.ink,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const ChowSectionTitle(title: 'You will love these'),
            for (final m in ChowData.meals.take(2))
              _SearchRow(
                title: m.name,
                subtitle: m.restaurant,
                price: naira(m.price),
                image: m.image,
                onTap: () => widget.onGo(Screen.item),
              ),
          ] else ...[
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontSize: 11,
                        color: ChowColors.ink,
                      ),
                      children: [
                        const TextSpan(text: 'Results for '),
                        TextSpan(
                          text: '"$query"',
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  '8 found',
                  style: TextStyle(fontSize: 11, color: ChowColors.muted),
                ),
              ],
            ),
            const ChowSectionTitle(title: 'Meals'),
            for (final m in ChowData.meals)
              _SearchRow(
                eyebrow: 'MEAL · ${m.restaurant.toUpperCase()}',
                title: m.name,
                subtitle: '4.8 · 25 min',
                price: naira(m.price),
                image: m.image,
                showStar: true,
                onTap: () => widget.onGo(Screen.item),
              ),
            const ChowSectionTitle(title: 'Restaurants'),
            _SearchRow(
              eyebrow: 'RESTAURANT',
              title: 'Mama Jollof',
              subtitle: '4.8 · 25–35 min · ₦650 delivery',
              image: ChowPhotos.hero,
              onTap: () => widget.onGo(Screen.restaurant),
            ),
          ],
        ],
      ),
    );
  }
}

class _SearchRow extends StatelessWidget {
  const _SearchRow({
    this.eyebrow,
    required this.title,
    required this.subtitle,
    this.price,
    required this.image,
    this.showStar = false,
    required this.onTap,
  });
  final String? eyebrow;
  final String title;
  final String subtitle;
  final String? price;
  final String image;
  final bool showStar;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: ChowColors.border)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: SizedBox(
                width: 78,
                height: 75,
                child: ChowImage(url: image),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eyebrow ?? subtitle,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      color: eyebrow != null
                          ? ChowColors.orange
                          : ChowColors.muted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (eyebrow != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (showStar)
                          const Icon(
                            Icons.star,
                            size: 11,
                            color: ChowColors.gold,
                          ),
                        if (showStar) const SizedBox(width: 3),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 9,
                            color: ChowColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (price != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      price!,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 17, color: Color(0xFFAAA19C)),
          ],
        ),
      ),
    );
  }
}
