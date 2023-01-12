import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/models/apartname_list_model.dart';
import 'package:somsomhouse/models/dongname_model.dart';
import 'package:somsomhouse/services/dbservices.dart';
import 'package:somsomhouse/views/dorimdong_prediction.dart';
import 'package:somsomhouse/views/garakdong_prediction.dart';
import 'package:somsomhouse/views/gwangjangdong_prediction.dart';
import 'package:somsomhouse/views/ohgeumdong_prediction.dart';
import 'package:somsomhouse/views/pungnabdong_prediction.dart';
import 'package:somsomhouse/views/siheungdong_prediction.dart';
import 'package:somsomhouse/views/sincheondong_prediction.dart';
import 'package:somsomhouse/views/sinjungdong_prediction.dart';

class Geumcheon extends StatefulWidget {
  const Geumcheon({super.key});

  @override
  State<Geumcheon> createState() => _GeumcheonState();
}

class _GeumcheonState extends State<Geumcheon> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 121, 119, 166),
        title: const Text('금천구 지도'),
      ),
      body: Center(
        child: InkWell(
          splashColor: Color.fromARGB(255, 121, 119, 166),
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
      showPicker(widgetList);
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
                        setState(() {
                          DongModel.apartNamePredict = nameList[value];
                          //CupertinoPicker에서 선택한 아파트 이름을 static에 저장해준다.
                        });
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

  //선택된 아파트에 해당되는 동으로 각각 다른 예측페이지로 이동하게 함
  //만든날짜 : 2023.01.12
  //만든이 : 노현석
  goDongPage() {
    if (DongModel.dongName == '도림동') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DorimdongPrediction(),
          ));
    } else if (DongModel.dongName == '가락동') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GarakdongPrediction(),
          ));
    } else if (DongModel.dongName == '광장동') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GwangjangdongPrediction(),
          ));
    } else if (DongModel.dongName == '오금동') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OgmdongPrediction(),
          ));
    } else if (DongModel.dongName == '풍납동') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PunabdongPrediction(),
          ));
    } else if (DongModel.dongName == '시흥동') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SiheungdongPrediction(),
          ));
    } else if (DongModel.dongName == '신천동') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SincheondongPrediction(),
          ));
    } else if (DongModel.dongName == '신정동') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SinjungdongPrediction(),
          ));
    }
  }
}//end
