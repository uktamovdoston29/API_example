import 'package:api_example/src/core/utils/either/either.dart';
import 'package:api_example/src/core/utils/failure/failure.dart';
import 'package:api_example/src/core/utils/usecase/use_case.dart';
import 'package:api_example/src/features/auth/domain/repository/auth_repository.dart';

class OtpConfirmUsecase extends UseCase<String, Map<String, dynamic>> {
  final AuthRepository authRepository;
  OtpConfirmUsecase({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> params) {
    return authRepository.confirmOTP(otp: params);
  }
}
