import 'package:meta/meta.dart';

@immutable
class SignUpState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? message;

  bool get isFormValid =>
      isEmailValid && isPasswordValid && isConfirmPasswordValid;

  SignUpState(
      {required this.isEmailValid,
        required this.isPasswordValid,
        required this.isConfirmPasswordValid,
        required this.isSubmitting,
        required this.isSuccess,
        required this.isFailure,
        this.message});

  factory SignUpState.empty() {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: "",
    );
  }

  factory SignUpState.loading() {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      message: "Registering ...",
    );
  }

  factory SignUpState.failure(String message) {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSuccess: false,
      isSubmitting: false,
      isFailure: true,
      message: message,
    );
  }

  factory SignUpState.success() {
    return SignUpState(
        isEmailValid: true,
        isPasswordValid: true,
        isConfirmPasswordValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        message: "Register success");
  }

  SignUpState update(
      {bool? isEmailValid, bool? isPasswordValid, bool? isConfirmPasswordValid}) {
    return cloneWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: "",
    );
  }


  SignUpState cloneWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isNameValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? message,
  }) {
    return SignUpState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
      isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'SignUpState{isEmailValid: $isEmailValid, isPasswordValid: $isPasswordValid, isConfirmPasswordValid: $isConfirmPasswordValid, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure}';
  }

}