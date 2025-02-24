import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.login(event.username, event.password);
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(AuthError(message: "Usuario o contraseña incorrectos"));
        }
      } catch (e) {
        print('El error --> $e');
        emit(AuthError(message: e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) {
      emit(Unauthenticated());
    });
  }
}
