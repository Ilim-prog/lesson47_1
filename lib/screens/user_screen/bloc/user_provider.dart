import 'package:dio/dio.dart';
import 'package:lesson47_1/helpers/api_requester.dart';
import 'package:lesson47_1/helpers/catch_exception.dart';
import 'package:lesson47_1/models/user_model.dart';

class UserProvider {
  ApiRequester apiRequester = ApiRequester();

  Future<UserModel> getUser() async {
    try {
      Response response = await apiRequester.toGet('');
      print("response ==== ${response}");

      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        print("userModel === $userModel");
        return userModel;
      }

      throw CatchException.convertException(response);
    } catch (e) {
      print("e========$e");
      throw CatchException.convertException(e);
    }
  }
}
