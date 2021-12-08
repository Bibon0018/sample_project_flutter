import 'dart:async';
import 'dart:developer';

import 'package:sample_project/app/routes/app_pages.dart';
import 'package:sample_project/generated/graphql/api.graphql.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sample_project/extensions.dart';
// import 'package:shawarmania/generated/graphql/api.graphql.dart';

import 'controllers.dart';

class NewsController extends DisposableInterface {
  static NewsController get to => Get.find();

  final news = Rxn<List<NewsMixin>>([]);
  final newMessagesCount = RxInt(0);

  bool _susbcribed = false;
  StreamSubscription<QueryResult>? _newsSubscription;





  @override
  void onClose() {
    unsubscribe();
    super.onClose();
  }

  void subscribe() {
    if (_susbcribed || StoreController.to.token == null) return;
    //  current user
    final newsSubscription = NewsSubscription(variables: NewsArguments());
    _newsSubscription = ApiController.subscribe(
      newsSubscription.options() as SubscriptionOptions,
    ).listen((event) {
      print("EVENT = ?$event");

      if (event.hasException) {
        log('CurrentUserSubscription',
            error: event.exception, name: 'UserController');
      } else {
        final result = newsSubscription.parse(event.data!);
        log('user updated', name: 'UserController');
        if (result.news != null) {
          news.value = result.news;
        } else {
          log('CurrentUserSubscription',
              error: 'user not found', name: 'UserController');
        }
      }
    });
    _susbcribed = true;
    log('subscribed', name: 'UserController');
  }

  void unsubscribe() {
    if (_newsSubscription != null) _newsSubscription?.cancel();
    _susbcribed = false;
    log('unsubscribed', name: 'UserController');
  }
}
