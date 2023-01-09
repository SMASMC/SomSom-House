import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:somsomhouse/views/barchartpage.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  late List data; //JSON data를 불러오기 위한 변수 호출
  late List pricegeneration; //전세를 저장하는 배열
  late List pricegeneration2; //월세를 저장하는 배열
  late String generationtext; //전/월세 표기를 나타내는 버튼의 텍스트 지정

  late List<String> items; //dropdown 버튼을 위한 선언;
  String? selectedValue;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;
  late int generationcount = 0;
  late int sqft;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [];
    pricegeneration = [];
    pricegeneration2 = [];
    generationtext = '전세';
    // generationcount = 0;
    items = [];
    sqft = 0;
    getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? Padding(
              padding:
                  const EdgeInsets.fromLTRB(0, 300, 0, 0), //차트 위치 지정하기 위한 선언
              child: Stack(
                children: <Widget>[
                  const AspectRatio(
                    aspectRatio: 1.70,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          //background 백그라운드
                          Radius.circular(18),
                        ),
                        color: Color.fromARGB(255, 35, 44, 53),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 18,
                          left: 12,
                          top: 24,
                          bottom: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                    child: ElevatedButton(
                        onPressed: () {
                          //
                        },
                        child: Text('${generationtext}')),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(290, 5, 0, 0),
                    child: SizedBox(
                      width: 80,
                      child: CustomDropdownButton2(
                        hint: '평수',
                        dropdownItems: items,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        // iconEnabledColor: Colors.black, 화살표 색상
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14), //버튼 둥글게
                          // border: Border.all(color: Colors.black),
                          color: Color.fromARGB(
                              255, 55, 63, 69), //background colors 같은거
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1500,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
                    child: BarChartPage(),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.fromLTRB(0, 300, 0, 0), //차트 위치 지정하기 위한 선언

                child: Stack(
                  children: <Widget>[
                    Center(
                      child: AspectRatio(
                        aspectRatio: 1.70,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              //background 백그라운드
                              Radius.circular(18),
                            ),
                            color: Color.fromARGB(255, 35, 44, 53),
                          ),
                          child: Padding(
                            //바둑판 같은 위아래 양옆 크기 조절
                            padding: const EdgeInsets.only(
                              right: 18,
                              left: 12,
                              top: 40,
                              bottom: 12,
                            ),
                            child: LineChart(
                              showAvg ? avgData() : mainData(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 34,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showAvg = !showAvg;
                          });
                        },
                        child: Text(
                          '평균가',
                          style: TextStyle(
                            fontSize: 14,
                            color: showAvg
                                ? Colors.white.withOpacity(0.5)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              generationcount++;
                              data = [];
                              items = [];
                              getJSONData();
                            });
                            print(generationcount);
                          },
                          child: Text('${generationtext}')),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(290, 5, 0, 0),
                          child: SizedBox(
                            width: 80,
                            child: CustomDropdownButton2(
                              hint: '평수',
                              dropdownItems: items,
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                              // iconEnabledColor: Colors.black, 화살표 색상
                              buttonDecoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(14), //버튼 둥글게
                                // border: Border.all(color: Colors.black),
                                color: Colors.blue, //background colors 같은거
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 1500,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
                      child: BarChartPage(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    //x축 나오는 것 표기하는 것
    const style = TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    List<Widget> text = []; //Widget 위젯으로 값을 저장하기 위해서 선언
    Widget widgetText = text as Widget;
    text.add(Text('data', style: style));
    print(text);
    //spotlist.add(FlSpot(x, data[i]));
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: widgetText,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    //provider로 줘야하는 것은 y값 범위와 x 갯수
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text = '';
    switch (value.toInt()) {
      case 1:
        text = '1억';
        break;
      case 3:
        text = '3억';
        break;
      case 5:
        text = '5억';
        break;
      case 7:
        text = '7억';
        break;
      case 9:
        text = '9억';
        break;
      case 11:
        text = '11억';
        break;
      case 13:
        text = '13억';
        break;
      case 15:
        text = '15억';
        break;
      case 17:
        text = '17억';
        break;
      case 19:
        text = '19억';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    double max =
        data.reduce((value, element) => value < element ? value : element);
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: data.length - 1, //length
      minY: 0,
      maxY: max + 1, //값의 최대 범위를 지정하는 것 최대값에 +1로 이게 높낮이 높 낮이
      lineBarsData: [
        LineChartBarData(
          //좌표 ##### 여기에 값을 넣어줘야함! x값 표기
          spots:
              //X, Y축
              listflSpot(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              //그래프 밑에 색상
              colors: gradientColors
                  .map((color) => color.withOpacity(0.5)) //그라데이션 짙음 설정
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    //avg 평균 값 그래프 선 나타내기
    double max =
        data.reduce((value, element) => value < element ? value : element);
    return LineChartData(
      // lineTouchData: LineTouchData(enabled: false), //이건 차트를 눌렀을 때, 값을 표기하는 역할
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: data.length - 1, //length
      minY: 0,
      maxY: max + 1, //값의 최대 범위를 지정하는 것 최대값에 +1로 이게 높낮이 높 낮이
      lineBarsData: [
        LineChartBarData(
          spots: listflSpotavg(),
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //----------Function---------------------
  Future<bool> getJSONData() async {
    var url = Uri.parse(
        'http://openapi.seoul.go.kr:8088/4e77426b416d736f353474784d7853/json/tbLnOpendataRentV/1/5/2022/%20/%20/%20/%20/%20/%20/%20/%EC%9A%B0%EB%A6%AC%EC%9C%A0%EC%95%A4%EB%AF%B8');
    //요청인자에서 타입이 (필수)로 표기 되어있는 값을 url에 넣어줘야함.
    //localhotst:8080/insert.jsp?userid=msoko1&userpw=1234
    //물음표(?)는 동일한 파일에서 가져오겠다는 것임
    //슬레시(/)는 세부적으로 들어가서 보여지는 데이터 파일이 따로 있는 것임
    var response = await http.get(url); //가져오기

    var dateConvertedJSON = await json
        .decode(utf8.decode(response.bodyBytes)); //bodyBytes라고해야 한글이 읽힘
    List priceNull = []; //전세 저장
    List priceNull3 = []; //월세 저장
    List<String> Textlist = [];
    List<String> Textlistmonth = [];
    List apartment = []; //임대면적 전세
    List apartmentmonth = []; //임대면적 월세

    Map result = dateConvertedJSON['tbLnOpendataRentV'];
    List row = result['row'];
    for (int i = 0; i < row.length; i++) {
      var price = double.parse(row[i]['RENT_GTN']); //parse는 큰 따옴표를 지워주는 역할을 함.
      var price2 = (row[i]['RENT_GBN'])
          .toString(); //가져와야하는 것이 String 형식이기 때문에 parse를 사용하면 문자열로 가져오지 못하므로 parse를 사용하지 않는다.
      var AREA = (row[i]['RENT_AREA']); //임대면적
      if (price2 == '전세') {
        priceNull.add(price / 10000);
        Textlist.add((AREA * 0.3025).floor().toString());
        for (int z = 0; z < Textlist.length; z++) {
          //
          // if (Textlist[z] == selectedValue) {
          //   priceNull = priceNull[z];
          //   print(priceNull);
          // }
        }
        // 여기에 index 맞춰서 뽑아서 보여주는 걸로 수정하기
        //  여기에 각 평수를 넣어주기 전세 평수 값
      } else if (price2 == '월세') {
        priceNull3.add(price / 10000);
        Textlistmonth.add((AREA * 0.3025).floor().toString());
        print(priceNull3);
        print(Textlistmonth);
        //여기에 각 평수를 넣어주기 월세 평수 값
      }
//orrange를 최근 것으로 돌려서 보여주도록 하는 것 차트에서 List값을 반대부터 출력하는 것으로 하면 됨.
    }
    setState(() {
      if (generationcount % 2 == 0) {
        generationtext = '전세';
        items.addAll(Textlist);
        data.addAll(priceNull);
      } else {
        generationtext = '월세';
        data.addAll(priceNull3);
        items.addAll(Textlistmonth);
      }
    });
    return true;
  }

  List<FlSpot> listflSpot() {
    List<FlSpot> spotlist = [];
    double x = 0;

    for (int i = 0; i < data.length; i++) {
      //각 X축, Y축에 해당되는 값을 List(배열)로 저장하는 역할
      spotlist.add(FlSpot(x, data[i]));
      x++;
    }
    return spotlist;
  }

  List<FlSpot> listflSpotavg() {
    List<FlSpot> spotlist = [];
    double x = 0;
    double totalY = 0;
    for (int i = 0; i < data.length; i++) {
      totalY += data[i];
    }
    for (int j = 0; j < data.length; j++) {
      var num = totalY / data.length;
      var result =
          double.parse(num.toStringAsFixed(2)); //double로 형변환해서 소수점 둘째자리까지 표기
      spotlist.add(FlSpot(x, result));
      x++;
    }
    return spotlist;
  }
} //End