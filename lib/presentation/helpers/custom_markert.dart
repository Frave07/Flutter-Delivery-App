import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


Future<BitmapDescriptor> getAssetImageMarker(String imagePath) async {

  return await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), imagePath);

}