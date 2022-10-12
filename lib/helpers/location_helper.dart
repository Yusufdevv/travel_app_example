import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../constants/google_maps.dart';

class LocationHelper {
  static String getLocationImage(
      {required double latitude, required double longtitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longtitude&key=$MAP_API_KEY";
  }

  static Future<String> getFormattedAddress(LatLng location) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.latitude},${location.longitude}&key=$MAP_API_KEY');

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    return data['results'][0]['formatted_address'];
  }
}
