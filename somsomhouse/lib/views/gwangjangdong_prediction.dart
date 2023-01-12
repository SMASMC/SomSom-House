import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/models/dongname_model.dart';
import 'package:somsomhouse/services/rservcies.dart';

class GwangjangdongPrediction extends StatefulWidget {
  const GwangjangdongPrediction({super.key});

  @override
  State<GwangjangdongPrediction> createState() =>
      _GwangjangdongPredictionState();
}

class _GwangjangdongPredictionState extends State<GwangjangdongPrediction> {
  // 임대 면적, 층 수 겂 범위 정하기 위해 변수 및 컨트롤러 작성
  late TextEditingController apartRentalController;
  late TextEditingController apartFloorController;

  int apartRental = 0;
  int apartFloor = 0;

  @override
  void initState() {
    super.initState();
    apartFloorController = TextEditingController();
    apartRentalController = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();
  FocusNode rentalFocusNode = FocusNode();
  FocusNode floorFocusNode = FocusNode();

// 계약 계절 드롭다운을 위한 리스트
  List<String> dropdownList = ['봄', '여름', '가을', '겨울'];
  String? selectedDropdown = '';

  @override
  Widget build(BuildContext context) {
    final _authentication = FirebaseAuth.instance;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 121, 119, 166),
          title: const Text('전세값 예측해 보기'),
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
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Text(
                      DongModel.apartNamePredict,
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.transparent,
                        shadows: [
                          Shadow(offset: Offset(0, -20), color: Colors.black54)
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: apartRentalController,
                    focusNode: rentalFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '임대 면적',
                      labelText: '임대 면적',
                      prefixIcon: const Icon(Icons.content_paste),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    // validator를 통한 임대 면적 범위 지정
                    textInputAction: TextInputAction.next,
                    validator: (rental) {
                      rental = rental == '' || rental == null ? '0' : rental;
                      apartRental = int.parse(rental);
                      if (apartRental < 59.67 || apartRental > 147.23) {
                        return '59.67m²부터 147.23m²까지만 입력해 주세요';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TextFormField(
                      controller: apartFloorController,
                      focusNode: floorFocusNode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '층 수',
                        labelText: '층 수',
                        prefixIcon: const Icon(Icons.show_chart),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // validator를 통한 층 수 범위 지정
                      validator: (floor) {
                        floor = floor == '' || floor == null ? '0' : floor;
                        apartFloor = int.parse(floor);
                        if (apartFloor < 1 || apartFloor > 23) {
                          return '1층부터 23층까지만 입력해 주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 450,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.black45,
                          style: BorderStyle.solid,
                          width: 0.8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          hint: const Text('계절'),
                          isExpanded: true,
                          value:
                              selectedDropdown == '' ? null : selectedDropdown,
                          items: dropdownList.map((String item) {
                            return DropdownMenuItem<String>(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                                child: Text('$item'),
                              ),
                              value: item,
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              selectedDropdown = value;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String result = await connectR();
                            _showDialog(context, result);
                          }
                        },
                        child: const Text('시세 예측해 보기')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 입련한 내용을 바탕으로 예측값 보여주기 위한 함수
  // 만든 날짜 : 2022.01.11
  // 만든 사람 : 임은빈
  _showDialog(BuildContext context, String result) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('예측 결과'),
            content:
                Text('전세값은 $result입니다.\n \n데이터 분석을 통한 예측값으로 실제와 다를 수 있습니다.'),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('나가기'))
            ],
          );
        });
  }

  /// R과 연결하기 위해서 만든 함수 (기본틀 만들기)
  /// 만든날짜 : 2023.1.12
  /// 만든이 : 권순형
  Future<String> connectR() async {
    RServices rservices = RServices();
    String result = await rservices.connectDorimdong(
        DongModel.apartNamePredict,
        apartRentalController.text.trim(),
        apartFloorController.text.trim(),
        selectedDropdown!.trim());

    return result;
  }
}
