import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/widgets/google_map.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    final authentication =
        FirebaseAuth.instance; //firebaseauth로 firebase에 값을 저장하는 역할을 함.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(232, 105, 183, 255),
        title: const Text('아파트 선택하기'),
        leading: const Icon(null),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              authentication.signOut();
            },
          ),
        ],
        // 홈아이콘
        // 검색창
        // 검색아이콘버튼
      ),
      body: Stack(
        children: [
          // 구글맵
          GoogleMapWidget(),
          // 마커 상세조건
          // light/black mode 버튼
        ],
      ),
    );
  }
}
