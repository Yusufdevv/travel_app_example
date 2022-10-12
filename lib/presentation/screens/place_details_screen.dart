import 'package:flutter/material.dart';
import 'package:module_13_part_2/presentation/screens/map_screen.dart';
import 'package:module_13_part_2/providers/places_provider.dart';
import 'package:provider/provider.dart';

class PlaceDetailsScreen extends StatefulWidget {
  const PlaceDetailsScreen({super.key});
  static const routeName = '/place-details';
  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final place = Provider.of<PlacesProvider>(context).getById(id as String);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(place.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) => MapScreen(
                          placeLocation: place.location, isSelecting: false)),
                );
              },
              child: const Text('Manzilni xaritada ko\'rish'))
        ],
      ),
    );
  }
}
