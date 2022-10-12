import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:module_13_part_2/models/place_model.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation placeLocation;
  final bool isSelecting;
  const MapScreen(
      {super.key, required this.placeLocation, required this.isSelecting});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void getLocation(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Manzilni Belgilang'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () => Navigator.of(context).pop(_pickedLocation),
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        onTap: widget.isSelecting ? getLocation : (LatLng lantlng) {},
        markers: _pickedLocation == null
            ? {}
            : {
                Marker(
                    markerId: const MarkerId('1'), position: _pickedLocation!)
              },
        initialCameraPosition: CameraPosition(
          zoom: 15,
          target: LatLng(
            widget.placeLocation.latitude,
            widget.placeLocation.longitude,
          ),
        ),
      ),
    );
  }
}
