import 'package:flutter/material.dart';
import 'package:project/components/drawer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../classes/mapMarker.dart';

class mapView extends StatefulWidget {
  mapView({Key? key}) : super(key: key);
  bool isLoad = false;
  @override
  State<mapView> createState() => _mapViewState();
}

class _mapViewState extends State<mapView> {

  int selectedIndex = 0;
  List<GeoLocation> placeholder = [];
  late MapController mapController;
  late LatLng _positionMessage;

  @override
  void initState(){
    super.initState();
    mapController = MapController();
    Geolocator.isLocationServiceEnabled().then((value) => null);
    Geolocator.requestPermission().then((value) => null);
    Geolocator.checkPermission().then(
            (LocationPermission permission)
        {
          print("Check Location Permission: $permission");
        }
    );
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best
      ),
    ).listen(_updateLocationStream);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Cinema Near Me"),
        actions: [
          IconButton(
              onPressed: (){
                double z = mapController.zoom + 1;
                LatLng c = mapController.center;
                setState(() {
                  mapController.move(c, z);
                });
              },
              icon: const Icon(Icons.zoom_in)
          ),
          IconButton(
              onPressed: (){
                double z = mapController.zoom - 1;
                LatLng c = mapController.center;
                setState(() {
                  mapController.move(c, z);
                });
              },
              icon: const Icon(Icons.zoom_out)
          )
        ],
      ),
      body: Stack(
        children: [
          widget.isLoad ? FlutterMap(
            mapController: mapController,
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 13,
              center: _positionMessage,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                "https://api.mapbox.com/styles/v1/sejalshingal/clb8kgiuq004b14nzrnvvvcwj/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2VqYWxzaGluZ2FsIiwiYSI6ImNsYjhrYTgyaTBsc3Izd3BqYmEzcG1tOXkifQ.2uiODbeyAxZZuYC-qj1OVQ",
              ),
              MarkerLayerOptions(
                markers: [
                  for (int i = 0; i < placeholder.length; i++)
                    Marker(
                      height: 40,
                      width: 40,
                      point: placeholder[i].latlng,
                      builder: (_) {
                        return GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.location_on),
                        );
                        },
                    ),
                ],
              ),
            ]) : const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
  _updateLocationStream(Position userLocation) async{
    final List<Placemark> places = await placemarkFromCoordinates(
        userLocation.latitude,
        userLocation.longitude
    );
    if (mounted) {
      setState(() {
        if(widget.isLoad == false){
          _positionMessage =  LatLng(userLocation.latitude, userLocation.longitude);
          GeoLocation curr = GeoLocation(
              name: places[0].name!,
              address: "${places[0].subThoroughfare!} ${places[0].thoroughfare!}",
              latlng: LatLng(userLocation.latitude, userLocation.longitude)
          );
          placeholder.add(curr);
        }
        widget.isLoad = true;

      });
    }
  }
}