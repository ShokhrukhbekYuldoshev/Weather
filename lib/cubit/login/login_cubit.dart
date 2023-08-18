import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_service/data/services/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService = AuthService();

  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      emit(LoginSuccess());
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      emit(LoginFailure(e.toString()));
    }
  }
}
