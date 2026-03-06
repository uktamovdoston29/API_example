import 'package:api_example/src/features/auth/domain/usecase/auth_login_usercase.dart';
import 'package:api_example/src/features/auth/domain/usecase/auth_register_usecase.dart';
import 'package:api_example/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:api_example/src/core/utils/services/storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRegisterUsecase authRegisterUsecase;
  AuthLoginUsercase authLoginUsercase;

  AuthCubit({
    required this.authRegisterUsecase,
    required this.authLoginUsercase,
  }) : super(AuthState(status: AuthStatus.intial));

  Future<void> register({
    required String username,
    required String password,
    required String email,
  }) async {
    try {
      emit(AuthState(status: AuthStatus.loading));
      final result = await authRegisterUsecase.call({
        "username": username,
        "email": email,
        "password": password,
      });

      if (result.isRight) {
        print('JWT TOKEN ${result.right}');
        await StorageService.write('token', result.right);
        emit(AuthState(status: AuthStatus.authentificated));
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.error, errorText: e.toString()));
    }
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    emit(AuthState(status: AuthStatus.loading));
    await Future.delayed(Duration(seconds: 4));
    try {
      final result = await authLoginUsercase.call({
        "username": username,
        "password": password,
      });

      if (result.isRight) {
        await StorageService.write('token', result.right);
        emit(AuthState(status: AuthStatus.authentificated));
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.error, errorText: e.toString()));
    }
  }
}
