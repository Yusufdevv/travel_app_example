import 'dart:io';

import 'package:flutter/material.dart';
import 'package:module_13_part_2/database/place_db.dart';
import 'package:module_13_part_2/models/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _list = [];

  List<Place> get list {
    return [..._list];
  }

  void addPlace(String title, File image, PlaceLocation placeLocation) {
    Place newPlace = Place(
        id: UniqueKey().toString(),
        title: title,
        location: placeLocation,
        image: image);
    _list.add(newPlace);
    notifyListeners();

    PlacesDB.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'location_lat': newPlace.location.latitude,
      'location_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> getPlaces() async {
    final placesList = await PlacesDB.getData('user_places');
    _list = placesList
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            location: PlaceLocation(
                latitude: place['location_lat'],
                longitude: place['location_lng'],
                address: place['address']),
            image: File(
              place['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
