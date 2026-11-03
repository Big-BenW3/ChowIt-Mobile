import 'package:flutter/material.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/shell.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

// Profile: identity header plus Account/Services/More rows. Each row
// opens a ServiceScreen page; unshipped features say so honestly instead
// of faking balances or rewards.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.onGo, required this.onService});
  final ValueChanged<Screen> onGo;
  final ValueChanged<String> onService;

  static const _groups = [
    (
      'ACCOUNT',
      [
        ('Personal details', Icons.person, 'Name, username and phone'),
        ('Addresses', Icons.location_on, 'Manage delivery locations'),
        ('Wallet', Icons.account_balance_wallet, 'Coming soon'),
      ],
    ),
    (
      'SERVICES',
      [
        ('Referrals', Icons.group, 'Invite friends, earn treats'),
        ('Vouchers', Icons.percent, '2 available'),
        ('Gift cards', Icons.card_giftcard, 'Redeem a gift code'),
      ],
    ),
    (
      'MORE',
      [
        ('Preferences', Icons.settings, 'Notifications and discovery'),
        ('FAQs', Icons.menu_book, 'Find quick answers'),
        ('Get help', Icons.help_outline, 'We’re here for you'),
        ('Legal', Icons.badge, 'Terms, privacy and policies'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChowShell(
      active: Screen.profile,
      onGo: onGo,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(-20, -10, -20, 0),
            padding: const EdgeInsets.fromLTRB(20, 26, 20, 23),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF1E7),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: Stack(
              children: [
                const Positioned(
                  right: 60,
                  top: 5,
                  child: Icon(
                    Icons.auto_awesome,
                    size: 25,
                    color: Color(0xFFF7B994),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ChowColors.orange,
                          ),
                          child: const Text(
                            'AO',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 21,
                            height: 21,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ChowColors.green,
                              border: Border.all(
                                color: const Color(0xFFFFF1E7),
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Ada Okafor',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '@adaeats · +234 801 234 5678',
                      style: TextStyle(fontSize: 9, color: ChowColors.muted),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xA6FFFFFF),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      size: 21,
                      color: Color(0xFF352F2C),
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (final group in _groups) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 4, top: 20, bottom: 7),
                child: Text(
                  group.$1,
                  style: const TextStyle(
                    color: Color(0xFFA19892),
                    fontSize: 8,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            for (final row in group.$2)
              GestureDetector(
                onTap: () => onService(row.$1),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: ChowColors.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3EB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(row.$2, size: 17, color: ChowColors.orange),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              row.$1,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              row.$3,
                              style: const TextStyle(
                                fontSize: 8,
                                color: ChowColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 15,
                        color: Color(0xFFAAA19B),
                      ),
                    ],
                  ),
                ),
              ),
          ],
          GestureDetector(
            onTap: () => onGo(Screen.welcome),
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 20),
              child: Row(
                children: [
                  Icon(Icons.logout, size: 18, color: ChowColors.danger),
                  SizedBox(width: 9),
                  Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: ChowColors.danger,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Text(
            'ChowIt v1.0 · Made with appetite',
            style: TextStyle(fontSize: 7, color: Color(0xFFB4AAA4)),
          ),
        ],
      ),
    );
  }
}

/// Generic service detail page driven by the selected row.
class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key, required this.onGo, required this.name});
  final ValueChanged<Screen> onGo;
  final String name;
  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final _toggles = [true, true, false, false];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChowTopBar(
            title: widget.name,
            onBack: () => widget.onGo(Screen.profile),
          ),
          const SizedBox(height: 12),
          _body(),
        ],
      ),
    );
  }

  Widget _body() {
    switch (widget.name) {
      case 'Wallet':
        return Column(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(top: 35, bottom: 20),
              decoration: BoxDecoration(
                color: ChowColors.peach,
                borderRadius: BorderRadius.circular(26),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                size: 35,
                color: ChowColors.orange,
              ),
            ),
            const Text(
              'Your ChowIt wallet is coming soon.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                height: 1.3,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'When it launches, you’ll see your balance and activity here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                height: 1.5,
                color: ChowColors.muted,
              ),
            ),
            const SizedBox(height: 17),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: ChowColors.peach,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'COMING SOON',
                style: TextStyle(
                  color: ChowColors.orange,
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      case 'Referrals':
        return Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, bottom: 18),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: ChowColors.darkCard,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFFFFAF82)),
                  const SizedBox(height: 8),
                  const Text(
                    'YOUR REFERRAL CODE',
                    style: TextStyle(
                      color: Color(0xFFFFAF82),
                      fontSize: 8,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 17),
                  const Text(
                    'ADA-EATS-24',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 17),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.copy, size: 14),
                        SizedBox(width: 6),
                        Text(
                          'Copy',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ChowButton(
              onTap: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.share, size: 19),
                  SizedBox(width: 6),
                  Text('Share your code'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ChowColors.peach,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good food is better with friends',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Invite a friend to ChowIt. When the referral programme launches, eligible rewards will appear here.',
                    style: TextStyle(
                      fontSize: 9,
                      height: 1.5,
                      color: ChowColors.muted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 'Vouchers':
        return Column(
          children: [
            _Segmented(
              tabs: const ['Available', 'Used', 'Expired'],
              active: 0,
              onTap: (_) {},
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5ED),
                border: Border.all(color: const Color(0xFFF1C9AE)),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '15% OFF',
                    style: TextStyle(
                      color: ChowColors.orange,
                      fontWeight: FontWeight.w800,
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'A little treat',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Save up to ₦1,500 on orders above ₦5,000.',
                    style: TextStyle(fontSize: 9, color: ChowColors.muted),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0xFFE5BC9F))),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CHOW15',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Expires 31 Aug',
                          style: TextStyle(
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
          ],
        );
      case 'Gift cards':
        return Column(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(top: 35, bottom: 20),
              decoration: BoxDecoration(
                color: ChowColors.peach,
                borderRadius: BorderRadius.circular(26),
              ),
              child: const Icon(
                Icons.card_giftcard,
                size: 35,
                color: ChowColors.orange,
              ),
            ),
            const Text(
              'No gift cards yet',
              style: TextStyle(
                fontSize: 20,
                height: 1.3,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'Got a code? Redeem it below. Buying and sending cards is coming soon.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                height: 1.5,
                color: ChowColors.muted,
              ),
            ),
            const SizedBox(height: 22),
            const ChowField(hint: 'Enter gift card code'),
            const SizedBox(height: 16),
            ChowButton(onTap: () {}, child: const Text('Redeem code')),
          ],
        );
      case 'Preferences':
        const rows = [
          ('Order updates', 'Important updates about your orders'),
          ('Offers and new restaurants', 'Control what you hear from us'),
          ('Recommendations', 'Control what you hear from us'),
          ('Email updates', 'Control what you hear from us'),
        ];
        return Column(
          children: [
            for (var i = 0; i < rows.length; i++)
              GestureDetector(
                onTap: () => setState(() => _toggles[i] = !_toggles[i]),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
                              rows[i].$1,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              rows[i].$2,
                              style: const TextStyle(
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
                          color: _toggles[i]
                              ? ChowColors.orange
                              : const Color(0xFFDDD6D1),
                        ),
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          alignment: _toggles[i]
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
          ],
        );
      case 'FAQs':
        const faqs = [
          'How do I track my order?',
          'Can I change my delivery address?',
          'How are delivery fees calculated?',
          'What happens if an item is unavailable?',
        ];
        return Column(
          children: [
            Container(
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
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search help articles',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9A918B),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            for (final q in faqs)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: ChowColors.border)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        q,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, size: 16),
                  ],
                ),
              ),
          ],
        );
      case 'Get help':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 12, bottom: 25),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: ChowColors.peach,
                borderRadius: BorderRadius.circular(19),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.help_outline, color: ChowColors.orange),
                  SizedBox(height: 10),
                  Text(
                    'How can we help?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tell us what happened and our support team will get back to you.',
                    style: TextStyle(
                      fontSize: 9,
                      height: 1.5,
                      color: ChowColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            const ChowField(label: 'Topic', hint: 'Choose a topic'),
            const SizedBox(height: 16),
            const ChowField(
              label: 'Order reference (optional)',
              hint: '#CHW-24018',
            ),
            const SizedBox(height: 16),
            const Text(
              'Message',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: ChowColors.ink,
              ),
            ),
            const SizedBox(height: 7),
            Container(
              height: 100,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ChowColors.border, width: 1.5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Share a few details...',
                  hintStyle: TextStyle(fontSize: 11, color: ChowColors.faint),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ChowButton(onTap: () {}, child: const Text('Send message')),
          ],
        );
      case 'Legal':
        const docs = [
          'Terms of service',
          'Privacy policy',
          'Delivery & cancellation policy',
        ];
        return Column(
          children: [
            const SizedBox(height: 20),
            for (final d in docs)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: ChowColors.border)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Updated 12 June 2025',
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
              ),
          ],
        );
      case 'Personal details':
        return Column(
          children: [
            const SizedBox(height: 12),
            const ChowField(label: 'Full name', hint: 'Ada Okafor'),
            const SizedBox(height: 16),
            const ChowField(label: 'Username', hint: 'adaeats'),
            const SizedBox(height: 16),
            const ChowField(
              label: 'Phone number',
              hint: '801 234 5678',
              prefix: '+234',
              keyboard: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: ChowColors.demoBg,
                border: Border.all(color: ChowColors.demoBorder),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Row(
                children: [
                  Icon(Icons.badge, size: 19, color: ChowColors.demoInk),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Changing your phone number requires verification.',
                      style: TextStyle(fontSize: 9, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ChowButton(onTap: () {}, child: const Text('Save changes')),
          ],
        );
      case 'Addresses':
      default:
        return Column(
          children: [
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ChowColors.border, width: 1.5),
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
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
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
        );
    }
  }
}

class _Segmented extends StatelessWidget {
  const _Segmented({
    required this.tabs,
    required this.active,
    required this.onTap,
  });
  final List<String> tabs;
  final int active;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
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
                onTap: () => onTap(i),
                child: Container(
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: active == i ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tabs[i],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: active == i ? ChowColors.orange : ChowColors.ink,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
