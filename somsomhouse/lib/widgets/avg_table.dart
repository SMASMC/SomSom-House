import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/services/apiservices.dart';
import 'package:somsomhouse/services/dbservices.dart';

class AvgTable extends StatefulWidget {
  const AvgTable({super.key});

  @override
  State<AvgTable> createState() => _AvgTableState();
}

class _AvgTableState extends State<AvgTable> {
  late String chartType;
  late Map full;
  late List keys;
  late List values;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chartType = "전세";
    keys = [];
    values = [];
    full = {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: selectEndIndex().then(
        (value) async {
          full = await selectEstateData(value);
          addTable();
          return true;
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 274,
            child: SpinKitThreeBounce(
              color: Colors.lightBlue,
            ),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 15, 3, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '평균 전세 보증금 & 월세',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  SizedBox(child: Text('평수')),
                  SizedBox(child: Text('금액')),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.6,
              ),
              ListView.builder(
                itemCount: keys.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            keys[index],
                          ),
                          Text(
                            chartType == '전세'
                                ? '${(values[index] / 10000).toStringAsFixed(2)}억원'
                                : '${values[index].round().toString()}만원',
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.6,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
            ],
          );
        }
      },
    );
  }

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
  addTable() {
    Map typeMap = full[chartType];
    keys = [];
    values = [];
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
      x++;
    }
  }
}
