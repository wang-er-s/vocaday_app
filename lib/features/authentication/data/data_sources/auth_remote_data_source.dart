import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/errors/exception.dart';
import '../models/auth_model.dart';

abstract interface class AuthRemoteDataSource {
  User? get user;
  Future<AuthModel> signUpWithEmailAndPassword(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<AuthModel> signInWithPhone(String phone);
  Future<void> signOut();
  Future<void> updatePassword(String password);
  Future<void> reauthenticateWithCredential(String email, String password);
  Future<void> sendCodeToEmail(String email);
  Future<void> deleteUserAuth();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabase;

  AuthRemoteDataSourceImpl(this._supabase);

  @override
  User? get user => _supabase.auth.currentUser;

  @override
  Future<AuthModel> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final AuthResponse res = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final User? user = res.user;

      if (user == null) {
        throw ServerException("UserCredential not found.");
      }

      final authModel = AuthModel(
        uid: user.id,
        user: user,
        isNewUser: true,
        signInMethod: SignInMethod.email,
      );

      return authModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final User? user = res.user;

      if (user == null) {
        throw ServerException("UserCredential not found.");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AuthModel> signInWithPhone(String phone) async {
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        phone: phone,
        password: "",
      );
      final Session? session = res.session;
      final User? user = res.user;

      if (user == null) {
        throw ServerException("UserCredential not found.");
      }

      final authModel = AuthModel(
        uid: user.id,
        user: user,
        isNewUser: true,
        signInMethod: SignInMethod.phone,
      );

      return authModel;
    } on PlatformException catch (e) {
      throw ServerException(e.message ?? 'PlatformException');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> reauthenticateWithCredential(
    String email,
    String password,
  ) async {
    try {
      await _supabase.auth.reauthenticate();
    } on UnimplementedError catch (e) {
      throw ServerException(e.message ?? 'reauthenticateWithCredential');
    }
  }

  @override
  Future<void> updatePassword(String password) async {
    try {
      await _supabase.auth.updateUser(UserAttributes(password: password));
    } on UnimplementedError catch (e) {
      throw ServerException(e.message ?? 'reauthenticateWithCredential');
    }
  }

  @override
  Future<void> sendCodeToEmail(String email) async {
    try {
      await _supabase.auth.reauthenticate();
    } on UnimplementedError catch (e) {
      throw ServerException(e.message ?? 'sendCodeToEmail');
    }
  }

  @override
  Future<void> deleteUserAuth() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        await _supabase.auth.admin.deleteUser(user.id);
      }
    } on UnimplementedError catch (e) {
      throw ServerException(e.message ?? 'deleteUserAuth');
    }
  }
}
