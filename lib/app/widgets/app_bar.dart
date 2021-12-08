import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 50.0;
  final bool exitButton;
  Function? onTap;

  GradientAppBar(this.exitButton, this.title, {this.onTap});

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Row(
          mainAxisAlignment: exitButton
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                exitButton ? "   $title" : title,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            exitButton
                ? IconButton(
                    onPressed: () {
                      onTap!();
                    },
                    icon: Icon(Icons.exit_to_app))
                : SizedBox(),
          ]),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.purple],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
