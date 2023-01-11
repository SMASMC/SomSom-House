import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/services/apiservices.dart';
import 'package:somsomhouse/services/dbservices.dart';

class ApartBarChart extends StatefulWidget {
  const ApartBarChart({super.key});

  @override
  State<ApartBarChart> createState() => _ApartBarChartState();
}

class _ApartBarChartState extends State<ApartBarChart> {
  late Map full;
  late List<BarChartGroupData> barList;
  late String chartType;
  late List keys;
  late List values;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    full = {};
    barList = [];
    chartType = "전세";
    keys = [];
    values = [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: selectEndIndex().then((value) async {
        full = await selectEstateData(value);
        addBarChart();
        return true;
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return const SizedBox(
            height: 376,
            child: SpinKitThreeBounce(
              color: Colors.lightBlue,
            ),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(fontSize: 15),
            ),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSlidingSegmentedControl<String>(
                  initialValue: chartType,
                  children: const {
                    '전세': Text('전세'),
                    '월세': Text('월세'),
                  },
                  onValueChanged: (value) {
                    setState(() {
                      chartType = value;
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
              SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BarChart(
                    BarChartData(
                      barGroups: barList,
                      gridData: FlGridData(
                        drawVerticalLine: false,
                        drawHorizontalLine: false,
                      ),
                      borderData: FlBorderData(border: const Border()),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  // --------------------------------------------------------------
  /// 해당 아파트의 2022 전세 월세 데이터가 몇개 있는지 DB에서 불러오기
  /// 만든날짜 : 2023.1.9
  /// 만든이 : 권순형
  Future<int> selectEndIndex() async {
    DBServices dbServices = DBServices();
    await dbServices.selectEndIndex(ChartModel.apartName);

    return ChartModel.geonSaeEndIndex + ChartModel.wallSaeEndIndex;
  }

  /// DB에서 불러온 데이터 숫자를 가지고 API에서 전월세 데이터 가져오기
  /// 만든날짜 : 2023.1.9
  /// 만든이 : 권순형
  Future<Map> selectEstateData(int num) async {
    APIServices apiServices = APIServices();
    var result = await apiServices.selectEstateData(ChartModel.apartName, num);

    return result;
  }

  /// full 변수 이용하여 barChart에 들어갈 데이터를 만든다.
  /// 만든 날짜 : 2023.1.10
  /// 만든이 : 권순형
  addBarChart() {
    barList = [];
    Map typeMap = full[chartType];
    keys = typeMap.keys.toList();
    keys.sort();
    int x = 1;
    for (var key in keys) {
      List typeKeyList = typeMap[key];
      double sum = 0;
      for (var val in typeKeyList) {
        sum += double.parse(val);
      }
      sum = sum / typeKeyList.length;
      values.add(sum);
      barList.add(
        BarChartGroupData(
          x: x,
          barRods: [
            BarChartRodData(
              toY: sum,
              width: 25,
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 176, 191, 237),
                  Color.fromARGB(255, 176, 168, 246),
                ],
                begin: Alignment(0, 1),
                end: Alignment(0.0, -1),
              ),
            ),
          ],
        ),
      );
      x++;
    }
  }

  /// y축 좌표값 찍기
  /// 만든날짜 : 2023.1.10
  /// 만든이 : 권순형
  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: (value, meta) {
          String text = '';
          for (var i = 0; i < barList.length; i++) {
            if (value.toInt() == (i + 1)) {
              text = '${keys[i]}';
            }
          }

          return Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      );
}
