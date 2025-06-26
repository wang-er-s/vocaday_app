import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/translations/translations.dart';
import '../../../domain/usecases/sign_in_with_email_password.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInWithEmailPasswordUsecase signInWithEmailPasswordUsecase;

  SignInBloc(
    this.signInWithEmailPasswordUsecase,
  ) : super(SignInInitialState()) {
    on<RequestSignInEvent>(_onRequestSignInEvent);
  }

  Future<void> _onRequestSignInEvent(
    RequestSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoadingState());
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      final result = await signInWithEmailPasswordUsecase(
        (event.email, event.password),
      );

      result.fold(
        (failure) {
          emit(SignInErrorState(failure.message));
        },
        (_) => emit(SignInSuccessState()),
      );
    } else {
      emit(SignInErrorState(
        LocaleKeys.auth_please_enter_and_password.tr(),
      ));
    }
  }
}
