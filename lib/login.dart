import 'package:flutter/material.dart';
import 'Dashboard/dashboard.dart';
import 'responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0096FC),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(height: context.rSpace(40)),

                      /// Logo
                      Image.asset(
                        'assets/login.png',
                        height: context.rSpace(120),
                      ),

                      SizedBox(height: context.rSpace(20)),

                      Text(
                        'SCUBE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.rText(26),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: context.rSpace(6)),

                      Text(
                        'Control & Monitoring System',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.rText(14),
                        ),
                      ),

                      /// Pushes bottom container down safely
                      const Expanded(child: SizedBox()),

                      /// Bottom container
                      Container(
                        width: double.infinity,
                        padding: Responsive.symmetric(
                          context,
                          horizontal: 24,
                          vertical: 30,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: context.rText(22),
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: context.rSpace(24)),

                            /// Username
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Username',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: context.rSpace(16),
                                  vertical: context.rSpace(14),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),

                            SizedBox(height: context.rSpace(16)),

                            /// Password with visibility toggle
                            TextField(
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: context.rSpace(16),
                                  vertical: context.rSpace(14),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: context.rSpace(6)),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forget password?',
                                  style: TextStyle(
                                    fontSize: context.rText(12),
                                  ),
                                ),
                              ),
                            ),



                            SizedBox(height: context.rSpace(12)),

                            /// Login button
                            SizedBox(
                              width: double.infinity,
                              height: context.rSpace(48),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0096FC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SCMDashboardPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: context.rText(16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: context.rSpace(24)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don’t have any account? ",
                                  style: TextStyle(
                                    fontSize: context.rText(12),
                                  ),
                                ),
                                Text(
                                  "Register Now",
                                  style: TextStyle(
                                    fontSize: context.rText(12),
                                    color: const Color(0xFF0096FC),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
