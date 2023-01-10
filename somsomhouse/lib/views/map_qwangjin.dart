import 'package:flutter/material.dart';

class Qwangjin extends StatelessWidget {
  const Qwangjin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('광진구 지도'),
      ),
      body: Center(
        child: InkWell(
          splashColor: Colors.orange,
          onTapDown: (TapDownDetails details) {
            _handleTapDown(
                context, details.localPosition.dx, details.localPosition.dy);
          },
          child: Image.asset('images/광진구.png'),
        ),
      ),
    );
  }

  //-----function-------
  _handleTapDown(BuildContext context, var dx, var dy) {
    // final vm = Provider.of<FinalViewModel>(context, listen: false);
    if ((dx > 200 && dx < 285 && dy > 197 && dy < 229) ||
        (dx > 224 && dx < 296 && dy > 151 && dy < 188) ||
        (dx > 255 && dx < 306 && dy > 102 && dy < 153)) {
      // vm.changeDongName('광장동');
      Navigator.pop(context);
    }
  }
}//end
