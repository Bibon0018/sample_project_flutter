import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sample_project/app/routes/app_pages.dart';
import 'package:sample_project/controllers/api_controller.dart';
import 'package:sample_project/controllers/controllers.dart';
import 'package:sample_project/app/routes/app_pages.dart';

class PostController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void goRegistration() {
    print(email);
    print(password);
    ApiController.to
        .register(email.text, password.text)
        .then((value) => Get.toNamed(Routes.AUTH));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
