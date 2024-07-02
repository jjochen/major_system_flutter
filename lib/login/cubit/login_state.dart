part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.isValid = true,
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus submissionStatus;
  final bool isValid;

  @override
  List<Object> get props => [
        email,
        password,
        submissionStatus,
        isValid,
      ];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? submissionStatus,
    bool? isValid,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      isValid: isValid ?? this.isValid,
    );
  }
}
