// * Father -> Ota -> Papa
import 'package:api_example/src/core/utils/either/either.dart';
import 'package:api_example/src/core/utils/failure/failure.dart';

abstract class AuthDataSource {
  // * api function head
  // * readable
  Future<Either<Failure, String>> register({
    required Map<String, dynamic> userInfo,
  });
  Future<Either<Failure, String>> login({
    required Map<String, dynamic> userInfo,
  });
   Future<Either<Failure, String>> otp ({
    required Map<String, dynamic> userInfo,
  });
}
