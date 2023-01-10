import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/charter_value_prediction.dart';

class Picker extends StatefulWidget {
  const Picker({super.key});

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  List<String> itemsString=['광장힐스테이트','신동아파밀리에','워커힐푸르지오','현대3단지','현대홈타운12차'];

  List<Widget> items =  [
                Center(child: Text('광장힐스테이트',)),
                Center(child: Text('신동아파밀리에')),
                Center(child: Text('워커힐푸르지오')),
                Center(child: Text('현대3단지')),
                Center(child: Text('현대홈타운12차')),    
              ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Picker'
          ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showPicker(context);
          }, 
          child: Text('아파트 선택하기')),
      ),
    );
  }

  /// 동 선택 후 해당되는 아파트 보여주고 선택하기 위한 함수
  /// 만든날짜 : 2023.1.9
  /// 만든이 : 임은빈
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
                scrollController: FixedExtentScrollController(initialItem: 1,),
                children: items,
                onSelectedItemChanged: (value) {
                },

                ),
            ),
              CupertinoButton(child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: ((context) => CharterPrediction()))); // 테스트니까 나중에 꼭 바꾸기
                
              },),
          ],
        ),
      ));
  }
}