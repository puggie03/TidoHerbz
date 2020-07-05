import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:search_map_place/search_map_place.dart';

import 'placeorderpage.dart';

class FindLocationPage extends StatefulWidget {
  final subtotal;
  final method;
  FindLocationPage({
    this.subtotal, 
    this.method,
    });

  @override
  _FindLocationPageState createState() => _FindLocationPageState();
}

class _FindLocationPageState extends State<FindLocationPage> {
  //Firebase
  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  //Google Maps
  Completer<GoogleMapController> _controller = Completer();
  MapType type;
  Location location = new Location();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-25.7478676, 28.2292712),
    zoom: 14.4746,
  );

  //Global LatLng
  LatLng currentlocation;
  String currentplace;

  Set<Marker> markers;

  @override
  void initState() {
    super.initState();
    type = MapType.hybrid;
    markers = Set.from([]);
  }

  Future<DocumentReference> _addGeoPoint(LatLng location1) async {
    GeoFirePoint point =
        geo.point(latitude: location1.latitude, longitude: location1.longitude);
    return firestore
        .collection('locations')
        .add({'position': point.data, 'name': 'User Location'});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(children: <Widget>[
        GoogleMap(
          markers: markers,
          mapType: type,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationEnabled: true,
          compassEnabled: true,
        ),
        Positioned(
          top: 60,
          left: MediaQuery.of(context).size.width * 0.05,
          child: SearchMapPlaceWidget(
            apiKey: "AIzaSyA-KqqbNG1poVwZgArWcqIaU0ZdkdKjsgY",
            location: _kGooglePlex.target,
            radius: 30000,
            onSelected: (place) async {
              final geolocation = await place.geolocation;

              final GoogleMapController controller = await _controller.future;

              controller.animateCamera(
                  CameraUpdate.newLatLng(geolocation.coordinates));
              controller.animateCamera(
                  CameraUpdate.newLatLngBounds(geolocation.bounds, 0));

              currentlocation = geolocation.coordinates;

              Marker mk1 = Marker(
                  markerId: MarkerId('1'),
                  position: geolocation.coordinates,
                  infoWindow:
                      InfoWindow(title: "remember here", snippet: "good place"),
                  icon: BitmapDescriptor.defaultMarker);
              setState(() {
                markers.add(mk1);
              });

              currentplace = place.description;
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Row(
            children: <Widget>[
              Spacer(),
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  setState(() {
                    type = type == MapType.hybrid
                        ? MapType.normal
                        : MapType.hybrid;
                  });
                },
                child: Icon(Icons.map),
              ),
              SizedBox(
                width: 20.0,
              ),
              ButtonTheme(
                minWidth: 100.0,
                child: RaisedButton(
                  onPressed: () {
                    if (currentplace != null) {
                      _addGeoPoint(currentlocation);
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              PlaceOrderPage(
                                itemstotal: widget.subtotal,
                                location: currentlocation,
                                place: currentplace,
                                method: widget.method,
                              )));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return new AlertDialog(
                              title: new Text("Error"),
                              content:
                                  new Text("Please search for your address"),
                              actions: <Widget>[
                                new MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: new Text("close"),
                                )
                              ],
                            );
                          });
                    }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
