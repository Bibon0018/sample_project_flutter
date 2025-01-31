import 'package:get/get.dart';

import 'package:sample_project/app/modules/auth/bindings/auth_binding.dart';
import 'package:sample_project/app/modules/auth/views/auth_view.dart';
import 'package:sample_project/app/modules/home/bindings/home_binding.dart';
import 'package:sample_project/app/modules/home/views/home_view.dart';

import 'package:sample_project/app/modules/registration/bindings/registration_binding.dart';
import 'package:sample_project/app/modules/registration/views/registration_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
  
  ];
}
