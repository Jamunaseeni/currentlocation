import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController _controller;
  Position position;
  Widget _child;
  final Set<Marker> _marker = {};
  @override
  void initState() {
    // ignore: missing_required_param
    _child = SpinKitCircle(
      color: Colors.cyan,
      size: 50.0,
    );
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    Position res = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = res;
      _child = mapWidget();
    });

    void onpressedmarker() {
      setState(() {
        _marker.add(
          Marker(
              markerId: MarkerId('Home'),
              position: LatLng(position.latitude, position.longitude),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                  title: "Home", snippet: '45,Indira Nagar 2nd Street')),
        );
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map Demo'),
      ),
      body: _child,
    );
  }

  Widget mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _marker,
      initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 12.0),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
    );
  }
}
