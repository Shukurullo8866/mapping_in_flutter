import '../api/api_servise.dart';
import '../model/lat_long.dart';
import '../model/my_respons/response_model.dart';

class GeocodingRepo {
  GeocodingRepo({required this.apiService});

  final ApiService apiService;

  Future<AppResponse> getAddress(LatLong latLong, String kind) =>
      apiService.getLocationName(
          geoCodeText: "${latLong.longitude},${latLong.lattitude}", kind: kind);
}