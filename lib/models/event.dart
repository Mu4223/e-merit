import 'package:flutter/material.dart';

class Event {
  String title;
  String description;
  String place;
  DateTime date; // Date only, without time
  TimeOfDay time; // Time only, without date
  int merit;

  Event({
    required this.title,
    required this.description,
    required this.place,
    required this.date,
    required this.time,
    required this.merit,
  });
}
