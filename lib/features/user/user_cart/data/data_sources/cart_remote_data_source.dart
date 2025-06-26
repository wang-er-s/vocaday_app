import '../../../../../app/adapters/bmob_database_adapter.dart';
import '../../../../../app/constants/app_const.dart';
import '../../../../../core/errors/exception.dart';

abstract class CartRemoteDataSource {
  Future<void> createCart(String uid, Map<String, dynamic> map);
  Future<Map<String, dynamic>> getCart(String uid);
  Future<void> clearCart(String uid);
  Future<void> updateCart(String uid, Map<String, dynamic> map);
  Future<void> deleteCart(String uid);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final BmobDatabaseAdapter database;
  final String _carts = "Carts"; // Bmob 表名

  CartRemoteDataSourceImpl(this.database);

  @override
  Future<void> createCart(String uid, Map<String, dynamic> map) async {
    try {
            await database.collection(_carts).doc(uid).set(map);
    } catch (e) {
      throw DatabaseException('创建购物车失败: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getCart(String uid) async {
    try {
      final result = await database.collection(_carts).doc(uid).get();
      if (result != null) {
        return result;
      } else {
        throw DatabaseException(AppStringConst.objectNotFoundMessage);
      }
    } catch (e) {
      throw DatabaseException('获取购物车失败: $e');
    }
  }

  @override
  Future<void> clearCart(String uid) async {
    try {
      await database.collection(_carts).doc(uid).update({'bags': []});
    } catch (e) {
      throw DatabaseException('清空购物车失败: $e');
    }
  }

  @override
  Future<void> updateCart(String uid, Map<String, dynamic> map) async {
    try {
      await database.collection(_carts).doc(uid).update(map);
    } catch (e) {
      throw DatabaseException('更新购物车失败: $e');
    }
  }

  @override
  Future<void> deleteCart(String uid) async {
    try {
      await database.collection(_carts).doc(uid).delete();
    } catch (e) {
      throw DatabaseException('删除购物车失败: $e');
    }
  }
}
