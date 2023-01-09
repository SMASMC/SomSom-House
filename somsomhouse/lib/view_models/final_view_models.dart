import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FinalViewModel extends ChangeNotifier {
  LatLng currentLocation = const LatLng(37.570789, 126.916165);
  String apartName = "";

  changeApartName(String name) {
    apartName = name;
    ChangeNotifier();
  }
}
