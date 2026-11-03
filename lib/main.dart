import 'dart:async'; // Splash auto-advance timer.
import 'package:flutter/material.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/features/auth/auth.dart';
import 'package:my_app/features/cart/cart.dart';
import 'package:my_app/features/checkout/checkout.dart';
import 'package:my_app/features/home/home.dart';
import 'package:my_app/features/item/item.dart';
import 'package:my_app/features/orders/orders.dart';
import 'package:my_app/features/payment/payment.dart';
import 'package:my_app/features/profile/profile.dart';
import 'package:my_app/features/launch/launch.dart';
import 'package:my_app/features/restaurant/restaurant.dart';
import 'package:my_app/features/search/search.dart';

void main() {
  runApp(const ChowItApp());
}

class ChowItApp extends StatelessWidget {
  const ChowItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChowIt',
      debugShowCheckedModeBanner: false,
      theme: chowTheme(),
      home: const ChowItRoot(),
    );
  }
}

// Root holds the whole journey state: current screen, cart count, the
// confirmation sheet, and the selected service page. Screens are pure
// widgets that report back through callbacks.
class ChowItRoot extends StatefulWidget {
  const ChowItRoot({super.key});
  @override
  State<ChowItRoot> createState() => _ChowItRootState();
}

class _ChowItRootState extends State<ChowItRoot> {
  Screen _screen = Screen.splash;
  int _cartCount = 0;
  int? _sheetQty;
  String _service = 'Wallet';
  Timer? _splashTimer;

  @override
  void initState() {
    super.initState();
    _splashTimer = Timer(
      const Duration(milliseconds: 1500),
      () => _go(Screen.onboarding1),
    );
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    super.dispose();
  }

  void _go(Screen next) {
    if (!mounted || next == _screen) return;
    setState(() => _screen = next);
  }

  void _showAddedSheet() {
    final qty = _sheetQty;
    if (qty == null) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => AddedSheet(
        qty: qty,
        onClose: () {
          setState(() => _sheetQty = null);
          Navigator.pop(context);
        },
        onView: () {
          setState(() => _sheetQty = null);
          Navigator.pop(context);
          _go(Screen.cart);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0.04, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: KeyedSubtree(key: ValueKey(_screen), child: _page()),
        ),
      ),
    );
  }

  Widget _page() {
    switch (_screen) {
      case Screen.splash:
        return const SplashScreen();
      case Screen.onboarding1:
        return OnboardingScreen(second: false, onGo: _go);
      case Screen.onboarding2:
        return OnboardingScreen(second: true, onGo: _go);
      case Screen.welcome:
        return WelcomeScreen(onGo: _go);
      case Screen.signin:
        return AuthScreen(signup: false, onGo: _go);
      case Screen.signup:
        return AuthScreen(signup: true, onGo: _go);
      case Screen.forgot:
        return ForgotPasswordScreen(onGo: _go);
      case Screen.verify:
        return VerifyScreen(onGo: _go);
      case Screen.address:
        return AddressSetupScreen(onGo: _go);
      case Screen.home:
        return HomeScreen(
          onGo: _go,
          cartCount: _cartCount,
          onAdd: () => setState(() => _cartCount++),
        );
      case Screen.search:
        return SearchScreen(onGo: _go, cartCount: _cartCount);
      case Screen.cart:
        return CartScreen(
          onGo: _go,
          count: _cartCount,
          onCount: (n) => setState(() => _cartCount = n),
        );
      case Screen.checkout:
        return CheckoutScreen(onGo: _go, count: _cartCount);
      case Screen.addresses:
        return AddressesScreen(onGo: _go);
      case Screen.payment:
        return PaymentScreen(onGo: _go, count: _cartCount);
      case Screen.processing:
        return ProcessingScreen(onDone: () => _go(Screen.success));
      case Screen.success:
        return SuccessScreen(onGo: _go, count: _cartCount);
      case Screen.orders:
        return OrdersScreen(onGo: _go);
      case Screen.orderDetail:
        return OrderDetailScreen(onGo: _go);
      case Screen.profile:
        return ProfileScreen(
          onGo: _go,
          onService: (name) => setState(() {
            _service = name;
            _screen = Screen.service;
          }),
        );
      case Screen.service:
        return ServiceScreen(onGo: _go, name: _service);
      case Screen.restaurant:
        return RestaurantScreen(onGo: _go);
      case Screen.item:
        return ItemScreen(
          onGo: _go,
          onAdd: (qty) {
            setState(() {
              _cartCount += qty;
              _sheetQty = qty;
            });
            _showAddedSheet();
          },
        );
      // ignore: unreachable_switch_default
      default:
        return WelcomeScreen(onGo: _go);
    }
  }
}
