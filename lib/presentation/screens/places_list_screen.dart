import 'package:flutter/material.dart';
import 'package:module_13_part_2/presentation/screens/add_place_screen.dart';
import 'package:module_13_part_2/providers/places_provider.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<PlacesProvider>(context, listen: false).getPlaces(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<PlacesProvider>(
              builder: (ctx, placeProvider, child) {
                final list = placeProvider.list;
                if (placeProvider.list.isNotEmpty) {
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (c, i) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(list[i].image),
                      ),
                      title: Text(list[i].title),
                      subtitle: Text(list[i].location.address),
                    ),
                  );
                } else {
                  return child!;
                }
              },
              child: const Center(
                child: Text('Sayohat joylari mavjud emas, iltimos qo\'shing!'),
              ),
            );
          }),
    );
  }
}
