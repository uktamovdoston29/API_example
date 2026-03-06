
import 'package:api_example/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:api_example/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:api_example/src/features/auth/presentation/screens/otp_screen.dart';
import 'package:api_example/src/features/auth/widgets/app_button.dart';
import 'package:api_example/src/features/auth/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                "Sign Up",
                textAlign: TextAlign.center,
                style: GoogleFonts.sen(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 3),
              Text(
                "Please sign in to your existing account",
                textAlign: TextAlign.center,
                style: GoogleFonts.sen(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.69,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      AuthInputWidget(
                        title: "Username",
                        hinText: "username",
                        controller: usernameController,
                      ),
                      const SizedBox(height: 12),
                      AuthInputWidget(
                        title: "Email",
                        hinText: "example@gmail.com",
                        controller: emailController,
                      ),
                      const SizedBox(height: 12),
                      AuthInputWidget(
                        title: "Password",
                        hinText: "**********",
                        suffixIcon: const Icon(Icons.remove_red_eye),
                        controller: passwordController,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(""),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(20, 20),
                                ),
                              ),
                            SizedBox(width: 2),
                              Text(
                                "Remember me",
                                style: GoogleFonts.sen(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SizedBox(),
                                ),
                              );
                            },
                            child: Text("Forgot Password"),
                          ),
                        ],
                      ),
                       SizedBox(height: 25),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state.status == AuthStatus.authentificated) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OTPScreen(
                                  email: emailController.text,
                                  username: usernameController.text,
                                  password: passwordController.text,
                                ),
                              ),
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
                          return AppButtonWidget(
                            onPressed: () {
                              context.read<AuthCubit>().register(
                                username: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },
                            text: 'LOG IN',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
