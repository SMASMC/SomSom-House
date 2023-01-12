import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SinjungdongPrediction extends StatefulWidget {
  const SinjungdongPrediction({super.key});

  @override
  State<SinjungdongPrediction> createState() => _SinjungdongPredictionState();
}

class _SinjungdongPredictionState extends State<SinjungdongPrediction> {

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
  List <String> dropdownList = ['봄', '여름', '가을', '겨울'];
  String? selectedDropdown = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 121, 119, 166),
        title: const Text('전세값 예측해 보기'),
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
                  padding: EdgeInsets.only(bottom: 50),
                  child:  Text(
                    '아파트이름',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.transparent,
                      shadows: [Shadow(offset: Offset(0, -20),
                      color: Colors.black54)],
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed,
                      decorationColor: Colors.orange,
                    ),
                    ),
                  ),
                TextFormField(
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
                    if (apartRental < 32.76 || apartRental > 131.49) {
                      return '32.76m²부터 131.49m²까지만 입력해 주세요';
                    } 
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
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
                    if (apartFloor < 1 || apartFloor > 22) {
                      return '1층부터 22층까지만 입력해 주세요';
                    } 
                    return null;
                  },
                    ),
                  ),
                const SizedBox(height: 20,),
                Container(
                  width: 450,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black45, style: BorderStyle.solid, width: 0.8
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      // icon: Icon(Icons.park),
                      hint: const Text('계절'),
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
                  const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ElevatedButton( 
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _showDialog(context);
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

  // 입련된 내용을 바탕으로 예측화면 보여주기 위한 함수
  // 만든 날짜 : 2022.01.11  
  // 만든 사람 : 임은빈
  _showDialog(BuildContext context) {
    showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: const Text('예측 결과'),
        content: Text('전세값은 ?입니다.\n \n데이터 분석을 통한 예측값으로 실제와 다를 수 있습니다.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('나가기'))
        ],
      );
    });
  }
}