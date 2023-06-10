import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  LatLng currentLatLng = LatLng(35.681, 139.767);
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    initLocation();
  }

  Future<void> initLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final latitude = position.latitude;
    final longitude = position.longitude;
    setState(() {
      currentLatLng = LatLng(latitude, longitude);
    });
    mapController.move(currentLatLng, 18);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("openstreetmap Flutter"),
      ),
      body: Container(
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: currentLatLng,
            zoom: 15.0,
            maxZoom: 18,
            minZoom: 9,
            interactiveFlags: (InteractiveFlag.all & ~InteractiveFlag.rotate),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  "https://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png",
              //urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              //userAgentPackageName: 'land_place',
            ),
            MarkerLayer(markers: [
              Marker(
                  width: 30.0,
                  height: 30.0,
                  point: currentLatLng,
                  builder: (ctx) => Container(
                          child: Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      )))
            ]),
          ],
          // layers: [
          //   TileLayerOptions(
          //       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
          //   MarkerLayerOptions(markers: [
          //     Marker(
          //         width: 30.0,
          //         height: 30.0,
          //         point: LatLng(-12.069783, -77.034057),
          //         builder: (ctx) => Container(
          //                 child: Container(
          //               child: Icon(
          //                 Icons.location_on,
          //                 color: Colors.blueAccent,
          //                 size: 40,
          //               ),
          //             )))
          //   ])
          // ],
        ),
      ),
    );
  }
}
