import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/services/authentication.dart';
import 'package:todo/services/todo.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  HomeBloc(this._auth, this._todo) : super(const RegisteringServicesState()) {
    on<LoginEvent>((event, emit) async {
      final user = await _auth.authenticateUser(event.username, event.password);
      if (user != null) {
        emit(SuccessfulLoginState(user));
        emit(const HomeInitial());
      }
    });

    on<RegisterServicesEvent>((event, emit) async {
      await _auth.init();
      await _todo.init();

      emit(const HomeInitial());
    });
  }
}
