import 'package:flutter/material.dart';

class Trip {
  final String destination;
  final DateTimeRange? timeFrame;
  final String? image;
  final List<String> itinerary;

  Trip({required this.destination, required this.timeFrame, this.image, required this.itinerary});
}