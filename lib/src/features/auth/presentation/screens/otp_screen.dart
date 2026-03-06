import 'package:api_example/src/core/utils/usecase/otp_confirm_usecase.dart';
import 'package:api_example/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:api_example/src/features/auth/data/source/auth_data_source_impl.dart';
import 'package:api_example/src/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:api_example/src/features/auth/presentation/cubit/otp_state.dart';
import 'package:api_example/src/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPScreen extends StatelessWidget {
  final String email;
  final String username;
  final String password;

  final TextEditingController otpController = TextEditingController();

  OTPScreen({
    super.key,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpCubit(
        otpConfirmUsecase: OtpConfirmUsecase(
          authRepository: AuthRepositoryImpl(AuthDataSourceImpl()),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("OTP Verification")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Email: $email"),
              const SizedBox(height: 16),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "OTP",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              BlocConsumer<OtpCubit, OTPState>(
                listener: (context, state) {
                  if (state.status == OTPStatus.authentificate) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("OTP tasdiqlandi!")),
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  } else if (state.status == OTPStatus.error) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorText)));
                  }
                },
                builder: (context, state) {
                  if (state.status == OTPStatus.loading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      context.read<OtpCubit>().confirmOTP(
                        email: email,
                        code: otpController.text,
                      );
                    },
                    child: Text("Verify OTP"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
