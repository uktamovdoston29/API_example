// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:api_example/src/features/auth/domain/repository/auth_repository.dart';
import 'package:api_example/src/core/utils/either/either.dart';
import 'package:api_example/src/core/utils/failure/failure.dart';
import 'package:api_example/src/core/utils/usecase/use_case.dart';

class AuthLoginUsercase extends UseCase<String, Map<String, dynamic>> {
  AuthRepository authRepository;
  AuthLoginUsercase({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> params) {
    return authRepository.login(userInfo: params);
  }
}
