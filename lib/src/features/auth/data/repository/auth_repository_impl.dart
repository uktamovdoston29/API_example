import 'package:api_example/src/features/auth/data/source/auth_data_source.dart';
import 'package:api_example/src/features/auth/domain/repository/auth_repository.dart';
import 'package:api_example/src/core/either/either.dart';
import 'package:api_example/src/core/failure/failure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, String>> login({
    required Map<String, dynamic> userInfo,
  }) async {
    try {
      final result = await authDataSource.login(userInfo: userInfo);
      if (result.isRight) {
        return Right(result.right);
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> register({
    required Map<String, dynamic> userInfo,
  }) async {
    try {
      final result = await authDataSource.register(userInfo: userInfo);
      if (result.isRight) {
        return Right(result.right);
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> confirmOTP({
    required Map<String, dynamic> otp,
  }) async {
    try {
      final result = await authDataSource.otp(userInfo: otp);
      if (result.isRight) {
        return Right(result.right);
      } else {
        return Left(Failure());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
