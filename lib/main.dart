import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:geolocator/geolocator.dart";
import "package:latlong2/latlong.dart";

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LatLng myLocationLatLng = LatLng(35.681, 139.767);
  MapController mapController = MapController();

  // @override
  // void initState() {
  //   super.initState();
  //   refreshMyLocation();
  // }

  Future<void> refreshMyLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final latitude = position.latitude;
    final longitude = position.longitude;
    setState(() {
      myLocationLatLng = LatLng(latitude, longitude);
    });
    mapController.move(myLocationLatLng, 18);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("gsi Flutter"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.my_location,
        ),
        onPressed: () {
          refreshMyLocation();
        },
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: myLocationLatLng,
          zoom: 15.0,
          maxZoom: 18,
          minZoom: 9,
          interactiveFlags: (InteractiveFlag.all & ~InteractiveFlag.rotate),
        ),
        children: [
          TileLayer(
            urlTemplate:
                // "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                // "https://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png",
                "https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png",
            userAgentPackageName: "land_place",
          ),
          MarkerLayer(markers: [
            Marker(
                width: 30.0,
                height: 30.0,
                point: myLocationLatLng,
                builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.blueAccent,
                      size: 40,
                    ))
          ]),
        ],
      ),
    );
  }
}
