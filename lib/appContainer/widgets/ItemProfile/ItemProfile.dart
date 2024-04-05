import 'package:flutter/material.dart';
import 'package:timepomodoro/appContainer/utils/windowSize.dart';

class ItemProfile extends StatelessWidget {
  ItemProfile(
      {required this.buttonText,
      this.bgColor,
      this.width,
      this.minutes,
      this.totalMinutes,
      this.totalBreaks,
      super.key});

  String buttonText;
  Color? bgColor;
  double? width;
  String? minutes;
  String? totalMinutes;
  bool? totalBreaks;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: widthScreen * width!,
      height: heightScreen * 0.04,
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: bgColor ?? Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Column(
                children: [
                  Text(
                    buttonText,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    minutes ?? '0',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    !totalBreaks!
                        ? '${(totalMinutes != null ? '$totalMinutes' : '0')} min'
                        : 'Taking breaks are good for you',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              )),
            ),
          )),
    );
  }
}
