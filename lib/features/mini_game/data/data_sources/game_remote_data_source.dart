import '../../../../app/adapters/bmob_database_adapter.dart';
import '../../../../core/errors/exception.dart';

abstract class GameRemoteDataSource {
  Future<void> updateUserPoint(String uid, Map<String, dynamic> map);
  Future<void> updateUserGold(String uid, Map<String, dynamic> map);
}

class GameRemoteDataSourceImpl implements GameRemoteDataSource {
  final BmobDatabaseAdapter _db;
  final String _users = "UserProfile"; // 使用与用户资料相同的表

  GameRemoteDataSourceImpl(this._db);

  @override
  Future<void> updateUserPoint(String uid, Map<String, dynamic> map) async {
    try {
      await _db.collection(_users).doc(uid).update(map);
    } catch (e) {
      throw DatabaseException('更新用户积分失败: $e');
    }
  }

  @override
  Future<void> updateUserGold(String uid, Map<String, dynamic> map) async {
    try {
      await _db.collection(_users).doc(uid).update(map);
    } catch (e) {
      throw DatabaseException('更新用户金币失败: $e');
    }
  }
}
