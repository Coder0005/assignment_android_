import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocateUs extends StatefulWidget {
  const LocateUs({Key? key}) : super(key: key);

  @override
  State<LocateUs> createState() => _LocateUsState();
}

class _LocateUsState extends State<LocateUs> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  LatLng hqLocation = const LatLng(27.705017, 85.329054);
  LatLng branchLocation = const LatLng(27.703893, 85.328580);
  @override
  void initState() {
    markers.add(
      Marker(
        markerId: MarkerId(hqLocation.toString()),
        position: hqLocation,
        // POSITION OF MARKER
        infoWindow: const InfoWindow(title: "Our Head Office", snippet: 'HQ'),
        icon: BitmapDescriptor.defaultMarker,
        // Icon for marker
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId(branchLocation.toString()),
        position: branchLocation,
        // POSITION OF MARKER
        infoWindow: const InfoWindow(title: "Our Branch", snippet: 'Branch'),
        icon: BitmapDescriptor.defaultMarker,
        // Icon for marker
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Find Us Here")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // GoogleMap(
              //   zoomControlsEnabled: true,
              //   initialCameraPosition: CameraPosition(
              //     target: hqLocation,
              //     zoom: 15,
              //   ),
              //   markers: markers,
              //   mapType: MapType.terrain,
              //   onMapCreated: (controller) {
              //     // method called when map is created
              //     setState(() {
              //       mapController = controller;
              //     });
              //   },
              // ),
              // const Text("Hope You Visit Us")
              Image.asset('assets/map.jpg')
            ],
          ),
        ),
      ),
    );
  }
}
