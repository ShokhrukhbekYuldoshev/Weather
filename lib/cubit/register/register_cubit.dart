import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_service/data/services/auth_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthService _authService = AuthService();

  RegisterCubit() : super(RegisterInitial());

  Future<void> register(String email, String password) async {
    emit(RegisterLoading());
    try {
      await _authService.createUserWithEmailAndPassword(email, password);
      emit(RegisterSuccess());
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      emit(RegisterFailure(e.toString()));
    }
  }
}
