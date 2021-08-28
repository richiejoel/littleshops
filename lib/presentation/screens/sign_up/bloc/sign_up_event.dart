import 'package:littleshops/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  List<Object> get props => [];

}

// Evento cambio de name
class NameChanged extends SignUpEvent {
  final String name;

  const NameChanged({required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return 'NameChanged{email: $name}';
  }
}

// Evento cambio de email
class EmailChanged extends SignUpEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'EmailChanged{email: $email}';
  }
}

//Evento cambio de contrasenia
class PasswordChanged extends SignUpEvent {
  final String password;

  PasswordChanged({required this.password});

  @override
  String toString() {
    return 'PasswordChanged{password: $password}';
  }
}

//Evento confirmaion contrasenia
class ConfirmPasswordChanged extends SignUpEvent {
  final String password;
  final String confirmPassword;

  ConfirmPasswordChanged(
      {required this.password, required this.confirmPassword});

  @override
  String toString() {
    return 'ConfirmPasswordChanged{password: $password ,confirmPassword: $confirmPassword}';
  }
}

//SignUp Button
class Submitted extends SignUpEvent {
  final UserModel newUser; // contains new user's information
  final String password;
  final String confirmPassword;

  const Submitted({
    required this.newUser,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [newUser.email];

  @override
  String toString() {
    return 'Submitted{email: ${newUser
        .email}, password: $password, confirmPassword: $confirmPassword}';
  }

}

//Courier
class SubmittedCourier extends SignUpEvent {
  final UserModel newUser; // contains new user's information
  final String password;
  final String confirmPassword;
  final String businessId;

  const SubmittedCourier({
    required this.newUser,
    required this.password,
    required this.confirmPassword,
    required this.businessId
  });

  @override
  List<Object> get props => [newUser.email];

  @override
  String toString() {
    return 'Submitted{email: ${newUser
        .email}, password: $password, confirmPassword: $confirmPassword}';
  }

}