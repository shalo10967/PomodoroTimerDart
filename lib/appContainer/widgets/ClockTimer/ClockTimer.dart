import 'package:flutter/material.dart';
import "package:sleek_circular_slider/sleek_circular_slider.dart";

class ClockTimer extends StatelessWidget {
  ClockTimer({required this.value, required this.defaultValue, super.key});

  double value;
  double defaultValue;

  String converTextTimer(double value) {
    return '${(value ~/ 60).toInt().toString().padLeft(2, '0')}:${(value % 60).toInt().toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SleekCircularSlider(
        initialValue: value,
        min: 0,
        max: defaultValue,
        appearance: CircularSliderAppearance(
          customWidths: CustomSliderWidths(
            trackWidth: 15,
            handlerSize: 8,
            progressBarWidth: 15,
            shadowWidth: 0,
          ),
          customColors: CustomSliderColors(
            trackColor: Colors.grey,
            progressBarColor: Colors.orange,
            hideShadow: true,
            dotColor: Colors.orangeAccent,
          ),
          size: 250,
          angleRange: 360,
          startAngle: 270,
        ),
        innerWidget: (double newValue) {
          return Center(
            child: Text(
              converTextTimer(value),
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 46,
              ),
            ),
          );
        },
      ),
    );
  }
}
