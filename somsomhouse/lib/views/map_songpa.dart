import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/models/apartname_list_model.dart';
import 'package:somsomhouse/models/apartname_predict_model.dart';
import 'package:somsomhouse/models/dongname_model.dart';
import 'package:somsomhouse/services/dbservices.dart';
import 'package:somsomhouse/views/charter_value_prediction.dart';

class Songpa extends StatefulWidget {
  const Songpa({super.key});

  @override
  State<Songpa> createState() => _SongpaState();
}

class _SongpaState extends State<Songpa> {
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
        title: const Text('송파구 지도'),
      ),
      body: Center(
        child: InkWell(
          splashColor: Colors.orange,
          onTapDown: (TapDownDetails details) {
            _handleTapDown(
                context, details.localPosition.dx, details.localPosition.dy);
          },
          child: Image.asset(
            'images/송파구.png',
            width: 400,
            height: 300,
          ),
        ),
      ),
    );
  }

  //-----function-------
  _handleTapDown(BuildContext context, var dx, var dy) async {
    if ((dx > 187 && dx < 211 && dy > 62 && dy < 98) ||
        (dx > 172 && dx < 208 && dy > 80 && dy < 101)) {
      DongModel.dongName = '풍납동';
      widgetList = await selectApartName();
      showPicker(context, widgetList);
    } else if ((dx > 161 && dx < 197 && dy > 110 && dy < 132) ||
        (dx > 151 && dx < 167 && dy > 99 && dy < 129)) {
      DongModel.dongName = '신천동';
      widgetList = await selectApartName();
      showPicker(context, widgetList);
    } else if ((dx > 236 && dx < 251 && dy > 143 && dy < 161) ||
        (dx > 219 && dx < 237 && dy > 140 && dy < 158)) {
      DongModel.dongName = '오금동';
      widgetList = await selectApartName();
      showPicker(context, widgetList);
    } else if ((dx > 166 && dx < 195 && dy > 167 && dy < 182) ||
        (dx > 198 && dx < 224 && dy > 160 && dy < 179) ||
        (dx > 208 && dx < 236 && dy > 170 && dy < 179)) {
      DongModel.dongName = '가락동';
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
        await dbServices.callapartName(DongModel.dongName);

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
                        ApartNamePredict.apartNamePredict =
                            widgetList[value].toString();
                        //CupertinoPicker에서 선택한 아파트 이름을 static에 저장해준다.
                      },
                    ),
                  ),
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () {
                      print(ApartNamePredict.apartNamePredict);
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
