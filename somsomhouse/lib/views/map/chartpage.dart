import 'package:flutter/material.dart';
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/widgets/avg_table.dart';
import 'package:somsomhouse/widgets/chart.dart';
import 'package:somsomhouse/views/map/comment.dart';
import 'package:somsomhouse/widgets/apart_info.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(232, 105, 183, 255),
        centerTitle: true,
        title: Text(ChartModel.apartName),
      ),
      body: ListView(
        children: const [
          Card(
            child: ApartInfo(),
          ),
          Card(
            child: Chart(),
          ),
          Card(
            child: AvgTable(),
          ),
          Card(
            child: Comment(),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
