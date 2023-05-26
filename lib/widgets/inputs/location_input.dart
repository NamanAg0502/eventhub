import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final MapController _mapController = MapController();
  LatLng _selectedLocation = LatLng(0.0, 0.0);

  // void _handleTap(TapDownDetails details) {
  //   final RenderBox renderBox = context.findRenderObject() as RenderBox;
  //   final LatLng tappedPoint = _mapController.getLatLng(
  //     renderBox.globalToLocal(details.globalPosition),
  //   );
  //   setState(() {
  //     _selectedLocation = tappedPoint;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Picker'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(0.0, 0.0),
          zoom: 13.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use the selected location
          print('Selected Location: $_selectedLocation');
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
