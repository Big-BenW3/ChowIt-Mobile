import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/core/nav.dart';
import 'package:my_app/core/theme.dart';
import 'package:my_app/core/widgets.dart';

// Auth journey: sign-in / sign-up, three-state forgot password, four-box
// code entry, and first-time address setup with a Home/Work/Other picker.
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.signup, required this.onGo});
  final bool signup;
  final ValueChanged<Screen> onGo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChowTopBar(title: '', onBack: () => onGo(Screen.welcome)),
          const Center(child: ChowLogo(compact: true)),
          const SizedBox(height: 36),
          ChowEyebrow(text: signup ? 'JOIN CHOWIT' : 'WELCOME BACK'),
          const SizedBox(height: 9),
          Text(
            signup ? 'Create your account' : 'Good to see you again',
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
            signup
                ? 'A few details and you’ll be ready to order.'
                : 'Sign in to keep your favourites and orders close.',
            style: const TextStyle(
              fontSize: 14,
              height: 1.55,
              color: ChowColors.muted,
            ),
          ),
          const SizedBox(height: 30),
          if (signup) ...[
            const ChowField(label: 'Full name', hint: 'Ada Okafor'),
            const SizedBox(height: 16),
            const ChowField(label: 'Username', hint: 'adaeats'),
            const SizedBox(height: 16),
          ],
          const ChowField(
            label: 'Phone number',
            hint: '801 234 5678',
            prefix: '+234',
            keyboard: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          const ChowField(
            label: 'Password',
            hint: 'Enter your password',
            obscure: true,
          ),
          if (signup) ...[
            const SizedBox(height: 16),
            const ChowField(
              label: 'Confirm password',
              hint: 'Repeat your password',
              obscure: true,
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Icon(Icons.badge, size: 16, color: ChowColors.green),
                SizedBox(width: 7),
                Expanded(
                  child: Text(
                    'Use at least 8 characters and a number.',
                    style: TextStyle(fontSize: 11, color: ChowColors.muted),
                  ),
                ),
              ],
            ),
          ],
          if (!signup)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => onGo(Screen.forgot),
                child: const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: ChowColors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 24),
          ChowButton(
            onTap: () => onGo(signup ? Screen.verify : Screen.home),
            child: Text(signup ? 'Create account' : 'Sign in'),
          ),
          const SizedBox(height: 22),
          GestureDetector(
            onTap: () => onGo(signup ? Screen.signin : Screen.signup),
            behavior: HitTestBehavior.opaque,
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 12, color: ChowColors.ink),
                  children: [
                    TextSpan(
                      text: signup
                          ? 'Already have an account? '
                          : 'New to ChowIt? ',
                    ),
                    TextSpan(
                      text: signup ? 'Sign in' : 'Create account',
                      style: const TextStyle(
                        color: ChowColors.orange,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Three-state forgot-password flow.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key, required this.onGo});
  final ValueChanged<Screen> onGo;
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _sent = false;
  bool _updated = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChowTopBar(
            title: 'Reset password',
            onBack: () => widget.onGo(Screen.signin),
          ),
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.only(top: 35, bottom: 22),
            decoration: BoxDecoration(
              color: ChowColors.peach,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Icon(
              _updated ? Icons.check : Icons.lock_outline,
              size: 35,
              color: ChowColors.orange,
            ),
          ),
          if (_updated) ...[
            const Text(
              'Password updated',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.1,
                color: ChowColors.ink,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your new password is ready. You can sign in securely now.',
              style: TextStyle(
                fontSize: 14,
                height: 1.55,
                color: ChowColors.muted,
              ),
            ),
            const SizedBox(height: 26),
            ChowButton(
              onTap: () => widget.onGo(Screen.signin),
              child: const Text('Back to sign in'),
            ),
          ] else if (_sent) ...[
            const Text(
              'Create a new password',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.1,
                color: ChowColors.ink,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'We verified the code sent to +234 801 ••• 5678.',
              style: TextStyle(
                fontSize: 14,
                height: 1.55,
                color: ChowColors.muted,
              ),
            ),
            const SizedBox(height: 28),
            const ChowField(
              label: 'New password',
              hint: 'At least 8 characters',
              obscure: true,
            ),
            const SizedBox(height: 16),
            const ChowField(
              label: 'Confirm password',
              hint: 'Repeat your password',
              obscure: true,
            ),
            const SizedBox(height: 26),
            ChowButton(
              onTap: () => setState(() => _updated = true),
              child: const Text('Update password'),
            ),
          ] else ...[
            const Text(
              'Forgot your password?',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.1,
                color: ChowColors.ink,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Enter your phone number and we’ll send you a secure reset code.',
              style: TextStyle(
                fontSize: 14,
                height: 1.55,
                color: ChowColors.muted,
              ),
            ),
            const SizedBox(height: 28),
            const ChowField(
              label: 'Phone number',
              hint: '801 234 5678',
              prefix: '+234',
              keyboard: TextInputType.phone,
            ),
            const SizedBox(height: 26),
            ChowButton(
              onTap: () => setState(() => _sent = true),
              child: const Text('Send reset code'),
            ),
          ],
        ],
      ),
    );
  }
}

