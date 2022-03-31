import 'package:dio/dio.dart';

import '../../repositories/models/user.dart';
import '../dio_base.dart';

mixin UserApi {
  /*Future<String?> registerUser(User user) async {
    Dio? dio = DioBase().getDio();
    dio!.options.method = "POST";
    Response response = await dio.post("/", data: user.toJson(false));
    String ts = user.fromJson(response.data);
    return response.statusCode == 200 ? user.fromJson(response.data) : null;
  }*/

  Future loginUser(User user) async {
    Dio? dio = DioBase().getDio();
    dio!.options.method = "POST";
    try {
      Response response = await dio.post("/", data: user.toJson(true));
      return response.statusCode == 200
          ? user.fromJsonNewLogin(response.data)
          : null;
    } on DioError catch (e) {
      return null;
    }
  }
/*
  Future<String?> verifyUserPhone(User user, String verificationCode) async {
    Dio? dio = DioBase().getDio();
    dio!.options.method = "POST";
    Response response = await dio.post("/", data: user.toJsonForVerification(verificationCode));
    return response.statusCode == 200 ? user.fromJson(response.data) : null;
  }

  Future<String?> reSendUserPhone(User user) async {
    Dio? dio = DioBase().getDio();
    dio!.options.method = "POST";
    Response response = await dio.post("/", data: user.toJsonForReSend());
    return response.statusCode == 200 ? user.fromJson(response.data) : null;
  }

  Future<String?> forgotPasswordRequest(String mail) async {
    Dio? dio = DioBase().getDio();
    dio!.options.method = "POST";
    Response response = await dio.post("/", data: User().toJSONForForgetPassword(mail));
    return response.statusCode == 200 ? User().fromJsonForPasswordReset(response.data) : null;
  }

  Future<String?> resetPassword(User user) async {
    Dio? dio = DioBase().getDio();
    dio!.options.method = "POST";
    Response response = await dio.post("/", data: user.toJsonForResetPassword());
    return response.statusCode == 200 ? user.fromJson(response.data) : null;
  }*/
}
