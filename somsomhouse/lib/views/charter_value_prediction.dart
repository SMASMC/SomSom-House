import 'package:flutter/material.dart';
import 'package:somsomhouse/models/apartname_predict_model.dart';

class CharterPrediction extends StatefulWidget {
  const CharterPrediction({super.key});

  @override
  State<CharterPrediction> createState() => _CharterPredictionState();
}

class _CharterPredictionState extends State<CharterPrediction> {
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
                    ApartNamePredict.apartNamePredict,
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
                TextField(
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
                        //
                      },
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
}
