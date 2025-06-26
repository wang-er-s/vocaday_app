import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../core/errors/failure.dart';
import '../../core/typedef/typedefs.dart';
import '../adapters/bmob_storage_adapter.dart';

class CloudStorageService {
  final BmobStorageAdapter _storage;

  CloudStorageService(this._storage);

  String _getFolderAvatar(String uid) => 'users/$uid/avatar';

  FutureEither<bool> deleteUserAvatar(String uid) async {
    try {
      // Bmob 不支持按文件夹删除，这里只返回成功
      // 实际的文件删除需要在上传新头像时覆盖或单独删除
      return const Right(true);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  /// Returns Failure | String url (avatar image url)
  FutureEither<String> uploadUserAvatarImage({
    required String uid,
    required String filePath,
    required String fileName,
    required String fileType,
  }) async {
    try {
      // 使用 Bmob 文件上传
      String url = await _storage.uploadUserAvatar(
        userId: uid,
        filePath: filePath,
        fileName: fileName,
      );

      return Right(url);
    } catch (e) {
      return Left(UnknownFailure('上传用户头像失败: $e'));
    }
  }
}
