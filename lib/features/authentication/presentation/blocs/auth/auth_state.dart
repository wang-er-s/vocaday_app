part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final dynamic user;
  final bool? isAuthenticating;

  const AuthState(this.user, this.isAuthenticating);

  @override
  List<Object?> get props => [user];
}

final class UnauthenticatedState extends AuthState {
  const UnauthenticatedState() : super(null, false);
}

final class AuthenticatedState extends AuthState {
  const AuthenticatedState({required dynamic user, bool isAuthing = false})
      : super(user, isAuthing);

  AuthenticatedState copyWith({
    dynamic user,
    bool? isAuthenticating,
  }) {
    return AuthenticatedState(
      user: user ?? this.user!,
      isAuthing: isAuthenticating ?? this.isAuthenticating ?? false,
    );
  }
}
