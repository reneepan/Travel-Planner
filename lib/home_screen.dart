import 'package:final_project/trip_model.dart';
import 'package:final_project/trip_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Trip> trips;

  const HomeScreen({super.key, required this.trips});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Trip> _trips;

  @override
  void initState() {
    super.initState();
    _trips = [...widget.trips];
  }

  Future<void> _openTrip() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => TripScreen()));

    if (result is Trip) {
      setState(() {
        _trips.add(result);
      });
    }
  }

  Future<void> _editTrip(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TripScreen(trip: _trips[index]))
    );
    if (result is Trip) {
      setState(() {
        _trips[index] = result;
      });
    }
    else if (result is Map && result['delete'] == true) {
      setState(() {
        _trips.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Trips"),),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _trips.length,
                  itemBuilder: (context, index) {
                    final trip = _trips[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: trip.image != null && trip.image!.isNotEmpty ?
                        Image.network(trip.image!, width: 60,height: 60, fit: BoxFit.cover)
                            : const Icon(Icons.map, size: 40),
                        title: Text(trip.destination, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: trip.timeFrame != null
                            ? Text('${trip.timeFrame!.start.month}/${trip.timeFrame!.start.day}/${trip.timeFrame!.start.year} - ${trip.timeFrame!.end.month}/${trip.timeFrame!.end.day}/${trip.timeFrame!.end.year}',)
                            : null,
                        onTap: () => _editTrip(index),
                      ),
                    );
                  }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _openTrip, child: const Text("Add a new Trip"))
            ),
          )
        ],
      )
    );
  }
  
}