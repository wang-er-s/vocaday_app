import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/typedef/typedefs.dart';
import '../../domain/repositories/game_repository.dart';
import '../data_sources/game_remote_data_source.dart';

class GameRepositoryImpl implements GameRepository {
  final GameRemoteDataSource _remoteDataSource;

  GameRepositoryImpl(this._remoteDataSource);

  @override
  FutureEither<void> updateUserPoint(String uid, int point) async {
    try {
      return Right(
        await _remoteDataSource.updateUserPoint(uid, {
          'point': point, // 将由适配器处理增量更新
        }),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'ServerFailure: updateUserPoint'),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  FutureEither<void> updateUserGold(String uid, int gold) async {
    try {
      return Right(
        await _remoteDataSource.updateUserGold(uid, {
          'gold': gold, // 将由适配器处理增量更新
        }),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'ServerFailure: updateUserGold'),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
