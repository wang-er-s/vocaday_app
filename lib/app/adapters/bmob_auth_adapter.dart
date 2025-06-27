import 'dart:async';
import 'package:bmob_plugin/bmob/response/bmob_registered.dart';
import 'package:bmob_plugin/bmob/table/bmob_user.dart';
import 'package:bmob_plugin/bmob/response/bmob_saved.dart';
import 'package:bmob_plugin/bmob/response/bmob_updated.dart';
import 'package:bmob_plugin/bmob/response/bmob_handled.dart';
import 'package:bmob_plugin/bmob/response/bmob_error.dart';

import '../../features/authentication/data/models/bmob_user_model.dart';

/// Bmob 认证适配器
/// 提供与 Firebase Auth 相似的接口
class BmobAuthAdapter {
  /// 当前用户流控制器
  final _userStreamController = StreamController<BmobUserModel?>.broadcast();
  
  /// 当前用户
  BmobUserModel? _currentUser;
  
  /// 获取当前用户
  BmobUserModel? get currentUser => _currentUser;
  
  /// 用户状态变化流
  Stream<BmobUserModel?> get authStateChanges => _userStreamController.stream;
  
  /// 使用账号密码注册
  Future<BmobUserModel> createUserWithUsernameAndPassword({
    required String username,
    required String password,
    String? email,
  }) async {
    try {
      // 创建 Bmob 用户对象
      BmobUser bmobUser = BmobUser();
      bmobUser.username = username;
      bmobUser.password = password;
      if (email != null) {
        bmobUser.email = email;
      }

      // 注册用户
      final BmobRegistered registeredData = await bmobUser.register();
      
      // 创建用户模型
      final userModel = BmobUserModel(
        objectId: registeredData.objectId,
        createdAt: registeredData.createdAt,
        username: username,
        email: email,
        isNewUser: true,
      );
      
      // 更新当前用户状态
      _currentUser = userModel;
      _userStreamController.add(_currentUser);
      
      return userModel;
    } catch (e) {
      throw _handleBmobError(e);
    }
  }
  
  /// 使用账号密码登录
  Future<BmobUserModel> signInWithUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    try {
      // 创建 Bmob 用户对象进行登录
      BmobUser bmobUser = BmobUser();
      bmobUser.username = username;
      bmobUser.password = password;
      
      // 执行登录
      final BmobUser loggedInUser = await bmobUser.login();
      
      // 创建用户模型
      final userModel = BmobUserModel(
        objectId: loggedInUser.objectId,
        createdAt: loggedInUser.createdAt,
        updatedAt: loggedInUser.updatedAt,
        username: loggedInUser.username,
        email: loggedInUser.email,
        isNewUser: false,
      );
      
      // 更新当前用户状态
      _currentUser = userModel;
      _userStreamController.add(_currentUser);
      
      return userModel;
    } catch (e) {
      throw _handleBmobError(e);
    }
  }
  
  /// 退出登录
  Future<void> signOut() async {
    try {
      // 清除当前用户状态
      _currentUser = null;
      _userStreamController.add(null);
      
      // 注意：Bmob SDK 可能没有显式的 logout 方法
      // 主要通过清除本地状态来实现退出
    } catch (e) {
      throw _handleBmobError(e);
    }
  }
  
  /// 更新密码
  Future<void> updatePassword(String oldPassword, String newPassword) async {
    try {
      if (_currentUser == null) {
        throw Exception('用户未登录');
      }
      
      // 获取当前用户对象
      BmobUser bmobUser = BmobUser();
      bmobUser.objectId = _currentUser!.objectId;
      bmobUser.password = newPassword;
      
      // 更新密码
      final BmobUpdated updateResult = await bmobUser.update();
      
      // 密码更新成功，但不需要更新本地用户模型（密码不存储在本地）
    } catch (e) {
      throw _handleBmobError(e);
    }
  }
  
  /// 发送密码重置邮件
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // 创建用户对象用于重置密码
      BmobUser bmobUser = BmobUser();
      bmobUser.email = email;
      
      // 发送密码重置邮件
      final BmobHandled result = await bmobUser.requestPasswordResetByEmail();
      
      // 密码重置邮件发送成功
    } catch (e) {
      throw _handleBmobError(e);
    }
  }
  
  /// 删除用户
  Future<void> deleteUser() async {
    try {
      if (_currentUser == null) {
        throw Exception('用户未登录');
      }
      
      // 创建用户对象进行删除
      BmobUser bmobUser = BmobUser();
      bmobUser.objectId = _currentUser!.objectId;
      
      // 删除用户账户
      final BmobHandled deleteResult = await bmobUser.delete();
      
      // 清除当前用户状态
      _currentUser = null;
      _userStreamController.add(null);
    } catch (e) {
      throw _handleBmobError(e);
    }
  }
  
  /// 获取当前登录用户信息
  Future<BmobUserModel?> getCurrentUser() async {
    try {
      // 注意：Bmob 可能没有直接的 getCurrentUser 方法
      // 这里返回当前缓存的用户信息
      return _currentUser;
    } catch (e) {
      throw _handleBmobError(e);
    }
  }
  
  /// 处理 Bmob 错误
  Exception _handleBmobError(dynamic error) {
    // 如果是 Bmob 错误，尝试提取错误信息
    if (error.toString().contains('BmobError')) {
      try {
        final BmobError? bmobError = BmobError.convert(error);
        if (bmobError != null) {
          return Exception('Bmob 错误 [${bmobError.code}]: ${bmobError.error}');
        } else {
          return Exception('Bmob 操作失败: ${error.toString()}');
        }
      } catch (e) {
        // 如果无法转换为 BmobError，使用通用错误处理
        return Exception('Bmob 操作失败: ${error.toString()}');
      }
    }
    
    // 其他类型的错误
    return Exception('认证操作失败: ${error.toString()}');
  }
  
  /// 释放资源
  void dispose() {
    _userStreamController.close();
  }
} 