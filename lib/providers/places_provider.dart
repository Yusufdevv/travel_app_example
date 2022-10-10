import 'dart:io';

import 'package:flutter/material.dart';
import 'package:module_13_part_2/database/place_db.dart';
import 'package:module_13_part_2/models/place_model.dart';

class PlacesProvider with ChangeNotifier {
  final List<Place> _list = [];

  List<Place> get list {
    return [..._list];
  }

  void addPlace(String title, File image) {
    PlaceLocation location =
        PlaceLocation(latitude: "1", longitude: "1", address: "UZB");
    Place newPlace = Place(
        id: UniqueKey().toString(),
        title: title,
        location: location,
        image: image);
    _list.add(newPlace);
    notifyListeners();

    PlacesDB.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }
}
