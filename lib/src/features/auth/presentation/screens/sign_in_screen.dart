import 'package:api_example/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:api_example/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:api_example/src/features/auth/widgets/app_button.dart';
import 'package:api_example/src/features/auth/widgets/app_text_field.dart';
import 'package:api_example/src/features/home/presentation/home_screen.dart';
import 'package:api_example/src/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Text(
                "Sign In",
                textAlign: TextAlign.center,
                style: GoogleFonts.sen(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "Please sign in to your existing account",
                textAlign: TextAlign.center,
                style: GoogleFonts.sen(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    AuthInputWidget(
                      title: "Username",
                      hinText: "username",
                      controller: usernameController,
                    ),
                    const SizedBox(height: 12),
                    AuthInputWidget(
                      title: "Password",
                      hinText: "**********",
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      controller: passwordController,
                    ),
                    const SizedBox(height: 24),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state.status == AuthStatus.authentificated) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        } else if (state.status == AuthStatus.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorText)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state.status == AuthStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          children: [
                            AppButtonWidget(
                              onPressed: () {
                                context.read<AuthCubit>().logIn(
                                      username: usernameController.text,
                                      password: passwordController.text,
                                    );
                              },
                              text: 'LOG IN',
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const LogInScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Don't have an account? Sign Up",
                                style: GoogleFonts.sen(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

