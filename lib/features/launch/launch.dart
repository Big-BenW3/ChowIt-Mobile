import 'package:flutter/material.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

// Launch flow: splash (auto-advances), two onboarding pages, welcome.
// Art is code-drawn (orbit ring, bag circle) so it works fully offline.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pop;
  late final AnimationController _twinkle;

  @override
  void initState() {
    super.initState();
    _pop = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _twinkle = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pop.dispose();
    _twinkle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF6EF),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: CurvedAnimation(parent: _pop, curve: Curves.easeOutBack),
                child: FadeTransition(opacity: _pop, child: const ChowLogo()),
              ),
              const SizedBox(height: 18),
              const Text(
                'Good food, made easy.',
                style: TextStyle(fontSize: 13, color: ChowColors.muted),
              ),
            ],
          ),
          Positioned(
            top: 200,
            right: 70,
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 0.12).animate(_twinkle),
              child: ScaleTransition(
                scale: Tween(begin: 1.0, end: 1.3).animate(_twinkle),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 26,
                  color: Color(0xFFF6B72F),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Onboarding pages with orbit art / bag art, dots, and actions.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, required this.second, required this.onGo});
  final bool second;
  final ValueChanged<Screen> onGo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: second ? const Color(0xFFFFF8DF) : ChowColors.peach,
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => onGo(Screen.welcome),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: ChowColors.orange,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const ChowLogo(compact: true),
            ],
          ),
          Expanded(child: Center(child: second ? _bagArt() : _orbitArt())),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChowEyebrow(text: second ? 'ORDER YOUR WAY' : 'DISCOVER NEARBY'),
              const SizedBox(height: 9),
              Text(
                second
                    ? 'Your next favourite meal, sorted.'
                    : 'Good food is closer than you think.',
                style: const TextStyle(
                  fontSize: 29,
                  height: 1.13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.1,
                  color: ChowColors.ink,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                second
                    ? 'Customise your order, check the total and get it delivered.'
                    : 'Find restaurants and meals worth looking forward to.',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.55,
                  color: ChowColors.muted,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  _Dot(active: !second),
                  const SizedBox(width: 6),
                  _Dot(active: second),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  if (second)
                    GestureDetector(
                      onTap: () => onGo(Screen.onboarding1),
                      child: Container(
                        width: 54,
                        height: 54,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  Expanded(
                    child: ChowButton(
                      onTap: () =>
                          onGo(second ? Screen.welcome : Screen.onboarding2),
                      child: second
                          ? const Text('Get started')
                          : const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Next'),
                                SizedBox(width: 6),
                                Icon(Icons.arrow_forward, size: 19),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _orbitArt() {
    return SizedBox(
      width: 270,
      height: 270,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 270,
            height: 270,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFEFB08D),
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: -0.09),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOut,
            builder: (_, rotation, child) =>
                Transform.rotate(angle: rotation, child: child),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(55),
                bottomLeft: Radius.circular(52),
                bottomRight: Radius.circular(48),
              ),
              child: const SizedBox(
                width: 215,
                height: 215,
                child: ChowImage(url: ChowPhotos.hero),
              ),
            ),
          ),
          Positioned(left: 0, bottom: 45, child: _badge('25 min', null)),
          Positioned(
            right: 0,
            top: 45,
            child: _badge(
              '4.9',
              const Icon(Icons.star, size: 13, color: Color(0xFFB57D04)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Widget? icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA64D21).withValues(alpha: 0.13),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon, const SizedBox(width: 3)],
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget _bagArt() {
    return Container(
      width: 230,
      height: 230,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFFFF4BF),
      ),
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.shopping_bag, size: 110, color: ChowColors.orange),
          Positioned(
            right: 20,
            top: 25,
            child: Icon(Icons.location_on, size: 52, color: Colors.white),
          ),
          Positioned(bottom: 22, child: _PillLabel(text: 'Fresh & warm')),
        ],
      ),
    );
  }
}

class _PillLabel extends StatelessWidget {
  const _PillLabel({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF66512B),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.active});
  final bool active;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: active ? 24 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active ? ChowColors.orange : const Color(0xFFD8C7BD),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

/// Welcome with hero art, dual CTAs, and legal line.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.onGo});
  final ValueChanged<Screen> onGo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFAF6),
      padding: const EdgeInsets.fromLTRB(22, 40, 22, 24),
      child: Column(
        children: [
          const ChowLogo(compact: true),
          const SizedBox(height: 12),
          SizedBox(
            width: 275,
            height: 275,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(45),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(48),
                  ),
                  child: const SizedBox(
                    width: 275,
                    height: 275,
                    child: ChowImage(url: ChowPhotos.platter),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 35,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF4B2712,
                          ).withValues(alpha: 0.09),
                          blurRadius: 22,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 15,
                          color: ChowColors.orange,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Made for cravings',
                          style: TextStyle(
                            color: ChowColors.orange,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'What are you craving today?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 29,
              height: 1.13,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.1,
              color: ChowColors.ink,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Let’s find something delicious.',
            style: TextStyle(fontSize: 14, color: ChowColors.muted),
          ),
          const Spacer(),
          ChowButton(
            onTap: () => onGo(Screen.signup),
            child: const Text('Create an account'),
          ),
          const SizedBox(height: 10),
          ChowButton(
            secondary: true,
            onTap: () => onGo(Screen.signin),
            child: const Text('I already have an account'),
          ),
          const SizedBox(height: 14),
          const Text(
            'By continuing, you agree to our Terms and Privacy Policy.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ChowColors.muted,
              fontSize: 10,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
