import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/auth_entity.dart';

enum SignInMethod { none, email, phone }

class AuthModel extends Equatable {
  final String uid;
  final User user;
  final bool isNewUser;
  final SignInMethod signInMethod;

  const AuthModel({
    required this.uid,
    required this.user,
    this.isNewUser = false,
    this.signInMethod = SignInMethod.none,
  });

  AuthModel copyWith({
    String? uid,
    User? user,
    bool? isNewUser,
    SignInMethod? signInMethod,
  }) {
    return AuthModel(
      uid: uid ?? this.uid,
      user: user ?? this.user,
      isNewUser: isNewUser ?? this.isNewUser,
      signInMethod: signInMethod ?? this.signInMethod,
    );
  }

  AuthEntity toEntity() => AuthEntity(
    uid: uid,
    user: user,
    isNewUser: isNewUser,
    signInMethod: signInMethod,
  );

  AuthModel fromEntity(AuthEntity entity) => AuthModel(
    uid: entity.uid,
    user: entity.user,
    isNewUser: entity.isNewUser,
    signInMethod: entity.signInMethod,
  );

  @override
  List<Object?> get props => [uid, user, isNewUser, signInMethod];
}
