import 'dart:async';

import '../../../../app/adapters/bmob_auth_adapter.dart';
import '../../../../core/errors/exception.dart';
import '../../../../config/app_logger.dart';
import '../models/auth_model.dart';
import '../models/bmob_user_model.dart';

abstract interface class AuthRemoteDataSource {
  /// Throw [ServerException] for all errors
  Stream<BmobUserModel?> get user;
  Future<AuthModel> signUpWithEmailAndPassword(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> updatePassword(String password);
  Future<void> reauthenticateWithCredential(String email, String password);
  Future<void> sendCodeToEmail(String email);
  Future<void> deleteUserAuth();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final BmobAuthAdapter _authAdapter;

  AuthRemoteDataSourceImpl(this._authAdapter);

  @override
  Stream<BmobUserModel?> get user => _authAdapter.authStateChanges;

  @override
  Future<AuthModel> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // 使用 email 作为用户名（Bmob 使用用户名登录）
      final username = email.split('@').first;
      
      final bmobUser = await _authAdapter.createUserWithUsernameAndPassword(
        username: username,
        password: password,
        email: email,
      );

      final authModel = AuthModel(
        uid: bmobUser.objectId!,
        user: bmobUser,
      ).copyWith(
        isNewUser: true,
        signInMethod: SignInMethod.email,
      );

      return authModel;
    } catch (e) {
      logger.e('注册失败: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      // 使用 email 作为用户名（Bmob 使用用户名登录）
      final username = email.split('@').first;
      
      await _authAdapter.signInWithUsernameAndPassword(
        username: username,
        password: password,
      );
    } catch (e) {
      logger.e('登录失败: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authAdapter.signOut();
    } catch (e) {
      logger.e('退出登录失败: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> reauthenticateWithCredential(
      String email, String password) async {
    try {
      // Bmob 不需要重新认证，直接验证密码
      final username = email.split('@').first;
      await _authAdapter.signInWithUsernameAndPassword(
        username: username,
        password: password,
      );
    } catch (e) {
      logger.e('重新认证失败: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updatePassword(String password) async {
    try {
      // 需要先获取旧密码，这里暂时使用一个固定的实现
      // 实际使用时需要根据具体需求调整
      throw UnimplementedError('更新密码功能需要旧密码，请使用其他方式实现');
    } catch (e) {
      logger.e('更新密码失败: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> sendCodeToEmail(String email) async {
    try {
      await _authAdapter.sendPasswordResetEmail(email);
    } catch (e) {
      logger.e('发送重置密码邮件失败: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteUserAuth() async {
    try {
      await _authAdapter.deleteUser();
    } catch (e) {
      logger.e('删除用户失败: $e');
      throw ServerException(e.toString());
    }
  }
}
