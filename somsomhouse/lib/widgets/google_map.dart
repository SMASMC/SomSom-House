import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/models/map_model.dart';
import 'package:somsomhouse/services/dbservices.dart';
import 'package:somsomhouse/views/map/chartpage.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;
  late int count;
  late Color modeBgColor;
  late Color modeTxtColor;
  late bool isDark;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = 0;

    modeBgColor = Colors.black;
    modeTxtColor = Colors.white;
    isDark = false;
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
          top: MediaQuery.of(context).size.height * 0.53,
          left: MediaQuery.of(context).size.width * 0.78,
          child: Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  changeColor(mapController);
                  isDark = !isDark;
                  isDark
                      ? setState(() {
                          modeBgColor = Colors.white;
                          modeTxtColor = Colors.black;
                        })
                      : setState(() {
                          modeBgColor = Colors.black;
                          modeTxtColor = Colors.white;
                        });
                },
                color: modeBgColor,
                textColor: modeTxtColor,
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(Icons.light_rounded),
              ),
              SizedBox(
                height: 10,
              ),
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
                color: Color.fromARGB(246, 105, 183, 255),
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
                color: Color.fromARGB(246, 105, 183, 255),
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

//Map dark mode
  void changeColor(GoogleMapController controller) async {
    count++;
    if (count % 2 == 0) {
      String value = await DefaultAssetBundle.of(context)
          .loadString('json/map_style_white.json');
      mapController.setMapStyle(value);
    } else {
      String value = await DefaultAssetBundle.of(context)
          .loadString('json/map_style_black.json');
      mapController.setMapStyle(value);
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('json/map_style_white.json');
    mapController.setMapStyle(value);
  }
}//End
