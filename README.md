# ChowIt mobile app

Flutter app for the ChowIt customer experience. The project is a single-screen-flow front-end built around a stateful root navigator that moves the user through onboarding, sign-in, address setup, discovery, cart, checkout, payment, and order tracking.

## What this app does

The mobile experience covers the main food-ordering flow:

- splash and onboarding screens
- welcome, sign in, sign up, OTP verification, and password recovery
- address setup and service selection
- home feed, restaurant browsing, menu item view, and search
- cart management and checkout flow
- payment processing and success confirmation
- order history and order detail screens
- profile screen with service pages

This is a UI-oriented Flutter prototype that wires multiple feature screens together under one root state machine rather than a full app architecture with API clients or app state management libraries.

## Stack

- Flutter SDK
- Dart
- Material Design widgets
- custom app theme and motion styling

## App architecture

The implementation is intentionally compact and screen-first:

- `lib/main.dart` — bootstraps the app and owns the top-level navigation state for the journey.
- `lib/core/theme.dart` — app visual styling and brand palette.
- `lib/core/nav.dart` — navigation state definitions for the app screens.
- `lib/core/widgets.dart` — shared UI widgets used across screens.
- `lib/core/shell.dart` — shell-level composition for app layout and transitions.
- `lib/features/` — domain screens and feature modules, including auth, home, cart, checkout, payment, restaurant, search, orders, launch, and profile.

## Screen flow

The app uses a central `Screen` enum and toggles between states in `ChowItRoot`:

```dart
Screen.splash
-> Screen.onboarding1 / onboarding2
-> Screen.welcome
-> Screen.signin / signup / forgot / verify
-> Screen.address
-> Screen.home
-> Screen.search / restaurant / item
-> Screen.cart
-> Screen.checkout
-> Screen.payment
-> Screen.processing
-> Screen.success
-> Screen.orders / orderDetail
-> Screen.profile / service
```

The root widget also tracks:

- current screen selection
- cart count
- quantity sheet state for add-to-cart confirmation
- selected service label for the services screen

## Project layout

```text
MOBILE/my_app/
├── lib/
│   ├── core/
│   ├── features/
│   ├── main.dart
│   └── ...
├── android/
├── ios/
├── web/
├── linux/
├── macos/
├── windows/
├── test/
├── pubspec.yaml
├── analysis_options.yaml
├── README.md
├── widget_test.dart
└── ...
```

## Local setup

From `MOBILE/my_app/`:

```bash
flutter pub get
flutter run
```

For a specific device or simulator:

```bash
flutter devices
flutter run -d <device-id>
```

## Scripts and validation

Useful commands:

```bash
flutter analyze
flutter test
flutter run
flutter build apk
flutter build ios
```

## Design and interaction patterns

This app uses a clean, app-like flow with a polished root transition system:

- fade + slide transitions between screens
- `AnimatedSwitcher` to smooth route changes
- custom app theme for consistent brand styling
- modal bottom sheet confirmation after adding an item to the cart
- screen-level callbacks that pass state upward to the root container

## Notes

This project is a front-end prototype and not yet a full production Flutter architecture. It is structured for product demo and interactive flow validation rather than a full layered design like Redux, Bloc, Riverpod, or repository/service abstractions.

It is meant to work with the backend API in `BACKEND/` for the full customer journey, with the app shell and screens acting as the presentation layer for the ChowIt offering.

## Related project

- `BACKEND/README.md` — API service for the same ChowIt product
- `BACKEND/docs/API_ENDPOINTS.md` — route definitions and product endpoints
