import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:somsomhouse/models/apartinfo_model.dart';
import 'package:somsomhouse/models/apartname_list_model.dart';
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/models/map_model.dart';

class DBServices {
  /// DB에서 내 위치기준으로 줌레벨에 따른 좌표값들을 가져온다.
  /// 만든 날짜 : 2023.1.9
  /// 만든이 : 권순형
  Future<GoogleMapModel> getApartments(
      double lat, double lng, double zoomLevel) async {
    String googleLocationsURL =
        'http://10.0.2.2:8080/get_location?lat=$lat&lng=$lng&zoomlevel=$zoomLevel';

    final response = await http.get(Uri.parse(googleLocationsURL));
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    return GoogleMapModel.fromJson(dataConvertedJSON);
  }

  /// DB에서 아파트별로 2022년 전세, 월세 데이터의 개수가 몇 개인지 가져온다.
  /// 만든 날짜 : 2023.1.9
  /// 만든이 : 권순형
  Future<bool> selectEndIndex(String apartName) async {
    String url = 'http://localhost:8080/get_end_index?name=$apartName';

    final response = await http.get(Uri.parse(url));
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List data = dataConvertedJSON['results'];
    ChartModel.geonSaeEndIndex = data[0]['geonSaeEndIndex'];
    ChartModel.wallSaeEndIndex = data[0]['wallSaeEndIndex'];
    return true;
  }

  Future<ApartInfoModel> callapartInfo(String apartinfoName) async {
    String url = 'http://10.0.2.2:8080/apartment_info?name=${apartinfoName}';

    final response = await http.get(Uri.parse(url));
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List dataList = dataConvertedJSON['results'];
    return ApartInfoModel.fromJson(dataList[0]);
  }

  //DB에서 동별로 아파트 이름을 가져온다
  //만든 날짜 : 2023.1.10
  //만든이 : 노현석
  Future<ApartNameListModel> callapartName(String dongName) async {
    String url = 'http://10.0.2.2:8080/getApartName?dong=${dongName}';

    final response = await http.get(Uri.parse(url));
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    return ApartNameListModel.fromJson(dataConvertedJSON);
  }
}
