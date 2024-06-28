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
        super(const AuthenticationState.unknown()) {
    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);

    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User>? _userSubscription;

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      event.user != User.empty
          ? AuthenticationState.authenticated(event.user)
          : const AuthenticationState.unauthenticated(),
    );
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    unawaited(_authenticationRepository.logOut());
  }
}
