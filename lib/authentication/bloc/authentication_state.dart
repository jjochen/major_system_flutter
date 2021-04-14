part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.userInfo = UserInfo.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(UserInfo userInfo)
      : this._(status: AuthenticationStatus.authenticated, userInfo: userInfo);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final UserInfo userInfo;

  @override
  List<Object> get props => [status, userInfo];
}
