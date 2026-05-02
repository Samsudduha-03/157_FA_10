import 'package:flutter/material.dart';
import 'signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    // TODO: implement sign in logic
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    debugPrint('Sign In: $email / $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Purple watercolor top banner ──────────────────────────────
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Gradient background
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFB8B0F0),
                        Color(0xFF9B8FE8),
                        Color(0xFFAFA8EE),
                      ],
                    ),
                  ),
                ),
                // Splatter dots
                ..._splatters(context, seed: 55),
              ],
            ),
          ),

          // ── White bottom sheet ────────────────────────────────────────
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────────────
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 32,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 60),

                // Card content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title
                        const Text(
                          'Welcome',
                          style: TextStyle(
                            color: Color(0xFF5B35C5),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                          ),
                        ),

                        const SizedBox(height: 36),

                        // Email field
                        _AuthTextField(
                          controller: _emailController,
                          hint: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 16),

                        // Password field
                        _AuthTextField(
                          controller: _passwordController,
                          hint: 'Password',
                          obscureText: true,
                        ),

                        const SizedBox(height: 36),

                        // Sign In button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5B35C5),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sign Up link
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                    color: Color(0xFF5B35C5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    );
  }

  List<Widget> _splatters(BuildContext context, {required int seed}) {
    final size = MediaQuery.of(context).size;
    int r = seed;
    return List.generate(35, (i) {
      r = (r * 1664525 + 1013904223) & 0xFFFFFFFF;
      final left = (r % size.width.toInt()).toDouble();
      r = (r * 1664525 + 1013904223) & 0xFFFFFFFF;
      final top = (r % 180).toDouble();
      r = (r * 1664525 + 1013904223) & 0xFFFFFFFF;
      final s = 2.0 + (r % 10) * 0.8;
      r = (r * 1664525 + 1013904223) & 0xFFFFFFFF;
      final op = 0.4 + (r % 60) / 100.0;

      return Positioned(
        top: top,
        left: left,
        child: Container(
          width: s,
          height: s,
          decoration: BoxDecoration(
            color: const Color(0xFF4A2C8A).withOpacity(op),
            shape: BoxShape.circle,
          ),
        ),
      );
    });
  }
}

class _AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;

  const _AuthTextField({
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 15, color: Color(0xFF2D2D2D)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 15),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD0C8F0), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF5B35C5), width: 1.8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
