class LatLong{
  LatLong({required this.latitude,required this.longitude});
  double latitude;
  double longitude;
}
class MovementModel {
  num lat;
  num long;
  String time;

  MovementModel({required this.lat, required this.long, required this.time});

  factory MovementModel.fromJson(Map<String, dynamic> json) {
    return MovementModel(
        lat: json["lat"], long: json['long'], time: json['time']);
  }

  toJson() => {"lat": lat, "long": long, "time": time};
}