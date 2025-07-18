import 'package:final_project/trip_model.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final List<Trip> trips = [
      Trip(destination: "Paris", timeFrame: DateTimeRange(start: DateTime(2025, 6, 1), end: DateTime(2025, 6, 10)), image: "https://media.istockphoto.com/id/635758088/photo/sunrise-at-the-eiffel-tower-in-paris-along-the-seine.jpg?s=612x612&w=0&k=20&c=rdy3aU1CDyh66mPyR5AAc1yJ0yEameR_v2vOXp2uuMM=",
          itinerary: ['Eiffel Tower', "Louvre Museum"]),
      Trip(destination: "Tokyo", timeFrame: DateTimeRange(start: DateTime(2025, 9, 15), end: DateTime(2025, 9, 22)), image: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1b/4b/5d/10/caption.jpg?w=1400&h=1400&s=1&cx=1005&cy=690&chk=v1_2ed86f729380ea073850",
          itinerary: ["Shibuya Crossing", "Eat Sushi", "Tsukiji Market"])
    ];

    return MaterialApp(
      title: 'Travel Planner',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.teal),
        ),
      ),
      home: HomeScreen(trips: trips),
    );
  }
}