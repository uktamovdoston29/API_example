// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class OtpEvent {}

class VerifyOtpEvent extends OtpEvent {
  final String email;
  final String code;

  VerifyOtpEvent({required this.email, required this.code});
}

class OchirishEvent extends OtpEvent {
  String text;
  OchirishEvent({
    required this.text,
  });
}
