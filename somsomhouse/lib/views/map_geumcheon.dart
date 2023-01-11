import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Geumcheon extends StatelessWidget {
  const Geumcheon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('금천구 지도'),
      ),
      body: Center(
        child: InkWell(
          splashColor: Colors.orange,
          onTapDown: (TapDownDetails details) {
            _handleTapDown(
                context, details.localPosition.dx, details.localPosition.dy);
          },
          child: Image.asset('images/금천구.png'),
        ),
      ),
    );
  }

  //-----function-------
  _handleTapDown(BuildContext context, var dx, var dy) {
    // final vm = Provider.of<FinalViewModel>(context, listen: false);
    if ((dx > 171 && dx < 208 && dy > 171 && dy < 297) ||
        (dx > 215 && dx < 263 && dy > 120 && dy < 294) ||
        (dx > 272 && dx < 332 && dy > 176 && dy < 261)) {
      // vm.changeDongName('시흥동');
      Navigator.pop(context);
    }
  }

// 이클립스 완성해서 클릭한 동에 해당되는 아파트 이름들 불러오기
//provider 고치기
}//end
