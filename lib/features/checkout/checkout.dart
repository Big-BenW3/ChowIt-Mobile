import 'package:flutter/material.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

// Checkout: address card with Change action, timing estimate,
// instructions, and the fee breakdown. The CTA moves to payment; nothing
// is charged until the payment step confirms.
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.onGo, required this.count});
  final ValueChanged<Screen> onGo;
  final int count;

  @override
  Widget build(BuildContext context) {
    final subtotal = count * 2500;
    final total = subtotal + 650 + 150;
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 130),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChowTopBar(title: 'Delivery', onBack: () => onGo(Screen.cart)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Delivery address',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onGo(Screen.addresses),
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        color: ChowColors.orange,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 11),
              const _AddressCard(selected: true),
              const SizedBox(height: 20),
              const Text(
                'Delivery timing',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.schedule, color: ChowColors.orange),
                  SizedBox(width: 11),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About 35–45 minutes',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Restaurant prep: 25–35 min',
                        style: TextStyle(fontSize: 9, color: ChowColors.muted),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Delivery instructions',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 12),
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
                    hintText: 'Call when you arrive',
                    hintStyle: TextStyle(fontSize: 11, color: ChowColors.faint),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Payment summary',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 11),
              _FeeRow(label: 'Subtotal', value: naira(subtotal)),
              _FeeRow(label: 'Delivery fee', value: '₦650'),
              _FeeRow(label: 'Service fee', value: '₦150'),
              const Divider(color: ChowColors.border, height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    naira(total),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: ChowColors.demoBg,
                  border: Border.all(color: ChowColors.demoBorder),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Icon(Icons.badge, size: 19, color: ChowColors.demoInk),
                    SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 9,
                            height: 1.4,
                            color: ChowColors.ink,
                          ),
                          children: [
                            TextSpan(
                              text: 'No charge yet ',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text:
                                  'Choose payment after confirming your address.',
                            ),
                          ],
                        ),
                      ),
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
            child: _CheckoutCta(onGo: onGo, total: total),
          ),
        ),
      ],
    );
  }
}

class _CheckoutCta extends StatelessWidget {
  const _CheckoutCta({required this.onGo, required this.total});
  final ValueChanged<Screen> onGo;
  final int total;
  @override
  Widget build(BuildContext context) {
    return ChowButton(
      onTap: () => onGo(Screen.payment),
      child: Text('Place order · ${naira(total)}'),
    );
  }
}

class _FeeRow extends StatelessWidget {
  const _FeeRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 11)),
          Text(
            value,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.selected});
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: selected ? ChowColors.orange : ChowColors.border,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on, size: 22, color: ChowColors.orange),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HOME · DEFAULT',
                  style: TextStyle(
                    color: ChowColors.orange,
                    fontSize: 7,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Ada Okafor',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 2),
                Text(
                  '24 Akin Adesola Street, Victoria Island, Lagos',
                  style: TextStyle(
                    fontSize: 9,
                    height: 1.45,
                    color: ChowColors.muted,
                  ),
                ),
                Text(
                  '+234 801 234 5678',
                  style: TextStyle(fontSize: 9, color: ChowColors.muted),
                ),
              ],
            ),
          ),
          Icon(Icons.check, size: 17, color: ChowColors.green),
        ],
      ),
    );
  }
}

/// Saved-address picker.
class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key, required this.onGo});
  final ValueChanged<Screen> onGo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      child: Column(
        children: [
          ChowTopBar(
            title: 'Choose address',
            onBack: () => onGo(Screen.checkout),
          ),
          const SizedBox(height: 12),
          _SelectableAddress(
            label: 'HOME · DEFAULT',
            selected: true,
            icon: Icons.location_on,
            lines: '24 Akin Adesola Street, Victoria Island, Lagos',
            onTap: () => onGo(Screen.checkout),
          ),
          _SelectableAddress(
            label: 'WORK',
            selected: false,
            icon: Icons.store,
            lines: '4 Bourdillon Road, Ikoyi, Lagos',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          ChowButton(
            secondary: true,
            onTap: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 19),
                SizedBox(width: 6),
                Text('Add a new address'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectableAddress extends StatelessWidget {
  const _SelectableAddress({
    required this.label,
    required this.selected,
    required this.icon,
    required this.lines,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final IconData icon;
  final String lines;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: selected ? ChowColors.orange : ChowColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 22, color: ChowColors.orange),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: ChowColors.orange,
                      fontSize: 7,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Ada Okafor',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    lines,
                    style: const TextStyle(
                      fontSize: 9,
                      height: 1.45,
                      color: ChowColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? ChowColors.orange : Colors.transparent,
                border: Border.all(
                  color: selected ? ChowColors.orange : ChowColors.border,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 13, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
