part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  const AuthenticationUnauthenticated();
}

class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated(this.user);

  final UserInfo user;

  @override
  List<Object> get props => [user];
}
