import 'dart:convert';

import 'package:http/http.dart' as http;

class APIServices {
  /// 서울 열린 데이터 광장 전월세 데이터 OpenAPI에서 아파트 이름으로 전세 / 월세 데이터를 가져온다.
  /// 만든 날짜 : 2023.1.9
  /// 만든이 : 권순형
  Future<Map> selectEstateData(String apartName, int endIndex) async {
    List<int> nameList = utf8.encode(apartName);

    var decodeData = "";
    for (var num in nameList) {
      decodeData += '%${num.toRadixString(16)}';
    }
    String apartAreaURL =
        'http://openapi.seoul.go.kr:8088/4e77426b416d736f353474784d7853/json/tbLnOpendataRentV/1/$endIndex/2022/%20/%20/%20/%20/%20/%20/%20/$decodeData';

    final response = await http.get(Uri.parse(apartAreaURL));
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    var dataMap = dataConvertedJSON['tbLnOpendataRentV'];
    List rowList = dataMap['row'];
    Map<String, Map<String, List>> gbnMap = {};
    Map<String, List> geonAreaMap = {};
    Map<String, List> wallAreaMap = {};

    for (var map in rowList) {
      if (map['RENT_GBN'] == '전세') {
        int area = (map['RENT_AREA'] / 3.3058).round();
        geonAreaMap['$area평'] == null
            ? geonAreaMap['$area평'] = [map['RENT_GTN']]
            : geonAreaMap['$area평']?.add(map['RENT_GTN']);
      } else if (map['RENT_GBN'] == '월세') {
        int area = (map['RENT_AREA'] / 3.3058).round();
        wallAreaMap['$area평'] == null
            ? wallAreaMap['$area평'] = [map['RENT_FEE']]
            : wallAreaMap['$area평']?.add(map['RENT_FEE']);
      }
    }

    gbnMap['전세'] = geonAreaMap;
    gbnMap['월세'] = wallAreaMap;
    return gbnMap;
  }
}
