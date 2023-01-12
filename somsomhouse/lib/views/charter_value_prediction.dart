import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CharterPrediction extends StatefulWidget {
  const CharterPrediction({super.key});

  @override
  State<CharterPrediction> createState() => _CharterPredictionState();
}

class _CharterPredictionState extends State<CharterPrediction> {
  // 계약 계절 드롭박스로 부르기 위해 리스트 작성
  List<String> dropdownList = ['봄', '여름', '가을', '겨울'];
  String? selectedDropdown = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('전세값 예측해 보기'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Text(
                    '아파트이름',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.transparent,
                      shadows: [
                        Shadow(offset: Offset(0, -20), color: Colors.black54)
                      ],
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed,
                      decorationColor: Colors.orange,
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: '임대 면적',
                    labelText: '임대 면적',
                    prefixIcon: const Icon(Icons.content_paste),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '층 수',
                      labelText: '층 수',
                      prefixIcon: const Icon(Icons.show_chart),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
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
                        // icon: Icon(Icons.park),
                        hint: Text('계절'),
                        isExpanded: true,
                        value: selectedDropdown == '' ? null : selectedDropdown,
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
                      onPressed: () => _showDialog(context),
                      child: const Text('시세 예측해 보기')),
                ),
              ],
            ),
          ),
        ),
        // body: Text(Provider.of<FinalViewModel>(context).apartName,),
      ),
    );
  }

  // 입련된 내용을 바탕으로 예측화면 보여주기 위한 함수
  // 만든 날짜 : 2022.01.11
  // 만든 사람 : 임은빈
  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('예측'),
            content: Text('전세값은 ?입니다.'),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('나가기'))
            ],
          );
        });
  }
}
