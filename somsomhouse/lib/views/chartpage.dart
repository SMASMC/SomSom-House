import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:somsomhouse/views/barchartpage.dart';
import 'package:somsomhouse/widgets/apart_chart.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 400,
                height: 800,
                child: ChartWidget(),
              ),
            ],
          ),
          // Row(
          //   children: [
          //     SizedBox(
          //       width: 400,
          //       height: 500,
          //       child: BarChartPage(),
          //     ),
          //   ],
          // ),
        ],
      ),
    ));
  }
}
