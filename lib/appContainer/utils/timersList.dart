import 'package:flutter/material.dart';

double seconds = 60;

double ms(double minutes) {
  return minutes * seconds;
}

List<double> pomodoroTimers = [ms(25), ms(30), ms(35)];
List<double> shortBreakTimers = [ms(5), ms(10), ms(15)];
List<double> longBreakTimers = [ms(20), ms(30), ms(40)];
