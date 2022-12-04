import 'package:latlong2/latlong.dart';

class MarkerTitle{
  final String title;

  factory MarkerTitle.fromMap(Map map){
    return MarkerTitle(
      title: map['name'],
    );
  }
  MarkerTitle({
    required this.title,
  });
}
class MarkerAddress{
  final String address;

  factory MarkerAddress.fromMap(Map map){
    return MarkerAddress(
      address: map['freeformAddress'],
    );
  }
  MarkerAddress({
    required this.address,
  });
}
class MarkerLocation{
  final double lat;
  final double long;

  factory MarkerLocation.fromMap(Map map){
    return MarkerLocation(
      lat: map['lat'],
      long: map['lon'],
    );
  }
  MarkerLocation({
    required this.lat,
    required this.long
  });
}
class GeoLocation{
  String name;
  String address;
  LatLng latlng;

  GeoLocation({required this.name, required this.address, required this.latlng});
}