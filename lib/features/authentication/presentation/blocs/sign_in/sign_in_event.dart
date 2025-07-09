part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

final class RequestSignInEvent extends SignInEvent {
  final String email;
  final String password;

  const RequestSignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class RequestSignInPhoneEvent extends SignInEvent {
  final String phone;

  const RequestSignInPhoneEvent({required this.phone});

  @override
  List<Object> get props => [phone];
}
