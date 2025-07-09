import '../../../../../core/typedef/typedefs.dart';
import '../entities/user_entity.dart';

/// 管理用户数据
abstract interface class UserRepository {
  FutureEither<void> addUserProfile(UserEntity userEntity);

  FutureEither<void> deleteUserProfile(String uid);

  Stream<UserEntity?> getUserData(String uid);

  FutureEither<void> updateUserProfile(UserEntity userEntity);

  FutureEither<bool> addAttendanceDate({
    required String uid,
    required List<DateTime> attendance,
  });

  FutureEither<List<UserEntity>> getListUsers();

  FutureEither<List<String>> syncFavourites({
    required String uid,
    required List<String> favourites,
  });

  FutureEither<void> addKnownWords({
    required String uid,
    required List<String> knowns,
  });

  FutureEither<List<String>> syncKnowns({
    required String uid,
    required List<String> knowns,
  });

  FutureEither<void> removeAllFavourites({required String uid});

  FutureEither<void> removeAllKnowns({required String uid});
}
