import 'package:cloud_task/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repo;

  AuthCubit({required AuthRepository authRepository})
      : _repo = authRepository,
        super(AuthInitial());

  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      await _repo.signUp(email, password, name);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await _repo.login(email, password);
      final profile = await _repo.getProfile();

      if (profile != null) {
        emit(AuthLoggedIn(profile));
      } else {
        emit(AuthError('Failed to load profile data.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    emit(AuthInitial());
  }

  Future<void> checkAuthStatus() async {
    final session = await _repo.getSession();
    if (session != null) {
      final profile = await _repo.getProfile();
      if (profile != null) {
        emit(AuthLoggedIn(profile));
      } else {
        emit(AuthInitial());
      }
    } else {
      emit(AuthInitial());
    }
  }
}
