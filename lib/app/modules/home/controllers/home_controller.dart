import 'dart:async';
import 'package:flutter/material.dart';
import "package:gql/language.dart" as lang;
import "package:gql/ast.dart" as ast;
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sample_project/app/modules/home/views/home_view.dart';
import 'package:sample_project/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:sample_project/app/widgets/gradient_button.dart';
import 'package:sample_project/controllers/api_controller.dart';
import 'package:sample_project/controllers/news_controller.dart';
import 'package:sample_project/controllers/user_controller.dart';
import 'package:sample_project/extensions.dart';
import 'package:sample_project/generated/graphql/api.graphql.dart';

class HomeController extends GetxController {
  final UserController _userController;
  final NewsController _newsController;

  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  Rxn<UserMixin> get user => _userController.user;
  Rxn<List<NewsMixin>> get news => _newsController.news;

  HomeController(
    this._newsController,
    this._userController,
  );

  @override
  void onInit() async {
    super.onInit();
    while (true) {
      await Future.delayed(Duration(seconds: 30), () async {
        final mutation = UpdateUserMutation(
            variables: UpdateUserArguments(
                id: user.value?.id ?? '',
                display_name: user.value?.displayName ?? ''));
        await ApiController.client
            .mutate(mutation.options() as MutationOptions);
      });
    }
  }

  @override
  void onLogOut() async {
    print("TAP");

    ApiController.to.logout().then((value) => Get.toNamed(Routes.AUTH));
  }

  @override
  void onTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                // height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(label: Text('Title')),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: contentController,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(label: Text('Content')),
                    )
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Get.to(context),
                        icon: Icon(Icons.close)),
                    IconButton(
                        onPressed: () => onAddNews(context,
                            titleController.text, contentController.text),
                        icon: Icon(Icons.check))
                  ],
                )
              ],
            ));
  }

  @override
  void onTapNews(
      BuildContext context, String title, String content, DateTime date) {
    showModalBottomSheet(
        context: context,
        builder: (context) => CustomBottomSheet(content, date, title));
  }

  @override
  void onAddNews(
    BuildContext context,
    String title,
    String content,
  ) async {
    print(title);
    print(content);
    print("PRINT====PRINT");
    final ast.DocumentNode doc = lang.parseString(
      """mutation MyMutation {
  insert_news_one(object: {content: "$content", title: "$title",}) {
    id
  }
}
""",
    );
    ApiController.client.mutate(MutationOptions(document: doc));
    Navigator.pop(context);
  }
}
