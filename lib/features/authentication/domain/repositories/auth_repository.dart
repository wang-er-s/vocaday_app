import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/typedef/typedefs.dart';
import '../entities/auth_entity.dart';

/// 负责账号相关操作
abstract interface class AuthRepository {
  User? get user;
  FutureEither<AuthEntity> signUpWithEmailAndPassword(
    String email,
    String password,
  );
  FutureEither<void> signInWithEmailAndPassword(String email, String password);
  FutureEither<AuthEntity> signInWithPhone(String phone);
  FutureEither<void> signOut();
  FutureEither<void> updatePassword(String password);
  FutureEither<void> reauthenticateWithCredential(
    String email,
    String password,
  );
  FutureEither<void> sendCodeToEmail(String email);
  FutureEither<void> deleteUserAuth();
}
