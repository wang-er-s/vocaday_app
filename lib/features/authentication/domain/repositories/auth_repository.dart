import '../../../../../core/typedef/typedefs.dart';
import '../entities/auth_entity.dart';

abstract interface class AuthRepository {
  Stream<dynamic> get user;
  FutureEither<AuthEntity> signUpWithEmailAndPassword(
      String email, String password);
  FutureEither<void> signInWithEmailAndPassword(String email, String password);
  FutureEither<void> signOut();
  FutureEither<void> updatePassword(String password);
  FutureEither<void> reauthenticateWithCredential(
      String email, String password);
  FutureEither<void> sendCodeToEmail(String email);
  FutureEither<void> deleteUserAuth();
}
