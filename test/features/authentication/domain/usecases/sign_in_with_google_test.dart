import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vocaday_app/core/errors/failure.dart';
import 'package:vocaday_app/features/authentication/data/models/auth_model.dart';
import 'package:vocaday_app/features/authentication/domain/entities/auth_entity.dart';
import 'package:vocaday_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:vocaday_app/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:vocaday_app/features/user/user_cart/domain/repositories/cart_repository.dart';
import 'package:vocaday_app/features/user/user_profile/domain/repositories/user_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockCartRepository extends Mock implements CartRepository {}

class MockUser extends Mock implements User {}

void main() {
  final mockUser = MockUser();
  late SignInWithPhoneUsecase signInWithGoogleUsecase;
  late MockAuthRepository mockAuthRepository;
  late MockUserRepository mockUserRepository;
  late MockCartRepository mockCartRepository;
  final testPhone = "";

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    mockCartRepository = MockCartRepository();
    signInWithGoogleUsecase = SignInWithPhoneUsecase(
      authRepository: mockAuthRepository,
      userRepository: mockUserRepository,
      cartRepository: mockCartRepository,
    );
  });

  final testEntity = AuthEntity(
    uid: 'uid',
    user: mockUser,
    isNewUser: false,
    signInMethod: SignInMethod.phone,
  );

  group('Sign In With Google Usecase', () {
    test('should get [AuthEntity] class from repository', () async {
      when(
        () => mockAuthRepository.signInWithPhone(testPhone),
      ).thenAnswer((_) async => Right(testEntity));
      final result = await signInWithGoogleUsecase(testPhone);
      expect(result, Right(testEntity));
    });
    test('should get [ServerFailure] from repository', () async {
      when(
        () => mockAuthRepository.signInWithPhone(testPhone),
      ).thenAnswer((_) async => const Left(ServerFailure("")));
      final result = await signInWithGoogleUsecase(testPhone);
      expect(result, const Left(ServerFailure("")));
    });
  });
}
