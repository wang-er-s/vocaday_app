import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/exception.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/typedef/typedefs.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_sources/cart_remote_data_source.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  FutureEither<void> createCart(String uid, CartEntity entity) async {
    try {
      return Right(
        await remoteDataSource.createCart(
          uid,
          CartModel.fromEntity(entity).toMap(),
        ),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'ServerFailure: addCart'),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  FutureEither<CartEntity> getCart(String uid) async {
    try {
      final data = await remoteDataSource.getCart(uid);
      final cartEntity = CartModel.fromMap(data).toEntity();

      //? Sort datetime desc (newest)
      final bags = cartEntity.bags
        ..sort((e1, e2) => e2.dateTime.compareTo(e1.dateTime));

      return Right(cartEntity.copyWith(bags: bags));
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'ServerFailure: getCart'),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  FutureEither<void> updateCart(String uid, CartEntity entity) async {
    try {
      return Right(
        await remoteDataSource.updateCart(
          uid,
          CartModel.fromEntity(entity).toMap(),
        ),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'ServerFailure: updateCart'),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  FutureEither<void> deleteCart(String uid) async {
    try {
      return Right(
        await remoteDataSource.deleteCart(uid),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'ServerFailure: deleteCart'),
      );
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
