import 'package:bloc/bloc.dart';
import 'package:littleshops/data/repository/auth/auth_repository.dart';
import 'package:littleshops/presentation/common_blocs/authentication/authentication_event.dart';
import 'package:littleshops/presentation/common_blocs/authentication/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository = AuthRepository();

  AuthenticationBloc() : super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      bool isLoggedIn = _authRepository.isLoggedIn();

      //For display splash screen
      await Future.delayed(Duration(seconds: 5));

      if (isLoggedIn) {
        // Get current user
        final loggedFirebaseUser = _authRepository.loggedFirebaseUser;
        yield Authenticated(loggedFirebaseUser);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(_authRepository.loggedFirebaseUser);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _authRepository.logOut();
  }
}