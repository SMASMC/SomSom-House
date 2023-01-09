import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/services/apiservices.dart';
import 'package:somsomhouse/services/dbservices.dart';

class ApartLineChart extends StatefulWidget {
  const ApartLineChart({super.key});

  @override
  State<ApartLineChart> createState() => _ApartLineChartState();
}

class _ApartLineChartState extends State<ApartLineChart> {
  // api 값 받아오기 위한 변수 선언
  late Map full;
  late List<String> keys;
  late String selectedArea;
  late String chartType;
  late List<FlSpot> chartList;
  late double length;
  late double max;
  late double min;
  late bool changeType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    full = {};
    keys = [];
    selectedArea = "";
    chartType = "전세";
    chartList = [];
    length = 0;
    max = 0;
    min = 0;
    changeType = false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: selectEndIndex().then((value) async {
        full = await selectEstateData(value);
        keys = full[chartType].keys.toList();
        if (selectedArea == "" || changeType) {
          selectedArea = keys[0];
          changeType = false;
        }
        changeChartList();
        return true;
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return const CircularProgressIndicator();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          changeType = true;
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
                        items: keys
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedArea,
                        onChanged: (value) {
                          setState(() {
                            selectedArea = value!;
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
                    maxX: length,
                    minY: min,
                    maxY: max,
                    lineBarsData: [
                      LineChartBarData(
                        spots: chartList,
                      ),
                    ],
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

  /// chartList를 전세인지 월세인지 또는 평수가 몇평인지에 따라서 바꾸도록 하는 함수
  /// 만든날짜 : 2023.1.10
  /// 만든이 : 권순형
  changeChartList() {
    chartList = [];
    max = 0;
    List numList = full[chartType][selectedArea];
    int x = 0;
    for (var num in numList) {
      if (x == 0) {
        min = double.parse(num);
      }
      max = max < double.parse(num) ? double.parse(num) : max;
      min = min > double.parse(num) ? double.parse(num) : min;
      chartList.add(FlSpot(double.parse(x.toString()), double.parse(num)));
      x++;
    }

    if (min > 1000) {
      min = min - 3000;
      max = max + 3000;
    } else {
      min = min - 10;
      max = max + 20;
    }
    // list 역순으로 바꾸기
    chartList = List.from(chartList.reversed);

    length = double.parse(chartList.length.toString());

    setState(() {});
  }
}
