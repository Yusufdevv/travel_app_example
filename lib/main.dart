import 'package:flutter/material.dart';
import 'package:module_13_part_2/providers/places_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlacesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travell Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (context) => const PlaceDetailsScreen(),
        },
      ),
    );
  }
}
