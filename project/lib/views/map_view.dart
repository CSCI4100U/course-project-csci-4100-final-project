import 'package:flutter/material.dart';
import 'package:project/components/drawer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../classes/mapMarker.dart';

class mapView extends StatefulWidget {
  const mapView({Key? key}) : super(key: key);

  @override
  State<mapView> createState() => _mapViewState();
}

class _mapViewState extends State<mapView> {

  int selectedIndex = 0;
  var currentLocation = LatLng(51.5090214, -0.1982948);
  var placeholder = [
    MapMarker(
        image: 'https://images.otstatic.com/prod/23888275/1/huge.jpg',
        title: 'Alexander The Great Restaurant',
        address: '8 Plender St, London NW1 0JT, United Kingdom',
        location: LatLng(51.5382123, -0.1882464),
        rating: 4),
    MapMarker(
        image: 'https://media-cdn.tripadvisor.com/media/photo-s/11/5b/49/0a/mestizo-mexican-restaurant.jpg',
        title: 'Mestizo Mexican Restaurant',
        address: '103 Hampstead Rd, London NW1 3EL, United Kingdom',
        location: LatLng(51.5090229, -0.2886548),
        rating: 5),
    MapMarker(
        image: 'https://media-cdn.tripadvisor.com/media/photo-s/1a/ba/e9/f6/the-shed.jpg',
        title: 'The Shed',
        address: '122 Palace Gardens Terrace, London W8 4RT, United Kingdom',
        location: LatLng(51.5090215, -0.1959988),
        rating: 2),
    MapMarker(
        image: 'https://media-cdn.tripadvisor.com/media/photo-s/16/50/69/a4/gaucho-tower-bridge.jpg',
        title: 'Gaucho Tower Bridge',
        address: '2 More London Riverside, London SE1 2AP, United Kingdom',
        location: LatLng(51.5054563, -0.0798412),
        rating: 3),
    MapMarker(
      image: 'https://resizer.otstatic.com/v2/photos/wide-huge/2/29127125.jpg',
      title: 'Bill\'s Holborn Restaurant',
      address: '42 Kingsway, London WC2B 6EY, United Kingdom',
      location: LatLng(51.5077676, -0.2208447),
      rating: 4,
    ),
  ];
  late MapController mapController;

  @override
  void initState(){
    super.initState();
    mapController = MapController();
  }
  @override
  Widget build(BuildContext context) {
    // Geolocator.isLocationServiceEnabled().then((value) => null);
    // Geolocator.requestPermission().then((value) => null);
    // Geolocator.checkPermission().then(
    //         (LocationPermission permission)
    //     {
    //       //print("Check Location Permission: $permission");
    //     }
    // );
    //
    // Geolocator.getPositionStream(
    //   locationSettings: const LocationSettings(
    //       accuracy: LocationAccuracy.best
    //   ),
    // ).listen(_updateLocationStream);

    return Scaffold(
      appBar: AppBar(
        title: Text("Find Cinema Near Me"),
        actions: [
          IconButton(
              onPressed: (){
                // double z = mp.zoom + 1;
                // LatLng c = mp.center;
                // setState(() {
                //   mp.move(c, z);
                // });
              },
              icon: Icon(Icons.zoom_in)
          ),
          IconButton(
              onPressed: (){
                // double z = mp.zoom - 1;
                // LatLng c = mp.center;
                // setState(() {
                //   mp.move(c, z);
                // });
              },
              icon: Icon(Icons.zoom_out)
          )
        ],
      ),
      body: Stack(
        children: [
        FlutterMap(
        options: MapOptions(
          minZoom: 5,
          maxZoom: 18,
          zoom: 13,
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
                  point: placeholder[i].location,
                  builder: (_) {
                    return GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.location_on),
                    );
                  },
                ),
            ],
          ),
    ])
        ],
      ),
    );
  }
}