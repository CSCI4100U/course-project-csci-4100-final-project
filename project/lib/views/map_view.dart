import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:project/components/drawer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../classes/mapMarker.dart';
import '../models/fetch_data.dart';
import 'map_bookstore.dart';

class mapView extends StatefulWidget {
  mapView({Key? key}) : super(key: key);
  bool isLoad = false;
  @override
  State<mapView> createState() => _mapViewState();
}

class _mapViewState extends State<mapView>  with TickerProviderStateMixin{
  String accessTok = "pk.eyJ1Ijoic2VqYWxzaGluZ2FsIiwiYSI6ImNsYjhrYTgyaTBsc3Izd3BqYmEzcG1tOXkifQ.2uiODbeyAxZZuYC-qj1OVQ";
  String accessTokFind = "PBYeQYsneEBM84M9wPPjPtQVcM1UQPOn";
  int selectedIndex = 0;
  List<GeoLocation> placeholder = [];
  MapController mapController = MapController();
  late LatLng _userLocation;
  final pageController = PageController();
  late LatLng _currentLocation;
  String _value = "cinema";

  @override
  void initState(){
    super.initState();
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
        backgroundColor: Colors.purple,
        title: Theme(
          data: ThemeData.dark(),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _value,
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  value: 'cinema',
                  child: Text('Find Cinemas Near me'),
                ),
                DropdownMenuItem(
                  value: 'bookstore',
                  child: Text('Find Book Stores near me'),
                )
              ],
              onChanged: (String? value) {
                setState(() {
                  _value = value!;
                  if(_value == "bookstore"){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                mapBooks()
                        ));
                  }
                });
              },
            ),
          ),
        ),
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
      drawer: const NavDrawer(),
      body: Center(
        child: widget.isLoad ? FutureBuilder<List<GeoLocation>>(
          future: Fetch.fetchLocations(accessTokFind,_userLocation),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              _currentLocation = _userLocation;
              return Stack(
                children: [
                  FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                      minZoom: 5,
                      maxZoom: 18,
                      zoom: 13,
                      center: _currentLocation,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                          "https://api.mapbox.com/styles/v1/sejalshingal/clb8kgiuq004b14nzrnvvvcwj/tiles/256/{z}/{x}/{y}@2x?access_token=$accessTok",
                        ),
                        MarkerLayerOptions(
                          markers: [
                            for (dynamic i = 0; i < snapshot.data?.length; i++)
                              Marker(
                                height: 40,
                                width: 40,
                                point: snapshot.data![i].latlng,
                                builder: (context){
                                  return Container(
                                    child: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          pageController.animateToPage(i,
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut
                                          );
                                          selectedIndex = i;
                                          _currentLocation = snapshot.data![i].latlng;
                                          _animatedMapMove(_currentLocation, 13);
                                        });
                                        },
                                      icon: Icon(Icons.location_on,
                                          color: selectedIndex == i ?
                                          Colors.blue : Colors.black),
                                      iconSize: 45,
                                    ),
                                  );
                                }
                              ),
                          ],
                        ),
                      ]
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 2,
                    height: MediaQuery.of(context).size.height*0.3,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: snapshot.data!.length,
                        onPageChanged: (value){
                          setState(() {
                            selectedIndex = value;
                            _currentLocation = snapshot.data![value].latlng;
                            _animatedMapMove(_currentLocation, 13);
                          });
                        },
                        itemBuilder: (context, index){
                          var item = snapshot.data![index];
                          return Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: const Color.fromARGB(255, 30, 29, 29),
                              child: Row(
                                children: [
                                  const SizedBox(width:10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.address ?? '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name ?? '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ],
              );
            }},
        ) : const Center(child: CircularProgressIndicator()),
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
          _userLocation =  LatLng(userLocation.latitude, userLocation.longitude);
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
  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);

    Animation<double> animation =
    CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}