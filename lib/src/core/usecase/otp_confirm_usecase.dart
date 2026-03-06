import 'package:api_example/src/core/either/either.dart';
import 'package:api_example/src/core/failure/failure.dart';
import 'package:api_example/src/core/usecase/use_case.dart';
import 'package:api_example/src/features/auth/domain/repository/auth_repository.dart';

class OtpConfirmUsecase extends UseCase<String, Map<String, dynamic>> {
  final AuthRepository authRepository;
  OtpConfirmUsecase({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> params) {
    return authRepository.confirmOTP(otp: params);
  }
}
