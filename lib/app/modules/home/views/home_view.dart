import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sample_project/app/widgets/NewsList.dart';
import 'package:sample_project/app/widgets/app_bar.dart';
import 'package:sample_project/controllers/controllers.dart';
import 'package:sample_project/controllers/user_controller.dart';
import 'package:sample_project/generated/graphql/api.graphql.dart';
import '../controllers/home_controller.dart';
import 'package:sample_project/extensions.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    final subQuery = CurrentUserSubscription(
        variables:
            CurrentUserArguments(userId: UserController.to.user.value!.id));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: GradientAppBar(true, 'News', onTap: () {
          controller.onLogOut();
        }),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: ApiController.to.reconnectedStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Subscription(
                options: subQuery.sOptions(),
                builder: (result) {
                  return StreamBuilder(
                    stream: controller.news.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return Subscription(
                          options: subQuery.sOptions(),
                          builder: (result) {
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.shade800,
                                        Colors.purple
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    ...controller.news.value!.map(
                                        (e) => NewsList(e.content, e.title, () {
                                              controller.onTapNews(
                                                  context,
                                                  e.title,
                                                  e.content,
                                                  e.createdAt);
                                            }))
                                  ],
                                )),
                              ),
                            );
                          });
                    },
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.onTap(context),
        child: Icon(
          Icons.add_circle,
          size: 40,
        ),
      ),
    );
  }

  // Widget buildSubscriptionOnUser() {
  //   final subscription = CurrentUserSubscription(
  //       variables:
  //           CurrentUserArguments(userId: controller.user.value?.id ?? ''));
  //   return Subscription(
  //       options: subscription.options() as SubscriptionOptions,
  //       builder: (result) {
  //         if (result.data != null) {
  //           final user = subscription.parse(result.data!).user;
  //           return Center(
  //             child: Column(
  //               children: [
  //                 Text(user?.displayName ?? ''),
  //                 Text(ApiController.to.token.value?.refreshToken ?? ''),
  //                 Text(ApiController.to.token.value?.accessToken ?? ''),
  //               ],
  //             ),
  //           );
  //         }
  //         return SizedBox();
  //       });
  // }
}

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final String content;
  final DateTime date;
  CustomBottomSheet(this.content, this.date, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Text(
              "$title",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "$content",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text("${DateFormat('d MMM yyy').format(date).toString()}"),
          ),
        ],
      ),
    );
  }
}
