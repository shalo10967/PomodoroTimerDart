import 'package:flutter/material.dart';

class ButtonRounded extends StatelessWidget {
  ButtonRounded({required this.buttonIcon, required this.onTap, super.key});

  VoidCallback onTap;
  IconData buttonIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: 60,
      height: 60,
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(60),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(60)),
              child: Center(
                child: Icon(buttonIcon as IconData?),
              ),
            ),
          )),
    );
  }
}
