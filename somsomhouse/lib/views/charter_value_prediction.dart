import 'package:flutter/material.dart';
import 'package:somsomhouse/models/apartname_predict_model.dart';

class CharterPrediction extends StatefulWidget {
  const CharterPrediction({super.key});

  @override
  State<CharterPrediction> createState() => _CharterPredictionState();
}

class _CharterPredictionState extends State<CharterPrediction> {
  late String name;
  late TextEditingController size;
  late TextEditingController floor;
  late TextEditingController weather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = '';
    size = TextEditingController();
    floor = TextEditingController();
    weather = TextEditingController();
  }

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
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text(
                    ApartNamePredict.apartNamePredict, //앞 페이지에서 선택한 아파트 이름 나옴
                    style: const TextStyle(
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
                  controller: size,
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
                    controller: floor,
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
                TextField(
                  controller: weather,
                  decoration: InputDecoration(
                    hintText: '계약 계절',
                    labelText: '계약 계절',
                    prefixIcon: const Icon(Icons.sunny_snowing),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ElevatedButton(
                      onPressed: () {
                        name = ApartNamePredict.apartNamePredict;
                        size;
                        floor;
                        weather;
                        //이 4개의 값을 넘겨주면 됨.
                      },
                      child: const Text('시세 예측해 보기')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
