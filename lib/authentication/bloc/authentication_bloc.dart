import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationUnauthenticated()) {
    on<AuthenticationUserInfoChanged>(_onAuthenticationUserChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _userSubscription = _authenticationRepository.userInfo.listen(
      (user) => add(AuthenticationUserInfoChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<UserInfo>? _userSubscription;

  Future<void> _onAuthenticationUserChanged(
    AuthenticationUserInfoChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      event.userInfo == UserInfo.empty
          ? const AuthenticationUnauthenticated()
          : AuthenticationAuthenticated(event.userInfo),
    );
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
