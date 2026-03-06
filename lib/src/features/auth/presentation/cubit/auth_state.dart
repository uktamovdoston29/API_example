class AuthState {
  AuthStatus status;
  String errorText;
  AuthState({this.status = AuthStatus.intial, this.errorText = ""});
}

// * enum -> ozm type |

enum AuthStatus { intial, loading, error, authentificated, otpSent }
