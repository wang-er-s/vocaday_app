
import '../repositories/auth_repository.dart';

class AuthStateChangedUsecase {
  final AuthRepository repository;

  AuthStateChangedUsecase({required this.repository});

  Stream<dynamic> get user => repository.user;
}
