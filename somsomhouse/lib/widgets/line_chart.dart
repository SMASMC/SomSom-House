import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/models/chart_model.dart';

class ApartLineChart extends StatefulWidget {
  const ApartLineChart({super.key});

  @override
  State<ApartLineChart> createState() => _ApartLineChartState();
}

class _ApartLineChartState extends State<ApartLineChart> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  String selectedArea = 'Item1';
  String selectedType = '전세';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(ChartModel.apartName),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSlidingSegmentedControl<String>(
                initialValue: selectedType,
                children: const {
                  '전세': Text('전세'),
                  '월세': Text('월세'),
                },
                onValueChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
                decoration: BoxDecoration(
                  color: CupertinoColors.lightBackgroundGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                thumbDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInToLinear,
                fixedWidth: 80,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 30, 8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedArea,
                  onChanged: (value) {
                    setState(() {
                      selectedArea = value as String;
                    });
                  },
                  buttonHeight: 60,
                  buttonWidth: 140,
                  itemHeight: 40,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 500,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 4, //length
              minY: 0,
              maxY: 5,
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 1),
                    FlSpot(1, 2),
                    FlSpot(2, 4),
                    FlSpot(3, 3),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
