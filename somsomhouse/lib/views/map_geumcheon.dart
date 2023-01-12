import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/models/apartname_list_model.dart';
import 'package:somsomhouse/models/apartname_predict_model.dart';

import 'package:somsomhouse/models/dongname_model.dart';
import 'package:somsomhouse/services/dbservices.dart';
import 'package:somsomhouse/views/charter_value_prediction.dart';

class Geumcheon extends StatefulWidget {
  const Geumcheon({super.key});

  @override
  State<Geumcheon> createState() => _GeumcheonState();
}

class _GeumcheonState extends State<Geumcheon> {
  late List<Widget> widgetList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widgetList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 121, 119, 166),
        title: const Text('금천구 지도'),
      ),
      body: Center(
        child: InkWell(
          splashColor: Colors.orange,
          onTapDown: (TapDownDetails details) {
            _handleTapDown(
                context, details.localPosition.dx, details.localPosition.dy);
          },
          child: Image.asset(
            'images/금천구.png',
            width: 400,
            height: 300,
          ),
        ),
      ),
    );
  }

  //-----function-------
  _handleTapDown(BuildContext context, var dx, var dy) async {
    if ((dx > 173 && dx < 205 && dy > 160 && dy < 284) ||
        (dx > 202 && dx < 260 && dy > 116 && dy < 275) ||
        (dx > 269 && dx < 309 && dy > 157 && dy < 256)) {
      DongModel.dongName = '시흥동';
      widgetList = await selectApartName();
      showPicker(context, widgetList);
    }
  }

  /// 아래쪽 스낵바에 선택한 동의 아파트 이름을 가져오기 위해서 DB 서비스와 연결하는 함수
  /// 만든 날짜 : 2023.1.10
  /// 만든이 : 노현석
  Future<List<Widget>> selectApartName() async {
    DBServices dbServices = DBServices();
    ApartNameListModel apartNameListModel =
        await dbServices.callapartName(DongModel.dongName, DongModel.guName);

    List<Widget> widgetList = [];

    for (var apartNameModel in apartNameListModel.apartNameListModel) {
      widgetList.add(Text(apartNameModel.apartName));
    }

    return widgetList;
  }

  //모달팝업창을 뜨게 하고 버튼을 누르면 다음 페이지로 이동한다.
  showPicker(BuildContext context, List<Widget> widgetList) {
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
                      children: widgetList,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          ApartNamePredict.apartNamePredict =
                              widgetList[value].toString();
                          //CupertinoPicker에서 선택한 아파트 이름을 static에 저장해준다.
                        });
                      },
                    ),
                  ),
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const CharterPrediction()))); // 테스트니까 나중에 꼭 바꾸기
                    },
                  ),
                ],
              ),
            ));
  }
}//end
