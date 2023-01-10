import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/test.dart';

class Picker extends StatefulWidget {
  const Picker({super.key});

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  List<String> itemsString = [
    '광장힐스테이트',
    '신동아파밀리에',
    '워커힐푸르지오',
    '현대3단지',
    '현대홈타운12차'
  ];

  List<Widget> items = [
    Center(
        child: Text(
      '광장힐스테이트',
    )),
    Center(child: Text('신동아파밀리에')),
    Center(child: Text('워커힐푸르지오')),
    Center(child: Text('현대3단지')),
    Center(child: Text('현대홈타운12차')),
  ];

  @override
  Widget build(BuildContext context) {
    return showPicker(context);
  }

  // ---- Functions
  showPicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
              height: 300,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 50,
                      scrollController: FixedExtentScrollController(
                        initialItem: 1,
                      ),
                      children: items,
                      onSelectedItemChanged: (value) {},
                    ),
                  ),
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const Test()))); // 테스트니까 나중에 꼭 바꾸기
                    },
                  ),
                ],
              ),
            ));
  }
}
