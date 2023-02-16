import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasir/repositories/auth/auth_repository.dart';

import '../../model/auth/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  AuthBloc(this._repository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final auth = await _repository.login(
            email: event.email, password: event.password);
        emit(AuthSuccess(authModel: auth));
      } catch (e) {
        emit(AuthFailed(message: e.toString()));
      }
    });
  }
}
