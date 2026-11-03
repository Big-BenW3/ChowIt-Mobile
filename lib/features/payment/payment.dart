import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/motion.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

// Payment: method picker with an always-visible demo banner (no real
// money moves), then a processing state that advances on its own, then a
// success receipt. The wallet row stays disabled until V2.
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.onGo, required this.count});
  final ValueChanged<Screen> onGo;
  final int count;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _method = 'Card';

  @override
  Widget build(BuildContext context) {
    final total = widget.count * 2500 + 800;
    const methods = [
      ('Card', Icons.credit_card, 'Visa, Mastercard or Verve'),
      ('Bank transfer', Icons.store, 'Transfer from your bank app'),
      ('USSD', Icons.badge, 'Pay with your bank’s USSD code'),
    ];
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 130),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChowTopBar(
                title: 'Payment',
                onBack: () => widget.onGo(Screen.checkout),
              ),
              const SizedBox(height: 20),
              const Text(
                'How would you like to pay?',
                style: TextStyle(
                  fontSize: 29,
                  height: 1.13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.1,
                  color: ChowColors.ink,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Choose a payment method for this order.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.55,
                  color: ChowColors.muted,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: ChowColors.demoBg,
                  border: Border.all(color: ChowColors.demoBorder),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 19,
                      color: ChowColors.demoInk,
                    ),
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
                              text: 'Demo payment ',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            TextSpan(text: 'No money will be charged.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              for (final m in methods)
                GestureDetector(
                  onTap: () => setState(() => _method = m.$1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: _method == m.$1
                          ? const Color(0xFFFFFAF6)
                          : Colors.white,
                      border: Border.all(
                        color: _method == m.$1
                            ? ChowColors.orange
                            : ChowColors.border,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 39,
                          height: 39,
                          decoration: BoxDecoration(
                            color: ChowColors.peach,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Icon(m.$2, size: 19, color: ChowColors.orange),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m.$1,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                m.$3,
                                style: const TextStyle(
                                  fontSize: 8,
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
                            color: _method == m.$1
                                ? ChowColors.orange
                                : Colors.transparent,
                            border: Border.all(color: ChowColors.orange),
                          ),
                          child: _method == m.$1
                              ? const Icon(
                                  Icons.check,
                                  size: 13,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              Opacity(
                opacity: 0.55,
                child: Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ChowColors.border, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      _WalletIcon(),
                      SizedBox(width: 11),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ChowIt wallet',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Coming soon',
                              style: TextStyle(
                                fontSize: 8,
                                color: ChowColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Amount to pay',
                    style: TextStyle(fontSize: 12, color: ChowColors.ink),
                  ),
                  Text(
                    naira(total),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
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
              onTap: () => widget.onGo(Screen.processing),
              child: Text('Make payment · ${naira(total)}'),
            ),
          ),
        ),
      ],
    );
  }
}

class _WalletIcon extends StatelessWidget {
  const _WalletIcon();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 39,
      height: 39,
      decoration: BoxDecoration(
        color: ChowColors.peach,
        borderRadius: BorderRadius.circular(11),
      ),
      child: const Icon(
        Icons.account_balance_wallet,
        size: 19,
        color: ChowColors.orange,
      ),
    );
  }
}

/// Processing state that advances automatically.
class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({super.key, required this.onDone});
  final VoidCallback onDone;
  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spin;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _timer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) widget.onDone();
    });
  }

  @override
  void dispose() {
    _spin.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF8F2),
      padding: const EdgeInsets.all(25),
      child: Stack(
        children: [
          const Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: ChowLogo(compact: true),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 146,
                  height: 146,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ChowColors.peach,
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          size: 50,
                          color: ChowColors.orange,
                        ),
                      ),
                      RotationTransition(
                        turns: _spin,
                        child: const Icon(
                          Icons.refresh,
                          size: 146,
                          color: ChowColors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 27),
                const Text(
                  'Confirming your order...',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    color: ChowColors.ink,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Hang tight. This should only take a moment.',
                  style: TextStyle(fontSize: 11, color: ChowColors.muted),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 13, color: ChowColors.muted),
                SizedBox(width: 5),
                Text(
                  'Secure demo payment',
                  style: TextStyle(fontSize: 9, color: ChowColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Order success with receipt and next actions.
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.onGo, required this.count});
  final ValueChanged<Screen> onGo;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 42, 24, 28),
      child: Container(
        color: const Color(0xFFFFF8F2),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.auto_awesome, size: 14, color: Color(0xFFF0A600)),
                SizedBox(width: 40),
                _ConfettiDot(),
                SizedBox(width: 40),
                Icon(Icons.auto_awesome, size: 14, color: Color(0xFFF0A600)),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 155,
                  height: 155,
                  decoration: const BoxDecoration(
                    color: ChowColors.peach,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(46),
                      bottomLeft: Radius.circular(52),
                      bottomRight: Radius.circular(48),
                    ),
                  ),
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        size: 70,
                        color: ChowColors.orange,
                      ),
                      Positioned(right: 7, top: 12, child: _PinBadge()),
                    ],
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -18),
              child: const PopIn(child: _SuccessBadge()),
            ),
            const Text(
              'Order placed!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: ChowColors.ink,
              ),
            ),
            const SizedBox(height: 9),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Mama Jollof has received your order and will start preparing it shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  height: 1.5,
                  color: ChowColors.muted,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ChowColors.border),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ORDER REFERENCE',
                            style: TextStyle(
                              fontSize: 7,
                              color: ChowColors.muted,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '#CHW-24018',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'TOTAL',
                            style: TextStyle(
                              fontSize: 7,
                              color: ChowColors.muted,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            naira(count * 2500 + 800),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: ChowColors.border,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 13,
                          color: Color(0xFFA27000),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Demo payment',
                          style: TextStyle(
                            color: Color(0xFFA27000),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            ChowButton(
              onTap: () => onGo(Screen.orderDetail),
              child: const Text('Track my order'),
            ),
            const SizedBox(height: 9),
            ChowButton(
              secondary: true,
              onTap: () => onGo(Screen.home),
              child: const Text('Back to home'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ChowColors.green,
        border: Border.all(color: const Color(0xFFFFF8F2), width: 4),
      ),
      child: const Icon(Icons.check, color: Colors.white, size: 20),
    );
  }
}

class _ConfettiDot extends StatelessWidget {
  const _ConfettiDot();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ChowColors.orange,
      ),
    );
  }
}

class _PinBadge extends StatelessWidget {
  const _PinBadge();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: const Icon(Icons.location_on, size: 25, color: ChowColors.orange),
    );
  }
}
