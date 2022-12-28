import 'package:flutter/cupertino.dart';
import '../data/data/model/lat_long.dart';
import '../data/data/model/my_respons/response_model.dart';
import '../data/data/repositoriy/geocoding_repo.dart';

class MapViewModel extends ChangeNotifier {
  MapViewModel({required this.geocodingRepo});

  final GeocodingRepo geocodingRepo;

  String addressText = "";
  String errorForUI = "";

  fetchAddress({required LatLong latLong, required String kind}) async {
    AppResponse appResponse = await geocodingRepo.getAddress(latLong, kind);
    if (appResponse.error.isEmpty) {
      addressText = appResponse.data;
    } else {
      errorForUI = appResponse.error;
    }
    notifyListeners();
  }
}