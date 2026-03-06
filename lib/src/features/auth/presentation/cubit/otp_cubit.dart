import 'package:api_example/src/core/utils/usecase/otp_confirm_usecase.dart';
import 'package:api_example/src/features/auth/presentation/cubit/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Cubit<OTPState> {
  OtpConfirmUsecase otpConfirmUsecase;

  OtpCubit({required this.otpConfirmUsecase}) : super(OTPState());
  Future<void> confirmOTP({required String email, required String code}) async {
    emit(OTPState(status: OTPStatus.loading));
    final result = await otpConfirmUsecase.call({
      "email": email,
      "code": code.replaceAll(" ", ""),
    });
    if (result.isRight) {
      emit(OTPState(status: OTPStatus.authentificate));
    } else {
      emit(OTPState(status: OTPStatus.error, errorText: result.left.message));
    }
  }
}