/// Four-box OTP entry with resend countdown.
class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.onGo});
  final ValueChanged<Screen> onGo;
  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _controllers = List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllers[0].text = '4';
    _controllers[1].text = '8';
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChowTopBar(
            title: 'Verify phone',
            onBack: () => widget.onGo(Screen.signup),
          ),
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.only(top: 35, bottom: 22),
            decoration: BoxDecoration(
              color: ChowColors.peach,
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Icon(
              Icons.lock_outline,
              size: 35,
              color: ChowColors.orange,
            ),
          ),
          const Text(
            'Enter your code',
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.1,
              color: ChowColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'We sent a 4-digit code to +234 801 ••• 5678',
            style: TextStyle(
              fontSize: 14,
              height: 1.55,
              color: ChowColors.muted,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              for (var i = 0; i < 4; i++) ...[
                Expanded(
                  child: Container(
                    height: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ChowColors.border, width: 1.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _controllers[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: ChowColors.ink,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                if (i < 3) const SizedBox(width: 12),
              ],
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: ChowColors.muted, fontSize: 13),
                children: [
                  TextSpan(text: 'Resend code in '),
                  TextSpan(
                    text: '00:42',
                    style: TextStyle(
                      color: ChowColors.ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 26),
          ChowButton(
            onTap: () => widget.onGo(Screen.address),
            child: const Text('Verify & continue'),
          ),
        ],
      ),
    );
  }
}

/// First-time delivery address form with label picker.
class AddressSetupScreen extends StatefulWidget {
  const AddressSetupScreen({super.key, required this.onGo});
  final ValueChanged<Screen> onGo;
  @override
  State<AddressSetupScreen> createState() => _AddressSetupScreenState();
}

class _AddressSetupScreenState extends State<AddressSetupScreen> {
  int _label = 0;

  @override
  Widget build(BuildContext context) {
    const labels = ['Home', 'Work', 'Other'];
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChowTopBar(
            title: 'Delivery address',
            onBack: () => widget.onGo(Screen.verify),
          ),
          const SizedBox(height: 12),
          const Text(
            'Where should we bring your food?',
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
            'Save an address for quicker checkout.',
            style: TextStyle(
              fontSize: 14,
              height: 1.55,
              color: ChowColors.muted,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF3EEE9),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                for (var i = 0; i < labels.length; i++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _label = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _label == i
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: _label == i
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
                          labels[i],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _label == i
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
          const SizedBox(height: 24),
          const ChowField(label: 'Recipient name', hint: 'Ada Okafor'),
          const SizedBox(height: 16),
          const ChowField(
            label: 'Phone number',
            hint: '801 234 5678',
            prefix: '+234',
            keyboard: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          const ChowField(
            label: 'Street address',
            hint: '24 Akin Adesola Street',
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: ChowField(label: 'Apartment', hint: 'Flat 4B'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ChowField(label: 'City', hint: 'Lagos'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const ChowField(label: 'Landmark', hint: 'Opposite the pharmacy'),
          const SizedBox(height: 16),
          const ChowField(
            label: 'Delivery instructions',
            hint: 'Call when you arrive',
          ),
          const SizedBox(height: 26),
          ChowButton(
            onTap: () => widget.onGo(Screen.home),
            child: const Text('Save address & continue'),
          ),
        ],
      ),
    );
  }
}
