import 'dart:convert';

import 'package:http/http.dart' as http;

class RServices {
  /// R과 연결하기 위해 스프링 부트 서버와 연결하는 부분 (기본틀 만들기 / 도림동)
  /// 만든 날짜 : 2023.1.12
  /// 만든이 : 권순형
  Future<String> connectDorimdong(
      String name, String area, String floor, String season) async {
    String googleLocationsURL =
        'http://localhost:8080/dorim?name=$name&area=$area&floor=$floor&weather=$season';

    final response = await http.get(Uri.parse(googleLocationsURL));
    var dataConverted = json.decode(utf8.decode(response.bodyBytes));
    print(dataConverted);
    return dataConverted;
  }
  Future<String> connectGwangjangdong(
    String name, String area, String floor, String season) async {
      String googleLocationsURL = 
          'http://localhost:8080/gwangjang?name=$name&area=$area&floor=$floor&weather$season';

    final response = await http.get(Uri.parse(googleLocationsURL));
    var dataConverted = json.decode(utf8.decode(response.bodyBytes));
    return dataConverted;
    }
  Future<String> connectGarakdong(
      String name, String area, String floor, String season) async {
    String googleLocationsURL =
        'http://localhost:8080/garak?name=$name&area=$area&floor=$floor&weather=$season';

    final response = await http.get(Uri.parse(googleLocationsURL));
    var dataConverted = json.decode(utf8.decode(response.bodyBytes));
    return dataConverted;
  }
  Future<String> connectOhguemdong(
      String name, String area, String floor, String season) async {
    String googleLocationsURL =
        'http://localhost:8080/ohguem?name=$name&area=$area&floor=$floor&weather=$season';

    final response = await http.get(Uri.parse(googleLocationsURL));
    var dataConverted = json.decode(utf8.decode(response.bodyBytes));
    return dataConverted;
  }
  Future<String> connectPungnabdong(
      String name, String area, String floor, String season) async {
    String googleLocationsURL =
        'http://localhost:8080/pungnab?name=$name&area=$area&floor=$floor&weather=$season';

    final response = await http.get(Uri.parse(googleLocationsURL));
    var dataConverted = json.decode(utf8.decode(response.bodyBytes));
    return dataConverted;
  }
  Future<String> connectSiheungdong(
      String name, String area, String floor, String season) async {
    String googleLocationsURL =
        'http://localhost:8080/siheung?name=$name&area=$area&floor=$floor&weather=$season';

    final response = await http.get(Uri.parse(googleLocationsURL));
    var dataConverted = json.decode(utf8.decode(response.bodyBytes));
    return dataConverted;
  }
  Future<String> connectSinchundong(
      String name, String area, String floor, String season) async {
    String googleLocationsURL =
        'http://localhost:8080/sinchun?name=$name&area=$area&floor=$floor&weather=$season';

    final response = await http.get(Uri.parse(googleLocationsURL));
    var dataConverted = json.decode(utf8.decode(response.bodyBytes));
    return dataConverted;
  }
  Future<String> connectSinjungdong(
      String name, String area, String floor, String season) async {
    String googleLocationsURL =
        'http://localhost:8080/sinjung?name=$name&area=$area&floor=$floor&weather=$season';

    final response = await http.get(Uri.parse(googleLocationsURL));
    var dataConverted = json.decode(utf8.decode(response.bodyBytes));
    return dataConverted;
  }
}
