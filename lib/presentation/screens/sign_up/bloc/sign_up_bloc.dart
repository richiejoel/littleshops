import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:littleshops/data/repository/auth/auth_repository.dart';
import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/utils/validators.dart';
import 'package:littleshops/presentation/screens/sign_up/bloc/sign_up_event.dart';
import 'package:littleshops/presentation/screens/sign_up/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {

  final AuthRepository _authRepository = AuthRepository();

  SignUpBloc() : super(SignUpState.empty());

  @override
  Stream<Transition<SignUpEvent, SignUpState>> transformEvents(
      Stream<SignUpEvent> events, transitionFn) {
    var debounceStream = events
        .where((event) =>
    event is EmailChanged ||
        event is PasswordChanged ||
        event is ConfirmPasswordChanged)
        .debounceTime(Duration(milliseconds: 300));

    var nonDebounceStream = events.where((event) =>
    event is! EmailChanged &&
        event is! PasswordChanged &&
        event is! ConfirmPasswordChanged);

    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }


  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(
        event.password,
        event.confirmPassword,
      );
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
        event.newUser,
        event.password,
        event.confirmPassword,
      );
    }
  }


  /// Map from email changed event => states
  Stream<SignUpState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: UtilValidators.isValidEmail(email),
    );
  }

  /// Map from email changed event => states
  Stream<SignUpState> _mapNameChangedToState(String name) async* {
    yield state.update(
      isEmailValid: UtilValidators.isValidName(name),
    );
  }

  /// Map from password changed event => states
  Stream<SignUpState> _mapPasswordChangedToState(String password) async* {
    var isPasswordValid = UtilValidators.isValidPassword(password);

    yield state.update(isPasswordValid: isPasswordValid);
  }

  /// Map from confirmed password changed event => states
  Stream<SignUpState> _mapConfirmPasswordChangedToState(
      String password,
      String confirmPassword,
      ) async* {
    var isConfirmPasswordValid =
    UtilValidators.isValidPassword(confirmPassword);
    var isMatched = true;

    if (password.isNotEmpty) {
      isMatched = password == confirmPassword;
    }

    yield state.update(
      isConfirmPasswordValid: isConfirmPasswordValid && isMatched,
    );
  }

  /// Map from submit event => states
  Stream<SignUpState> _mapFormSubmittedToState(
      UserModel newUser,
      String password,
      String confirmPassword,
      ) async* {
    try {
      yield SignUpState.loading();
      await _authRepository.signUp(newUser, password);

      bool isLoggedIn = _authRepository.isLoggedIn();
      if (isLoggedIn) {
        yield SignUpState.success();
      } else {
        final message = _authRepository.authException;
        yield SignUpState.failure(message);
      }
    } catch (e) {
      yield SignUpState.failure("SignUp Failure");
    }
  }


}