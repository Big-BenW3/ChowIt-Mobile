import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/core/data.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/features/cart/cart.dart';
import 'package:my_app/features/home/home.dart';
import 'package:my_app/features/item/item.dart';
import 'package:my_app/features/orders/orders.dart';
import 'package:my_app/features/payment/payment.dart';
import 'package:my_app/features/profile/profile.dart';
import 'package:my_app/main.dart';

void main() {
  test('naira formats with thousands separators', () {
    expect(naira(2500), '₦2,500');
    expect(naira(800), '₦800');
    expect(naira(7200), '₦7,200');
  });

  testWidgets('launch flow reaches home', (tester) async {
    await tester.pumpWidget(const ChowItApp());
    expect(find.text('Good food, made easy.'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1600));
    expect(find.text('Good food is closer than you think.'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Your next favourite meal, sorted.'), findsOneWidget);

    await tester.tap(find.text('Get started'));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Create an account'), findsWidgets);

    await tester.tap(find.text('Create an account').first);
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Create your account'), findsOneWidget);

    await tester.tap(find.text('Create account').last);
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Enter your code'), findsOneWidget);

    await tester.tap(find.text('Verify & continue'));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Where should we bring your food?'), findsOneWidget);

    await tester.tap(find.text('Save address & continue'));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('What can we get you?'), findsOneWidget);
  });

  testWidgets('home renders discovery sections', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomeScreen(onGo: (_) {}, cartCount: 0, onAdd: () {}),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Explore categories'), findsOneWidget);
    expect(find.text('Featured restaurants'), findsOneWidget);
    expect(find.text('ChowIt specials'), findsOneWidget);
    expect(find.text('Good food under ₦2,000'), findsOneWidget);
    expect(find.text('You will love these'), findsOneWidget);
    expect(find.text('Mama Jollof'), findsWidgets);
  });

  testWidgets('item total updates with size choice', (tester) async {
    var added = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ItemScreen(onGo: (_) {}, onAdd: (qty) => added = qty),
        ),
      ),
    );
    expect(find.text('₦2,500'), findsWidgets);

    await tester.tap(find.text('Large'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('₦3,300'), findsWidgets);

    await tester.tap(find.text('Add to order'));
    expect(added, 1);
  });

  testWidgets('cart empty state invites browsing', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartScreen(onGo: (_) {}, count: 0, onCount: (_) {}),
        ),
      ),
    );
    expect(find.text('Your next delicious order starts here.'), findsOneWidget);
    expect(find.text('Browse meals'), findsOneWidget);
  });

  testWidgets('cart with items shows stepper and total', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartScreen(onGo: (_) {}, count: 2, onCount: (_) {}),
        ),
      ),
    );
    expect(find.text('₦5,000'), findsWidgets);
    expect(find.text('Continue to delivery'), findsOneWidget);
  });

  testWidgets('payment method selection and total', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: PaymentScreen(onGo: (_) {}, count: 1)),
      ),
    );
    expect(find.text('How would you like to pay?'), findsOneWidget);
    expect(find.text('Demo payment'), findsOneWidget);

    await tester.tap(find.text('USSD'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Make payment · ₦3,300'), findsOneWidget);
  });

  testWidgets('orders list shows tabs and active card', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: OrdersScreen(onGo: (_) {})),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Your orders'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Preparing your meal'), findsOneWidget);
  });

  testWidgets('profile shows identity and service groups', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileScreen(onGo: (_) {}, onService: (_) {}),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Ada Okafor'), findsOneWidget);
    expect(find.text('ACCOUNT'), findsOneWidget);
    expect(find.text('SERVICES'), findsOneWidget);
    expect(find.text('Log out'), findsOneWidget);
    expect(find.text('ChowIt v1.0 · Made with appetite'), findsOneWidget);
  });

  test('screen enum covers the full journey', () {
    expect(Screen.values.length, 23);
  });
}
