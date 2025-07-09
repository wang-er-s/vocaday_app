import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vocaday_app/features/authentication/data/data_sources/auth_remote_data_source.dart';

void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

  setUp(() {
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(
      Supabase.instance.client,
    );
  });
  group('User state changed', () {
    test('should get user state changed', () {
      expectLater(authRemoteDataSourceImpl.user, emitsInOrder([null]));
    });
  });
}
