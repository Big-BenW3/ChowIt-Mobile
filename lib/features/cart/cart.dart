import 'package:flutter/material.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

// Cart: friendly empty state, or vendor header, editable line items,
// kitchen note, gift toggle, voucher row, and subtotal. Fees are
// deliberately shown only at checkout, where the server computes them.
class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    required this.onGo,
    required this.count,
    required this.onCount,
  });
  final ValueChanged<Screen> onGo;
  final int count;
  final ValueChanged<int> onCount;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _gift = false;

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.count * 2500;
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 130),
          child: Column(
            children: [
              ChowTopBar(
                title: 'Your order',
                onBack: () => widget.onGo(Screen.home),
                action: widget.count == 0
                    ? null
                    : GestureDetector(
                        onTap: () => widget.onCount(0),
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            color: ChowColors.orange,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
              ),
              if (widget.count == 0) ...[
                const SizedBox(height: 120),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: ChowColors.peach,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const Icon(
                    Icons.shopping_bag,
                    size: 35,
                    color: ChowColors.orange,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your next delicious order starts here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.3,
                    fontWeight: FontWeight.w800,
                    color: ChowColors.ink,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Find something you’ll look forward to.',
                  style: TextStyle(fontSize: 11, color: ChowColors.muted),
                ),
                const SizedBox(height: 22),
                ChowButton(
                  onTap: () => widget.onGo(Screen.home),
                  child: const Text('Browse meals'),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: ChowColors.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ChowColors.dark,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Text(
                          'MJ',
                          style: TextStyle(
                            color: Color(0xFFFF9F6C),
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 11),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ORDER FROM',
                              style: TextStyle(
                                fontSize: 8,
                                color: ChowColors.muted,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Mama Jollof',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, size: 17),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: const SizedBox(
                          width: 82,
                          height: 82,
                          child: ChowImage(url: ChowPhotos.jollof),
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Smoky party jollof',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Regular · No add-ons',
                              style: TextStyle(
                                fontSize: 9,
                                color: ChowColors.muted,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => widget.onGo(Screen.item),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  'Edit options',
                                  style: TextStyle(
                                    color: ChowColors.orange,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              naira(subtotal),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _StepperButton(
                          icon: widget.count == 1
                              ? Icons.delete_outline
                              : Icons.remove,
                          onTap: () =>
                              widget.onCount((widget.count - 1).clamp(0, 99)),
                        ),
                        SizedBox(
                          width: 28,
                          child: Text(
                            '${widget.count}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        _StepperButton(
                          icon: Icons.add,
                          onTap: () => widget.onCount(widget.count + 1),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.onGo(Screen.restaurant),
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Icon(Icons.add, size: 16, color: ChowColors.orange),
                        SizedBox(width: 6),
                        Text(
                          'Add another meal',
                          style: TextStyle(
                            color: ChowColors.orange,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Note for Mama Jollof',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 80,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ChowColors.border, width: 1.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Anything the kitchen should know?',
                      hintStyle: TextStyle(
                        fontSize: 11,
                        color: ChowColors.faint,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => setState(() => _gift = !_gift),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ChowColors.border),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.card_giftcard,
                          size: 20,
                          color: ChowColors.orange,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Send this order as a gift',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Add a recipient and message',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: ChowColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 35,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: _gift
                                ? ChowColors.orange
                                : const Color(0xFFDDD6D1),
                          ),
                          child: AnimatedAlign(
                            duration: const Duration(milliseconds: 200),
                            alignment: _gift
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: 16,
                              height: 16,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ChowColors.border),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.percent, size: 20, color: ChowColors.orange),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Have a voucher?',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Choose or enter a code',
                              style: TextStyle(
                                fontSize: 8,
                                color: ChowColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: ChowColors.muted,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal', style: TextStyle(fontSize: 13)),
                    Text(
                      naira(subtotal),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Delivery and service fees will be confirmed next.',
                    style: TextStyle(fontSize: 9, color: ChowColors.muted),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (widget.count > 0)
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
                onTap: () => widget.onGo(Screen.checkout),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Continue to delivery'),
                    Text(naira(subtotal)),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ChowColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 14, color: ChowColors.ink),
      ),
    );
  }
}
