import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chart'),
      ),
      body: ListView(
        children: [
          // 아파트 정보 리스트 뷰
          // 아파트 전세/ 월세 시간별 라인차트 리스트 뷰
          // 아파트 전세 / 월세 평균 막대그래프
        ],
      ),
    );
  }
}
