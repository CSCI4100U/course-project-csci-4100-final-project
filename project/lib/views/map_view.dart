import 'package:flutter/material.dart';
import 'package:project/components/drawer.dart';

class mapView extends StatefulWidget {
  const mapView({Key? key}) : super(key: key);

  @override
  State<mapView> createState() => _mapViewState();
}

class _mapViewState extends State<mapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Locations Near Me"),
      ),
      drawer: const NavDrawer(),
      body: Container(),
    );
  }
}
