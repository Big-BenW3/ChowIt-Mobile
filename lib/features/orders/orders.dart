import 'package:flutter/material.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/shell.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

// Orders: Active/Completed/Cancelled filter, live-status card with a
// pulsing dot, and past orders with reorder. Detail shows the timeline,
// price snapshot, and delivery address.
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key, required this.onGo});
  final ValueChanged<Screen> onGo;
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    const tabs = ['Active', 'Completed', 'Cancelled'];
    return ChowShell(
      active: Screen.orders,
      onGo: widget.onGo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your orders',
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.search,
                  size: 21,
                  color: Color(0xFF352F2C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF3EEE9),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                for (var i = 0; i < tabs.length; i++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _tab = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _tab == i ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: _tab == i
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF2A180B,
                                    ).withValues(alpha: 0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          tabs[i],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: _tab == i
                                ? ChowColors.orange
                                : ChowColors.ink,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          GestureDetector(
            onTap: () => widget.onGo(Screen.orderDetail),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ChowColors.border),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ChowColors.dark,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'MJ',
                          style: TextStyle(
                            color: Color(0xFFFF9F6C),
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mama Jollof',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '#CHW-24018 · Today, 1:24 PM',
                              style: TextStyle(
                                fontSize: 8,
                                color: ChowColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, size: 16),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5ED),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _PulseDot(),
                            SizedBox(width: 7),
                            Text(
                              'Preparing your meal',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: ChowColors.deep,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '25–35 min',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1 item',
                        style: TextStyle(fontSize: 10, color: ChowColors.muted),
                      ),
                      Text(
                        '₦3,300',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const ChowSectionTitle(title: 'Past orders'),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: const SizedBox(
                  width: 58,
                  height: 58,
                  child: ChowImage(url: ChowPhotos.rice),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yellow Bowl',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Delivered · 12 May',
                      style: TextStyle(fontSize: 8, color: ChowColors.muted),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '2 items · ₦7,200',
                      style: TextStyle(fontSize: 8, color: ChowColors.muted),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ChowColors.orange),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Text(
                  'Reorder',
                  style: TextStyle(
                    color: ChowColors.orange,
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PulseDot extends StatefulWidget {
  const _PulseDot();
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.35).animate(_pulse),
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ChowColors.orange,
        ),
      ),
    );
  }
}

/// Order detail with hero, timeline, summary, and address snapshot.
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.onGo});
  final ValueChanged<Screen> onGo;

  static const _steps = [
    ('Confirmed', '1:24 PM', true),
    ('Preparing', 'In progress', true),
    ('Ready for pickup', 'Next', false),
    ('Out for delivery', '', false),
    ('Delivered', '', false),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChowTopBar(
            title: 'Order details',
            onBack: () => onGo(Screen.orders),
            action: const ChowIconButton(
              icon: Icons.help_outline,
              onTap: _noop,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(21),
            decoration: BoxDecoration(
              color: ChowColors.darkCard,
              borderRadius: BorderRadius.circular(19),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ESTIMATED DELIVERY',
                  style: TextStyle(
                    color: Color(0xFFFFAE82),
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '2:05–2:15 PM',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Your meal is being freshly prepared.',
                  style: TextStyle(fontSize: 9, color: Color(0xFFCFC4BD)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const ChowEyebrow(text: 'ORDER #CHW-24018'),
          const SizedBox(height: 5),
          const Text(
            'Mama Jollof',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 19),
          for (var i = 0; i < _steps.length; i++)
            _TimelineRow(
              title: _steps[i].$1,
              subtitle: _steps[i].$2,
              done: _steps[i].$3,
              last: i == _steps.length - 1,
            ),
          const SizedBox(height: 20),
          const Text(
            'Order summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 15),
          const Row(
            children: [
              Text('1×', style: TextStyle(fontSize: 10)),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Smoky party jollof',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Regular',
                      style: TextStyle(fontSize: 9, color: ChowColors.muted),
                    ),
                  ],
                ),
              ),
              Text(
                '₦2,500',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(height: 1, color: ChowColors.border),
          const SizedBox(height: 15),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery & service', style: TextStyle(fontSize: 10)),
              Text(
                '₦800',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
              ),
              Text(
                '₦3,300',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ChowColors.border)),
            ),
            child: const Row(
              children: [
                Icon(Icons.location_on, size: 20, color: ChowColors.orange),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivering to Home',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '24 Akin Adesola Street, Victoria Island',
                        style: TextStyle(fontSize: 9, color: ChowColors.muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ChowButton(
            secondary: true,
            onTap: () {},
            child: const Text('Get help with this order'),
          ),
        ],
      ),
    );
  }
}

void _noop() {}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.title,
    required this.subtitle,
    required this.done,
    required this.last,
  });
  final String title;
  final String subtitle;
  final bool done;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 19,
                height: 19,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: done ? ChowColors.orange : ChowColors.warm,
                  border: Border.all(
                    color: done ? ChowColors.orange : const Color(0xFFD2C8C1),
                    width: 1.5,
                  ),
                ),
                child: done
                    ? const Icon(Icons.check, size: 11, color: Colors.white)
                    : null,
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: 1,
                    color: done ? ChowColors.orange : const Color(0xFFDDD5D0),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 8, color: ChowColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
