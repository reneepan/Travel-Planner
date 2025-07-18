import 'package:final_project/trip_model.dart';
import 'package:flutter/material.dart';

class TripScreen extends StatefulWidget {
  final Trip? trip;

  const TripScreen({super.key, this.trip});

  @override
  State<TripScreen> createState() => _TripScreenState();
  
}

class _TripScreenState extends State<TripScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _itineraryController = TextEditingController();

  String _destination = '';
  String _itinerary = '';
  String ? _image;
  DateTimeRange? _tripDateRange;
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    if (widget.trip != null) {
      _destination = widget.trip!.destination;
      _itinerary = widget.trip!.itinerary.join('\n');
      _image = widget.trip!.image;
      _tripDateRange = widget.trip!.timeFrame;
    }

    _destinationController.text = _destination;
    _itineraryController.text = _itinerary;
  }

  String _formattedTime() {
    if (_tripDateRange == null) {
      return '';
    }
    final start = _tripDateRange!.start;
    final end = _tripDateRange!.end;
    return '${start.month}/${start.day}/${start.year} - ${end.month}/${end.day}/${end.year}';
  }

  Future<void> _pickDates() async {
    final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000), lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        _tripDateRange = picked;
      });
    }
  }

  void _editImage() {
    final controller = TextEditingController(text: _image);

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Edit Image URL"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "Image URL"),
          ),
          actions: [
            TextButton(onPressed: () {
              setState(() {
                _image = controller.text;
              });
              Navigator.pop(context);
            },
            child: Text("Save"),)
          ],
        )
    );
  }

  void _saveTrip() {
    print("Saving trip with itinerary:\n${_itineraryController.text}");
    final newTrip = Trip(destination: _destinationController.text, timeFrame: _tripDateRange,image: _image, itinerary: _itineraryController.text.split('\n').map((s) => s.trim()).toList());
    Navigator.pop(context, newTrip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Details"),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey,
                child: _image!= null  && _image!.isNotEmpty ?
                Image.network(_image!, fit: BoxFit.cover) : Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYYMQXfAjx3FLdusvgukRyPO_uf1Bh6gczcQ&s",
                    fit: BoxFit.cover,)
              ),
              IconButton(onPressed: _editImage, icon: Icon(Icons.edit, color: Colors.white)),
            ],
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Destination'),
                      controller: _destinationController,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8,),
                    ListTile(
                      title: Text(_tripDateRange == null ? 'Select Time Frame' : _formattedTime()),
                      trailing: Icon(Icons.calendar_today),
                      onTap: _pickDates,
                    ),
                    SizedBox(height: 8,),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Itinerary (one item per line)',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _itineraryController
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(onPressed: _saveTrip, child: Text("Save Trip")),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, {'delete': true});
                      },
                      child: Text(
                        "Delete Trip",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

}