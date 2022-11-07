import 'package:bloc/bloc.dart';
import 'package:lesson47_1/helpers/catch_exception.dart';
import 'package:lesson47_1/models/user_model.dart';
import 'package:lesson47_1/screens/user_screen/bloc/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    UserRepository repository = UserRepository();

    on<UserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        UserModel userModel = await repository.getUser();

        emit(UserFetchedState(userModel: userModel));
      } catch (e) {
        emit(UserErrorState(error: CatchException.convertException(e)));
      }
    });
  }
}
