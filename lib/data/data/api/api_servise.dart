import 'package:dio/dio.dart';
import '../../../utils/constants.dart';
import '../geocoding/geocoding.dart';
import '../model/my_respons/response_model.dart';
import 'api_clients.dart';


class ApiService extends ApiClient {
  Future<AppResponse> getLocationName(
      {required String geoCodeText, required String kind}) async {
    AppResponse appResponse = AppResponse(error: '');
    try {
      late Response response;
      Map<String, String> queryParams = {
        'apikey': mapApiKey,
        'geocode': geoCodeText,
        'lang': 'uz_UZ',
        'format': 'json',
        'kind': kind,
        'rspn': '1',
        'results': '1',
      };
      response = await dio.get(
        dio.options.baseUrl,
        queryParameters: queryParams,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        Geocoding geocoding = Geocoding.fromJson(response.data);
        if (geocoding.response.geoObjectCollection.featureMember.isNotEmpty) {
          appResponse.data = geocoding
              .response
              .geoObjectCollection
              .featureMember[0]
              .geoObject
              .metaDataProperty
              .geocoderMetaData
              .text;
        } else {
          appResponse.data = 'Aniqlanmagan hudud';
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      appResponse.error = e.toString();
    }
    return appResponse;
  }
}