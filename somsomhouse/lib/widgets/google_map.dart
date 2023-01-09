import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:somsomhouse/models/apartment.dart' as locations;
import 'package:somsomhouse/view_models/final_view_models.dart';
import 'package:somsomhouse/views/next_page.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FinalViewModel>(context);
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            _onMapCreated(controller);
            addMarker(context, vm.currentLocation.latitude,
                vm.currentLocation.longitude, vm.zoomLevel);
          },
          initialCameraPosition: CameraPosition(
            target: vm.currentLocation,
            zoom: vm.zoomLevel,
          ),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          markers: _markers.values.toSet(),
          onCameraMove: (position) {
            vm.changeCurrentLocation(position.target);
            addMarker(context, vm.currentLocation.latitude,
                vm.currentLocation.longitude, vm.zoomLevel);
          },
        ),
        Positioned(
          top: 580,
          left: 330,
          child: Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  var zoomLevel = await mapController.getZoomLevel();
                  vm.changeZoomLevel(zoomLevel + 1);
                  mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: vm.currentLocation,
                        zoom: vm.zoomLevel,
                      ),
                    ),
                  );
                },
                color: Colors.blue,
                child: Icon(Icons.add),
                textColor: Colors.white,
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  var zoomLevel = await mapController.getZoomLevel();
                  vm.changeZoomLevel(zoomLevel - 1);
                  mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: vm.currentLocation,
                        zoom: vm.zoomLevel,
                      ),
                    ),
                  );
                },
                color: Colors.blue,
                child: Icon(Icons.remove),
                textColor: Colors.white,
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------------------------------
  // marker 추가 함수
  addMarker(
      BuildContext context, double lat, double lng, double zoomLevel) async {
    final apartments = await locations.getApartments(lat, lng, zoomLevel);

    setState(() {
      _markers.clear();
      for (final apartment in apartments.apartments) {
        final marker = Marker(
          markerId: MarkerId(apartment.name),
          position: LatLng(apartment.lat, apartment.lng),
          infoWindow: InfoWindow(
            title: apartment.name,
          ),
          onTap: () {
            final vm = Provider.of<FinalViewModel>(context, listen: false);
            vm.changeApartName(apartment.name);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NextPage(),
                ));
          },
        );
        _markers[apartment.name] = marker;
      }
    });
  }
}
