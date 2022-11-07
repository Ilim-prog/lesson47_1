import 'package:lesson47_1/models/user_model.dart';
import 'package:lesson47_1/screens/user_screen/bloc/user_provider.dart';

class UserRepository {
  Future<UserModel> getUser() {
    UserProvider provider = UserProvider();

    return provider.getUser();
  }
}
