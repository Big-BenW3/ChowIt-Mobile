import 'package:flutter/material.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/motion.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

// Meal customiser: required size choice, optional add-on, kitchen note,
// and quantity stepper. The sticky CTA always shows the live total and
// reports the quantity up so the root cart and sheet stay in sync.
class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key, required this.onGo, required this.onAdd});
  final ValueChanged<Screen> onGo;
  final ValueChanged<int> onAdd;
  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  String _size = 'Regular';
  bool _plantain = false;
  int _qty = 1;

  int get total =>
      (2500 + (_size == 'Large' ? 800 : 0) + (_plantain ? 700 : 0)) * _qty;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 108),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 285,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const ChowImage(url: ChowPhotos.jollof),
                    Positioned(
                      top: 22,
                      left: 18,
                      child: GestureDetector(
                        onTap: () => widget.onGo(Screen.restaurant),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ChowEyebrow(text: 'MAMA JOLLOF'),
                    const SizedBox(height: 6),
                    const Text(
                      'Smoky party jollof',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                        color: ChowColors.ink,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.star, size: 13, color: Color(0xFFF0A400)),
                        SizedBox(width: 4),
                        Text(
                          '4.9',
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
                      ],
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      'Our signature smoky jollof rice, cooked low and slow with rich tomatoes and warm spices.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.55,
                        color: ChowColors.muted,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _GroupTitle(title: 'Choose your size', tag: 'Required'),
                    const SizedBox(height: 12),
                    _RadioRow(
                      title: 'Regular',
                      subtitle: 'A satisfying portion',
                      trailing: 'Included',
                      selected: _size == 'Regular',
                      onTap: () => setState(() => _size = 'Regular'),
                    ),
                    _RadioRow(
                      title: 'Large',
                      subtitle: 'For a bigger appetite',
                      trailing: '+ ₦800',
                      selected: _size == 'Large',
                      onTap: () => setState(() => _size = 'Large'),
                    ),
                    const SizedBox(height: 24),
                    _GroupTitle(title: 'Add something extra', tag: 'Optional'),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => setState(() => _plantain = !_plantain),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: _plantain
                              ? const Color(0xFFFFF9F5)
                              : Colors.white,
                          border: Border.all(
                            color: _plantain
                                ? ChowColors.orange
                                : ChowColors.border,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: _plantain
                                      ? ChowColors.orange
                                      : const Color(0xFFCCC2BC),
                                  width: 1.5,
                                ),
                              ),
                              child: _plantain
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: ChowColors.orange,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 11),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sweet fried plantain',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'Golden, caramelised slices',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: ChowColors.muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              '+ ₦700',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _GroupTitle(title: 'Special instructions', tag: 'Optional'),
                    const SizedBox(height: 12),
                    Container(
                      height: 80,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: ChowColors.border,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'E.g. go easy on the pepper',
                          hintStyle: TextStyle(
                            fontSize: 11,
                            color: ChowColors.faint,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 23),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Row(
                          children: [
                            _StepButton(
                              icon: Icons.remove,
                              onTap: () => setState(
                                () => _qty = (_qty - 1).clamp(1, 20),
                              ),
                            ),
                            SizedBox(
                              width: 44,
                              child: Text(
                                '$_qty',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            _StepButton(
                              icon: Icons.add,
                              onTap: () => setState(
                                () => _qty = (_qty + 1).clamp(1, 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
            decoration: const BoxDecoration(
              color: Color(0xEFFFFCF9),
              border: Border(top: BorderSide(color: ChowColors.border)),
            ),
            child: ChowButton(
              onTap: () => widget.onAdd(_qty),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Add to order'), Text(naira(total))],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GroupTitle extends StatelessWidget {
  const _GroupTitle({required this.title, required this.tag});
  final String title;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 15, color: ChowColors.ink),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: '  $tag',
            style: const TextStyle(
              color: ChowColors.orange,
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RadioRow extends StatelessWidget {
  const _RadioRow({
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.selected,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final String trailing;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFF9F5) : Colors.white,
          border: Border.all(
            color: selected ? ChowColors.orange : ChowColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? ChowColors.orange : const Color(0xFFCCC2BC),
                  width: 1.5,
                ),
              ),
              child: selected
                  ? Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ChowColors.orange,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 9,
                      color: ChowColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              trailing,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ChowColors.border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 15, color: ChowColors.ink),
      ),
    );
  }
}

class _SheetCheck extends StatelessWidget {
  const _SheetCheck();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ChowColors.greenSoft,
      ),
      child: const Icon(Icons.check, color: ChowColors.green),
    );
  }
}

/// Slide-up confirmation shown after adding an item.
class AddedSheet extends StatelessWidget {
  const AddedSheet({
    super.key,
    required this.qty,
    required this.onClose,
    required this.onView,
  });
  final int qty;
  final VoidCallback onClose;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 26),
      decoration: const BoxDecoration(
        color: ChowColors.warm,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDDD3CD),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF6F0EC),
                  ),
                  child: const Icon(Icons.close, size: 16),
                ),
              ),
            ),
            const PopIn(child: _SheetCheck()),
            const SizedBox(height: 14),
            const Text(
              'Added to your order',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 7),
            const Text(
              'Your smoky party jollof is waiting in the cart.',
              style: TextStyle(fontSize: 11, color: ChowColors.muted),
            ),
            const SizedBox(height: 17),
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ChowColors.border),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const SizedBox(
                      width: 52,
                      height: 52,
                      child: ChowImage(url: ChowPhotos.jollof),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$qty× Smoky party jollof',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          qty > 1 ? 'Regular · $qty servings' : 'Regular',
                          style: const TextStyle(
                            fontSize: 8,
                            color: ChowColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    naira(2500 * qty),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            ChowButton(onTap: onView, child: const Text('View order')),
            const SizedBox(height: 8),
            ChowButton(
              secondary: true,
              onTap: onClose,
              child: const Text('Continue exploring'),
            ),
          ],
        ),
      ),
    );
  }
}
