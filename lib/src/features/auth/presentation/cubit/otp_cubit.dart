import 'package:api_example/src/core/usecase/otp_confirm_usecase.dart';
import 'package:api_example/src/features/auth/presentation/cubit/otp_event.dart';
import 'package:api_example/src/features/auth/presentation/cubit/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Bloc<OtpEvent, OTPState> {
  OtpConfirmUsecase otpConfirmUsecase;

  OtpCubit({required this.otpConfirmUsecase}) : super(OTPState()) {
    on<VerifyOtpEvent>((event, emit) async {
      emit(OTPState(status: OTPStatus.loading));
      final result = await otpConfirmUsecase.call({
        "email": event.email,
        "code": event.code.replaceAll(" ", ""),
      });
      if (result.isRight) {
        emit(OTPState(status: OTPStatus.authentificate));
      } else {
        emit(OTPState(status: OTPStatus.error, errorText: result.left.message));
      }
    });
    on<OchirishEvent>((event, emit) {
      print('salom ${event.text}');
    });
  }
}
