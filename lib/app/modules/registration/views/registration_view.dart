import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sample_project/app/app.dart';
import 'package:sample_project/app/routes/app_pages.dart';
import 'package:sample_project/app/widgets/app_bar.dart';
import 'package:sample_project/app/widgets/gradient_button.dart';
import 'package:sample_project/controllers/api_controller.dart';

import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: GradientAppBar(false,"RegistrationView"),
        ),
        body: Container(
            height: Get.height - 50,
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.purple],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Center(
              child: Container(
                // alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 15.0),
                          blurRadius: 15.0),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, -10.0),
                          blurRadius: 10.0),
                    ]),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        controller: controller.email,
                        decoration: InputDecoration(label: Text('Email')),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: controller.password,
                        obscureText: true,
                        decoration: InputDecoration(label: Text('Password')),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                          onTap: () => controller.goRegistration(),
                          child: GradientButton(50, 110, "SingUp")),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ))
        // )
        );
  }
}
