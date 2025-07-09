import 'package:fpdart/fpdart.dart';

import '../../../../../core/typedef/typedefs.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../user/user_cart/domain/entities/cart_entity.dart';
import '../../../user/user_cart/domain/repositories/cart_repository.dart';
import '../../../user/user_profile/domain/entities/user_entity.dart';
import '../../../user/user_profile/domain/repositories/user_repository.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithPhoneUsecase extends Usecases<AuthEntity, String> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final CartRepository cartRepository;

  SignInWithPhoneUsecase({
    required this.authRepository,
    required this.userRepository,
    required this.cartRepository,
  });

  @override
  FutureEither<AuthEntity> call(String phone) async {
    final signInResult = await authRepository.signInWithPhone(phone);

    return await signInResult.fold((failure) async => Left(failure), (
      authEntity,
    ) async {
      if (!authEntity.isNewUser) {
        return Right(authEntity);
      }

      final user = authEntity.user;

      final userEntity = UserEntity(
        uid: authEntity.uid,
        name: user.userMetadata?['name'] ?? '',
        email: user.email ?? '',
        method: authEntity.signInMethod.name,
        avatar: user.userMetadata?['avatar'] ?? '',
        phone: user.phone ?? '',
        birthday: DateTime.now(),
        createdDate: DateTime.parse(user.createdAt),
      );

      final addUserResult = await userRepository.addUserProfile(userEntity);

      return await addUserResult.fold((fail) => Left(fail), (_) async {
        final addCartRes = await cartRepository.createCart(
          authEntity.uid,
          CartEntity.empty.copyWith(id: authEntity.uid),
        );

        return addCartRes.fold(
          (fail) => Left(fail),
          (_) => Right(authEntity.copyWith(isNewUser: false)),
        );
      });
    });
  }
}
