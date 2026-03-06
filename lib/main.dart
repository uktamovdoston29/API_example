import 'package:api_example/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:api_example/src/features/auth/data/source/auth_data_source_impl.dart';
import 'package:api_example/src/features/auth/domain/usecase/auth_login_usercase.dart';
import 'package:api_example/src/features/auth/domain/usecase/auth_register_usecase.dart';
import 'package:api_example/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:api_example/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:api_example/src/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthCubit(
        authLoginUsercase: AuthLoginUsercase(
          authRepository: AuthRepositoryImpl(AuthDataSourceImpl()),
        ),
        authRegisterUsecase: AuthRegisterUsecase(
          authRepository: AuthRepositoryImpl(AuthDataSourceImpl()),
        ),
      ),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: GetStorage().read('refresh') != null
          ? HomeScreen()
          : const SignInScreen(),
    );
  }
}
