import 'package:flutter/material.dart';
import 'package:somsomhouse/widgets/bar_chart.dart';
import 'package:somsomhouse/widgets/line_chart.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late bool isVisible;
  late List<Color> colorList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isVisible = true;
    colorList = [Colors.black, Color.fromARGB(255, 146, 144, 144)];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = true;
                  colorList = [
                    Colors.black,
                    Color.fromARGB(255, 146, 144, 144)
                  ];
                });
              },
              child: Column(
                children: [
                  Text(
                    '최근1년',
                    textScaleFactor: 1.6,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorList[0],
                    ),
                  ),
                  if (isVisible)
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      height: 2,
                      width: 90,
                      color: Colors.black,
                    ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = false;
                  colorList = const [
                    Color.fromARGB(255, 146, 144, 144),
                    Colors.black
                  ];
                });
              },
              child: Column(
                children: [
                  Text(
                    '평균',
                    textScaleFactor: 1.6,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorList[1],
                    ),
                  ),
                  if (!isVisible)
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      height: 2,
                      width: 90,
                      color: Colors.black,
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Visibility(
              visible: isVisible,
              child: const ApartLineChart(),
            ),
            Visibility(
              visible: !isVisible,
              child: const ApartBarChart(),
            ),
          ],
        ),
      ],
    );
  }
}
