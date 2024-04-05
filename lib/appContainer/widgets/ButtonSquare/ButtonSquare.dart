import 'package:flutter/material.dart';
import 'package:timepomodoro/appContainer/utils/windowSize.dart';

class ButtonSquare extends StatelessWidget {
  ButtonSquare({required this.buttonText, required this.onTap, super.key});

  VoidCallback onTap;
  String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: widthScreen * 0.04,
      height: heightScreen * 0.02,
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )),
    );
  }
}
