import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sample_project/app/routes/app_pages.dart';
import 'package:sample_project/controllers/controllers.dart';
import 'package:sample_project/app/routes/app_pages.dart';
// import 'package:sample_project/app/routes/app_routes.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void goRegistration() {
    Get.toNamed(Routes.REGISTRATION);
  }

  @override
  gologin() {
    print(email.text);
    ApiController.to
        .login(email.text, password.text)
        .then((value) => Get.toNamed(Routes.HOME));
  }

  @override
  void onReady() {
    super.onReady();
  }
}
