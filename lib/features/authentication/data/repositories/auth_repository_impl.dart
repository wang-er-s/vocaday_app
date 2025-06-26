import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/exception.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/typedef/typedefs.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<dynamic> get user => remoteDataSource.user;

  @override
  FutureEither<AuthEntity> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final authModel =
          await remoteDataSource.signUpWithEmailAndPassword(email, password);
      return Right(authModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureEither<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return Right(
        await remoteDataSource.signInWithEmailAndPassword(email, password),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureEither<void> signOut() async {
    try {
      return Right(await remoteDataSource.signOut());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureEither<void> reauthenticateWithCredential(
      String email, String password) async {
    try {
      return Right(
          await remoteDataSource.reauthenticateWithCredential(email, password));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureEither<void> updatePassword(String password) async {
    try {
      return Right(await remoteDataSource.updatePassword(password));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureEither<void> sendCodeToEmail(String email) async {
    try {
      return Right(await remoteDataSource.sendCodeToEmail(email));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  FutureEither<void> deleteUserAuth() async {
    try {
      return Right(await remoteDataSource.deleteUserAuth());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}

