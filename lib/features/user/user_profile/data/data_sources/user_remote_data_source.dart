import '../../../../../app/adapters/bmob_database_adapter.dart';
import '../../../../../core/errors/exception.dart';

abstract interface class UserRemoteDataSource {
  Future<void> addUserProfile({
    required String uid,
    required Map<String, dynamic> map,
  });

  Future<void> deleteUserProfile({required String uid});

  Stream<Map<String, dynamic>?> getUserData(String uid);

  Future<void> updateUserProfile({
    required String uid,
    required Map<String, dynamic> map,
  });

  Future<bool> addAttendanceDate({
    required String uid,
    required Map<String, dynamic> map,
  });

  Future<List<Map<String, dynamic>>> getListUsers();

  Future<List<String>> syncFavourites({
    required String uid,
    required Map<String, dynamic> map,
  });

  Future<List<String>> syncKnowns({
    required String uid,
    required Map<String, dynamic> map,
  });

  Future<void> addKnownWords({
    required String uid,
    required List<String> list,
  });

  Future<void> removeAllFavourites({required String uid});

  Future<void> removeAllKnowns({required String uid});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final String _users = "UserProfile"; // Bmob 表名
  final BmobDatabaseAdapter database;

  UserRemoteDataSourceImpl(this.database);

  @override
  Future<void> addUserProfile({
    required String uid,
    required Map<String, dynamic> map,
  }) async {
    try {
      await database.collection(_users).doc(uid).set(map);
    } catch (e) {
      throw DatabaseException('添加用户资料失败: $e');
    }
  }

  @override
  Stream<Map<String, dynamic>?> getUserData(String uid) async* {
    // TODO: Bmob 实时监听需要根据实际 API 实现
    yield await database.collection(_users).doc(uid).get();
  }

  @override
  Future<void> updateUserProfile({
    required String uid,
    required Map<String, dynamic> map,
  }) async {
    try {
      await database.collection(_users).doc(uid).update(map);
    } catch (e) {
      throw DatabaseException('更新用户资料失败: $e');
    }
  }

  @override
  Future<bool> addAttendanceDate({
    required String uid,
    required Map<String, dynamic> map,
  }) async {
    try {
      await database.collection(_users).doc(uid).update(map);
      return true;
    } catch (e) {
      throw DatabaseException('添加出勤日期失败: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getListUsers() async {
    try {
      final results = await database.collection(_users).get();
      return results;
    } catch (e) {
      throw DatabaseException('获取用户列表失败: $e');
    }
  }

  @override
  Future<List<String>> syncFavourites({
    required String uid,
    required Map<String, dynamic> map,
  }) async {
    try {
      List<String> localList = map['favourites'] as List<String>;
      if (localList.isEmpty) {
        final res = await database.collection(_users).doc(uid).get();
        if (res != null && res['favourites'] != null) {
          localList = List<String>.from(res['favourites']);
        }
      } else {
        await database.collection(_users).doc(uid).update(map);
      }

      return localList;
    } catch (e) {
      throw DatabaseException('同步收藏失败: $e');
    }
  }

  @override
  Future<void> removeAllFavourites({required String uid}) async {
    try {
      await database.collection(_users).doc(uid).update({'favourites': []});
    } catch (e) {
      throw DatabaseException('清空收藏失败: $e');
    }
  }

  @override
  Future<void> removeAllKnowns({required String uid}) async {
    try {
      await database.collection(_users).doc(uid).update({'knowns': []});
    } catch (e) {
      throw DatabaseException('清空已知单词失败: $e');
    }
  }

  @override
  Future<List<String>> syncKnowns({
    required String uid,
    required Map<String, dynamic> map,
  }) async {
    try {
      List<String> localList = map['knowns'] as List<String>;
      if (localList.isEmpty) {
        final res = await database.collection(_users).doc(uid).get();
        if (res != null && res['knowns'] != null) {
          localList = List<String>.from(res['knowns']);
        }
      } else {
        await database.collection(_users).doc(uid).update(map);
      }

      return localList;
    } catch (e) {
      throw DatabaseException('同步已知单词失败: $e');
    }
  }

  @override
  Future<void> deleteUserProfile({required String uid}) async {
    try {
      await database.collection(_users).doc(uid).delete();
    } catch (e) {
      throw DatabaseException('删除用户资料失败: $e');
    }
  }

  @override
  Future<void> addKnownWords({
    required String uid,
    required List<String> list,
  }) async {
    try {
      // 先获取现有的已知单词列表
      final doc = await database.collection(_users).doc(uid).get();
      List<String> currentKnowns = [];
      
      if (doc != null && doc['knowns'] != null) {
        currentKnowns = List<String>.from(doc['knowns']);
      }
      
      // 合并新的单词（去重）
      final Set<String> knownSet = {...currentKnowns, ...list};
      
      // 更新到数据库
      await database.collection(_users).doc(uid).update({
        'knowns': knownSet.toList(),
      });
    } catch (e) {
      throw DatabaseException('添加已知单词失败: $e');
    }
  }
}
