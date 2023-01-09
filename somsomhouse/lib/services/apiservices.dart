import 'dart:convert';

import 'package:http/http.dart' as http;

class APIServices {
  // api 불러오는 함수를 작성하면 된다.

  selectArea(String apartName, int endIndex) async {
    String apartAreaURL =
        'http://openapi.seoul.go.kr:8088/4e77426b416d736f353474784d7853/json/tbLnOpendataRentV/1/${endIndex}/2022/%20/%20/%20/%20/%20/%20/%20/';

    final response = await http.get(Uri.parse(apartAreaURL));
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
  }
}
