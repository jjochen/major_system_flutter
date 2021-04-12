part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserInfoChanged extends AuthenticationEvent {
  const AuthenticationUserInfoChanged(this.userInfo);

  final UserInfo userInfo;

  @override
  List<Object> get props => [userInfo];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
