class OTPState {
  final OTPStatus status;
  final String errorText;
  OTPState({this.status = OTPStatus.initial, this.errorText = ""});
  
}


enum OTPStatus { initial, loading, authentificate, error }