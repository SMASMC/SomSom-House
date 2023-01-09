import 'package:flutter/material.dart';
import 'package:somsomhouse/widgets/line_chart.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chart'),
      ),
      body: ListView(
        children: const [
          Card(
            child: ApartLineChart(),
          ),
        ],
      ),
    );
  }
}
