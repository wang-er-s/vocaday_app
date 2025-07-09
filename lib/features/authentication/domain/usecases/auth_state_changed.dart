import 'package:supabase_flutter/supabase_flutter.dart';

import '../repositories/auth_repository.dart';

class AuthStateChangedUsecase {
  final AuthRepository repository;

  AuthStateChangedUsecase({required this.repository});

  User? get user => repository.user;
}
