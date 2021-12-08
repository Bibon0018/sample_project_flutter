import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_project/app/widgets/gradient_button.dart';

class NewsList extends StatelessWidget {
  final String title;
  final String content;
  final Function onTap;

  NewsList(this.content, this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 2, left: 5, bottom: 5),
            alignment: Alignment.topLeft,
            child: Text(
              'News: $title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              '$content',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.grey.shade800, fontWeight: FontWeight.w800),
            ),
          ),
          InkWell(
              onTap: () {
                onTap();
              },
              child: Container(
                padding: EdgeInsets.all(3),
                alignment: Alignment.center,
                width: Get.width,
                // color: Colors.black,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(8)),
                  gradient: LinearGradient(
                      colors: [Colors.green.shade300, Colors.green.shade900],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Text(
                  "Show more",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ))
        ],
      ),
    );
  }
}
