import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/models/map_model.dart';
import 'package:somsomhouse/services/dbservices.dart';
import 'package:somsomhouse/views/chartpage.dart';

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
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) async {
            _onMapCreated(controller);
            await addMarker(context);
          },
          initialCameraPosition: CameraPosition(
            target: GoogleMapModel.currentLocation,
            zoom: GoogleMapModel.zoomLevel,
          ),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          markers: _markers.values.toSet(),
          onCameraMove: (position) {
            setState(() {
              GoogleMapModel.currentLocation = position.target;
            });
            addMarker(context);
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
                  setState(() {
                    GoogleMapModel.zoomLevel = zoomLevel + 1;
                  });
                  mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: GoogleMapModel.currentLocation,
                        zoom: GoogleMapModel.zoomLevel,
                      ),
                    ),
                  );
                },
                color: Colors.blue,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(Icons.add),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  var zoomLevel = await mapController.getZoomLevel();
                  setState(() {
                    GoogleMapModel.zoomLevel = zoomLevel - 1;
                  });
                  mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: GoogleMapModel.currentLocation,
                        zoom: GoogleMapModel.zoomLevel,
                      ),
                    ),
                  );
                },
                color: Colors.blue,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------------------------------
  /// 좌표를 이용해서 marker 추가 함수
  /// 만든 날짜 : 2023.1.9
  /// 만든이 : 권순형
  addMarker(BuildContext context) async {
    final apartments = await getApartments();
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
            ChartModel.apartName = apartment.name;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChartPage(),
                ));
          },
        );
        _markers[apartment.name] = marker;
      }
    });
  }

  /// 마커 찍을 좌표 DB에서 가져오기
  /// 만든 날짜 : 2023.1.9
  /// 만든이 : 권순형
  Future<GoogleMapModel> getApartments() async {
    DBServices dbServices = DBServices();
    GoogleMapModel locations = await dbServices.getApartments(
      GoogleMapModel.currentLocation.latitude,
      GoogleMapModel.currentLocation.longitude,
      GoogleMapModel.zoomLevel,
    );

    return locations;
  }
}
