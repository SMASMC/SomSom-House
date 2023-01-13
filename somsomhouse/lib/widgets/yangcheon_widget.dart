import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/models/apartname_list_model.dart';
import 'package:somsomhouse/models/dongname_model.dart';
import 'package:somsomhouse/services/dbservices.dart';
import 'package:somsomhouse/views/predict/gu/sinjungdong_prediction.dart';

class YangcheonWidget extends StatefulWidget {
  const YangcheonWidget({super.key});

  @override
  State<YangcheonWidget> createState() => _YangcheonWidgetState();
}

class _YangcheonWidgetState extends State<YangcheonWidget> {
  late List<Widget> widgetList;
  late List<String> nameList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widgetList = [];
    nameList = [];
  }

  @override
  Widget build(BuildContext context) {
    final _authentication = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 121, 119, 166),
        title: const Text('양천구 지도'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              _authentication.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: InkWell(
          splashColor: Color.fromARGB(255, 121, 119, 166),
          onTapDown: (TapDownDetails details) {
            _handleTapDown(
                context, details.localPosition.dx, details.localPosition.dy);
          },
          child: Image.asset(
            'images/양천구.png',
            width: 400,
            height: 300,
          ),
        ),
      ),
    );
  }

  //-----function-------
  _handleTapDown(BuildContext context, var dx, var dy) async {
    if ((dx > 118 && dx < 193 && dy > 220 && dy < 258) ||
        (dx > 204 && dx < 254 && dy > 148 && dy < 240) ||
        (dx > 267 && dx < 313 && dy > 173 && dy < 252)) {
      DongModel.dongName = '신정동';

      widgetList = await selectApartName();
      showPicker(widgetList);
      DongModel.apartNamePredict = nameList[1];
      //시작할때 CupertinoPicker의 initialItem이랑 동일하게 넣어준다.
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
      widgetList.add(Center(child: Text(apartNameModel.apartName)));
      nameList.add(apartNameModel.apartName);
    }

    return widgetList;
  }

  //모달팝업창을 뜨게 하고 버튼을 누르면 다음 페이지로 이동한다.
  showPicker(List<Widget> widgetList) {
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
                        DongModel.apartNamePredict = nameList[value];
                        //CupertinoPicker에서 선택한 아파트 이름을 static에 저장해준다.
                      },
                    ),
                  ),
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      goDongPage();
                    },
                  ),
                ],
              ),
            ));
  }

  goDongPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SinjungdongPrediction(),
        ));
  }
}//end
