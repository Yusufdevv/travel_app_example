import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:module_13_part_2/helpers/location_helper.dart';
import 'package:module_13_part_2/models/place_model.dart';
import 'package:module_13_part_2/presentation/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function takePickedLocation;
  const LocationInput(this.takePickedLocation, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewLocationImage;

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();

    _getLocationImage(
      LatLng(locationData.latitude!, locationData.longitude!),
    );
  }

  void _getLocationImage(LatLng location) async {
    setState(() {
      _previewLocationImage = LocationHelper.getLocationImage(
          latitude: location.latitude, longtitude: location.longitude);
    });
    String address = await LocationHelper.getFormattedAddress(location);

    widget.takePickedLocation(location.latitude, location.longitude, address);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
          )),
          alignment: Alignment.center,
          child: _previewLocationImage == null
              ? const Text('Manzil tanlanmadi.')
              : Image.network(
                  _previewLocationImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Mening manzilim'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final location = await Navigator.push<LatLng>(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) => MapScreen(
                          placeLocation: PlaceLocation(
                              latitude: 41.2976211,
                              longitude: 69.3559353,
                              address: 'Tashkent'),
                          isSelecting: true)),
                );

                if (location == null) {
                  return;
                }
                _getLocationImage(location);
              },
              icon: const Icon(Icons.map),
              label: const Text('Xaritani ochish'),
            ),
          ],
        )
      ],
    );
  }
}
