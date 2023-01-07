import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:somsomhouse/widgets/google_map.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        // 홈아이콘
        // 검색창
        // 검색아이콘버튼
      ),
      body: Stack(
        children: [
          // 구글맵
          GoogleMapWidget()
          // 마커 상세조건
          // light/black mode 버튼
        ],
      ),
    );
  }
}
