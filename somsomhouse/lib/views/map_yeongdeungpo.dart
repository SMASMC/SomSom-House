import 'package:flutter/material.dart';

class Yeongdeungpo extends StatelessWidget {
  const Yeongdeungpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영등포구 지도'),
      ),
      body: Center(
        child: InkWell(
          splashColor: Colors.orange,
          onTapDown: (TapDownDetails details) {
            _handleTapDown(
                context, details.localPosition.dx, details.localPosition.dy);
          },
          child: Image.asset(
            'images/영등포구.png',
            height: 350,
            width: 500,
          ),
        ),
      ),
    );
  }

//-----function-------
  _handleTapDown(BuildContext context, var dx, var dy) {
    // final vm = Provider.of<FinalViewModel>(context, listen: false);
    if ((dx > 115 && dx < 153 && dy > 201 && dy < 234) ||
        (dx > 155 && dx < 194 && dy > 197 && dy < 214)) {
      // vm.changeDongName('도림동');
      Navigator.pop(context);
    }
  }
}//end
